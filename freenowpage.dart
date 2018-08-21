import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//In this page, I'm attempting to retrieve all the friends that are online
class FreeNow extends StatefulWidget {
  @override
  _FreeNowState createState() => new _FreeNowState();
}

//this class indicates the values that we will be using on the app
class User {
  String name, node;
  int id;
  bool admin;
  //custom defined constructor referencing all of it's defined variables
  User({this.name, this.id, this.node, this.admin});
}

//getting the json data from the api
Future<List<User>> fetchUsersFromGitHub() async {
  final response = await http.get('https://api.github.com/users');
  List responseJson = json.decode(response.body);
  List<User> userList = createUserList(responseJson);
  return userList;
}

//creating a list of users with three values retrieved from api
List<User> createUserList(List data) {
  List<User> list = List();
   for (int i = 0; i < data.length; i++) {
     String title = data[i]["login"];
     String node = data[i]["node_id"];
     int id = data[i]["id"];
     bool admin = data[i]["site_admin"];
     //checking to see if an user is admin. Same process goes for online status
     if(admin == true){
       User user = User(name: title, id: id, node: node, admin: admin);
       //if admin, add user to the list
       list.add(user);
     }
   }
  return list;
}

class _FreeNowState extends State<FreeNow> {
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
          body: Container(
            //future builder takes same parameter as http.get function
            child: FutureBuilder<List<User>>(
              future: fetchUsersFromGitHub(),//calling the fetch function
              builder: (context, snapshot) {//builder takes context and snapshot
                if (snapshot.hasData){//if the snapshot contains data
                  return new ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.check_circle, color: Colors.green,),
                                title: Text(snapshot.data[index].name),
                                subtitle: Text(snapshot.data[index].node),
                                onTap: () => print("pressed!"),
                              ),
                              //Divider()
                            ]);
                      });
                } else if (snapshot.hasError) {//if the snapshot has error
                  return new Text("${snapshot.error}");
                }
                // By default, show a linear progress indicator
                return new LinearProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}






