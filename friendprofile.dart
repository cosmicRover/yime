import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String accessToken;
String authCode;
String friendId;
String _serviceUrl = 'https://yime.herokuapp.com/api/friend/$friendId';
final _headers = {
  'Authorization': authCode,
  'Content-Type': 'application/json'
};

String testing;

Future<Post> fetchPost() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  accessToken = prefs.getString("accesstoken");
  print("accesstoken retreived");
  authCode =
      'Bearer ' + accessToken; //adding bearer to accesscode for security reason
  print(authCode);

  final response =
      await http.get(Uri.encodeFull(_serviceUrl), headers: _headers);
  print(response.body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    testing='hello';
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  //final int userId;
  //final int id;
  final String name, phonenumber, timezone;

  Post({this.name, this.phonenumber, this.timezone});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        name: json['name'],
        phonenumber: json['phonenumber'],
        timezone: json['timezone']
        //schedule: json['schedule']
        );
  }
}

class FriendProfile extends StatefulWidget {

  FriendProfile(String x){
    friendId=x;
  }

  @override
  _FriendProfileState createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          canvasColor: Colors.white,
          splashColor: Colors.yellow),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Yime'),
        ),
        body: FutureBuilder<Post>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      snapshot.data.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 35.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Phone number: " + snapshot.data.phonenumber,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Timezone: " + snapshot.data.timezone,
                        style: TextStyle(fontSize: 20.0)),
                  ),
                  Text(testing)
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return LinearProgressIndicator();
          },
        ),
      ),
    );
  }
}
