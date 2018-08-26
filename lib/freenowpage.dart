import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//In this page, I'm attempting to retrieve all the friends that are online
class FreeNow extends StatefulWidget {
  @override
  FreeNowState createState() => new FreeNowState();
}

//this class indicates the values that we will be using on the app
class User {
  String name;
  int id;
  //bool admin;
  //custom defined constructor referencing all of it's defined variables
  User({this.name, this.id});
}

//getting the json data from the api
class FreeNowState extends State<FreeNow> {
  static String accessToken;
  static String authCode;
  int onlineFriends = 0;

  static const _serviceUrl =
      'https://yime.herokuapp.com/api/available'; //schedule, available, friend and me(coming soon)
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
      List responseJson = c["available"];
      print("data retrieved");
      List<User> userList = createUserList(responseJson);
      return userList;
    } catch (e) {
      print('Server Exception!!! on getinfo ');
      print(e);
      return e;
    }
  }

//creating a list of users with three values retrieved from api
  List<User> createUserList(List data) {
    List<User> list = List();
    for (int i = 0; i < data.length; i++) {
      String title = data[i]["name"];
      //String node = data[i]["node_id"];
      int id = data[i]["id"];
      //bool admin = data[i]["site_admin"];
      //checking to see if an user is admin. Same process goes for online status
      //if(admin == true){
      User user = User(name: title, id: id);
      //if admin, add user to the list
      list.add(user);
      //}
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
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
                  "Online: $onlineFriends",
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
                        return new ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                      title: Text(snapshot.data[index].name),
                                      subtitle: Text(
                                          snapshot.data[index].id.toString()),
                                      onTap: () => print("pressed"),
                                    ),
                                    //Divider()
                                  ]);
                            });
                      } else if (snapshot.hasError) {
                        //if the snapshot has error
                        return new Text("${snapshot.error}");
                      }
                      // By default, show a linear progress indicator
                      return new LinearProgressIndicator();
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

//setting the value for onlineFriends
  @override
  void initState() {
    super.initState();
    fetchUsersFromGitHub().then((onValue) {
      //awaits for function then
      setState(() {
        onlineFriends = onValue.length;
      });
    });
  }
}
