import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//In this page, I'm attempting to retrieve all the friends that are online
class Friends extends StatefulWidget {
  @override
  FriendsState createState() => new FriendsState();
}

//this class indicates the values that we will be using on the app
class User {
  String name, status;
  int id;
  //bool admin;
  //custom defined constructor referencing all of it's defined variables
  User({this.name, this.id, this.status});
}

//getting the json data from the api
class FriendsState extends State<Friends> {
  static String accessToken;
  static String authCode;
  var totalFriends = 0;

  static const _serviceUrl =
      'https://yime.herokuapp.com/api/friend'; //schedule, available, friend and me(coming soon)
  static final _headers = {
    'Authorization': authCode,
    'Content-Type': 'application/json'
  };

  Future<List<User>> fetchUsersFromGitHub() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString("accesstoken");
    print("accesstoken retreived");
    authCode = 'Bearer ' +
        accessToken; //adding bearer to accesscode for security reason
    print(authCode);

    try {
      final response =
          await http.get(Uri.encodeFull(_serviceUrl), headers: _headers);
      var c = jsonDecode(response.body);
      List responseJson = c["friends"];
      print("data retrieved");
      List<User> userList = createUserList(responseJson);
      //dart sorting algorithm for userList
      //a and b points to two points in which to compare to
      userList.sort((a,b){
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
      return userList;
    } catch (e) {
      print('Server Exception!!! on getinfo ');
      print(e);
      return e;
    }
  }

  var addedFriends = false;
//creating a list of users with three values retrieved from api
  List<User> createUserList(List data) {
    List<User> list = List();
    list.sort();
    for (int i = 0; i < data.length; i++) {
      String title = data[i]["name"];
      String status = data[i]["status"];
      int id = data[i]["id"];
      User user = User(name: title, id: id, status: status);
      list.add(user);
    }

    if (addedFriends == false) {
      addedFriends = true;
      setState(() {
        totalFriends = list.length;
        print("set called");
      });
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    //custom widget for list tile which allows if statements
    Widget buildList(String x, y, z) {
      if (x == 'available') {
        return ListTile(
          leading: Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          title: Text(y),
          subtitle: Text(z),
          onTap: () => print("pressed"),
        );
      } else {
        return ListTile(
          leading: Icon(
            Icons.person,
            color: Colors.yellow[700],
          ),
          title: Text(y),
          subtitle: Text(z),
          onTap: () => print("pressed-else"),
        );
      }
    }

    return new Material(
      child: Theme(
        data: ThemeData(
            primarySwatch: Colors.yellow,
            canvasColor: Colors.white,
            splashColor: Colors.yellow),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Yime"),
          ),
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "All friends: $totalFriends",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 8.0),
                child: Container(
                  //future builder takes same parameter as http.get function
                  child: FutureBuilder<List<User>>(
                    future: fetchUsersFromGitHub(), //calling the fetch function
                    builder: (context, snapshot) {
                      //builder takes context and snapshot
                      if (snapshot.hasData) {
                        //if the snapshot contains data
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    buildList(
                                        snapshot.data[index].status,
                                        snapshot.data[index].name,
                                        snapshot.data[index].id.toString()),
                                    //Divider()
                                  ]);
                            });
                      } else if (snapshot.hasError) {
                        //if the snapshot has error
                        return Text("${snapshot.error}");
                      }
                      // By default, show a linear progress indicator
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: LinearProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
