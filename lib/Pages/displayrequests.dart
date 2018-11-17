import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//In this page, I'm attempting to retrieve all the friends that are online

String accessToken;
String authCode;
var requests = 0;

String _serviceUrl =
    'https://yime.herokuapp.com/api/friendrequest'; //schedule, available, friend and me(coming soon)
final _headers = {
  'Authorization': authCode,
  'Content-Type': 'application/json'
};

class DisplayFriendRequest extends StatefulWidget {

  DisplayFriendRequest(String x){
    authCode = x;
  }

  @override
  DisplayFriendRequestState createState() => new DisplayFriendRequestState();
}

//this class indicates the values that we will be using on the app
class User {
  String name, phonenumber;
  int id;
  User({this.name, this.phonenumber, this.id});
}

//getting the json data from the api
class DisplayFriendRequestState extends State<DisplayFriendRequest> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<User>> fetchUsersFromGitHub() async {
    try {
      final response =
          await http.get(Uri.encodeFull(_serviceUrl), headers: _headers);
      var c = jsonDecode(response.body);
      print(c);
      List responseJson = c;
      print("data retrieved $c");
      List<User> userList = createUserList(responseJson);
      //built in sorting algorithm on dart
      userList.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
      return userList;
    } catch (e) {
      print('Server Exception!!! on getinfo ');
      print(e);
      return e;
    }
  }

  var addedOnline = false;
//creating a list of users with three values retrieved from api
  List<User> createUserList(List data) {
    List<User> list = List();
    for (int i = 0; i < data.length; i++) {
      String title = data[i]["name"];
      String phonenumber = data[i]["phonenumber"];
      int id = data[i]["id"];
      User user = User(name: title, phonenumber: phonenumber, id: id);
      list.add(user);
    }
    if (addedOnline == false) {
      addedOnline = true;
      setState(() {
        requests = list.length;
        print("set called");
      });
    }
    return list;
  }

  void showErrMessage(String message, Color c) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(backgroundColor: c, content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(
            primarySwatch: Colors.yellow,
            canvasColor: Colors.white,
            splashColor: Colors.yellow),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Yime"),
          ),
          body: Stack(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 35.0, left: 8.0),
                child: Text(
                  "Friend Requests: $requests",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45.0, left: 8.0),
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
                                    ListTile(
                                      leading: Icon(
                                        Icons.person_add,
                                        color: Colors.yellow[700],
                                      ),
                                      title: Text(snapshot.data[index].name),
                                      subtitle: Text(
                                          snapshot.data[index].phonenumber),
                                      onTap: () {
                                        mainBottomSheet(
                                            context, snapshot.data[index].id);
                                      }, //id being passed for profile request
                                    ),
                                    //Divider()
                                  ]);
                            });
                      } else if (snapshot.hasError) {
                        //if the snapshot has error
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Are you connected to the internet?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0),
                              ),
                            ),
                            FlatButton.icon(
                                onPressed: (){
                                  setState(() {
                                    fetchUsersFromGitHub();
                                  });
                                },
                                icon: Icon(Icons.refresh),
                                label: Text("Tap to refresh"))
                          ],
                        );
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

  Future<dynamic> answerRequest(int x, bool y) async {
    const _serviceUrl =
        'https://yime.herokuapp.com/api/friendrequest/'; //schedule, available, friend and me(coming soon)
    final _headers = {
      'Authorization': authCode,
      'Content-Type': 'application/json'
    };

    var mapData = new Map();
    mapData["id"] = x;
    mapData["accept"] = y;
    var data = jsonEncode(mapData);

    try {
      final response =
          await http.post(_serviceUrl, headers: _headers, body: data);
      var c = response.statusCode; //do we get the access token now?
      print(c);
      return c;
    } catch (e) {
      var y = 'failed';
      print("server exception on create signup");
      print(e);
      return y;
    }
  }

  //takes context and int id from snapshot
  //can this be used to set state on schedule page??
  mainBottomSheet(BuildContext context, int x) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.check),
                title: Text("Accept"),
                //onTap needs navigator.pop
                //on tap will navigate to the page where profile can be viewed

                onTap: () => answerRequest(x, true).then((onValue) {
                      Navigator.pop(context);
                      print("response $onValue");
                     if(onValue== 200){
                       setState(() {
                         fetchUsersFromGitHub();
                         requests--;
                       });
                     }
                     else{
                       setState(() {
                         fetchUsersFromGitHub();
                       });
                       showErrMessage("Something went wrong", Colors.red);
                     }
                    }),
              ),
              ListTile(
                leading: Icon(Icons.clear),
                title: Text("Decline"),
                //onTap needs navigator.pop
                //on tap will navigate to the page where profile can be viewed

                onTap: () => answerRequest(x, false).then((onValue) {
                      Navigator.pop(context);
                      print("response $onValue");
                      setState(() {
                        if(onValue== 200){
                          setState(() {
                            fetchUsersFromGitHub();
                            requests--;
                          });
                        }
                        else{
                          setState(() {
                            fetchUsersFromGitHub();
                          });
                          showErrMessage("Something went wrong", Colors.red);
                        }
                      });
                    }),
              )
            ],
          );
        });
  }
}
