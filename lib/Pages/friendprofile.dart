import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String accessToken;
String authCode;
String friendId;

String _serviceUrl;
final _headers = {
  'Authorization': authCode,
  'Content-Type': 'application/json'
};

Future<Post> fetchPost() async {
  print("url for friend " + _serviceUrl);
  final response =
      await http.get(Uri.encodeFull(_serviceUrl), headers: _headers);
  print(response.body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final String name, phonenumber, timezone;
  var schedule;

  Post({this.name, this.phonenumber, this.timezone, this.schedule});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        name: json['name'],
        phonenumber: json['phonenumber'],
        timezone: json['timezone'],
        schedule: json['schedule'] //even lists work
        );
  }
}

class FriendProfile extends StatefulWidget {
  FriendProfile(String x, y) {
    friendId = x;
    authCode = y;
    _serviceUrl = 'https://yime.herokuapp.com/api/friend/$friendId';
  }

  @override
  _FriendProfileState createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  var cardStyle = TextStyle(fontWeight: FontWeight.bold);
  var cardStyleWhite=TextStyle(fontWeight: FontWeight.bold, color: Colors.white);

  buildCard(BuildContext context, String day, List hours) {
    if (hours.length == 0) {
      return Card(
        child: ListTile(
          title: Text(day),
          subtitle: Text(
            "Not free today",
            style: cardStyle,
          ),
        ),
      );
    } else {
      List<String> values = [];
      for (int i = 0; i < hours.length; i++) {
        if (hours[i] < 13) {
          values.add('${hours[i]} am');
        } else if (hours[i] > 12) {
          values.add('${hours[i] - 12} pm');
        }
      }

      String transForm = '';
      for (int i = 0; i < values.length; i++) {
        if (i == values.length - 1) {
          transForm = transForm + values[i] + '. ';
        } else {
          transForm = transForm + values[i] + ', ';
        }
        print(transForm);
      }

      return Card(
        color: Colors.green,
        child: ListTile(
          title: Text(day, style: cardStyleWhite,),
          subtitle: Text(
            transForm,
            style: cardStyleWhite,
          ),
        ),
      );
    }
  }

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
                  Divider(),
                  Column(
                    children: <Widget>[
                      buildCard(
                          context, "Monday", snapshot.data.schedule['monday']),
                      buildCard(context, "Tuesday",
                          snapshot.data.schedule['tuesday']),
                      buildCard(context, "Wednesday",
                          snapshot.data.schedule['wednesday']),
                      buildCard(context, "Thursday",
                          snapshot.data.schedule['thursday']),
                      buildCard(
                          context, "Friday", snapshot.data.schedule['friday']),
                      buildCard(context, "Saturday",
                          snapshot.data.schedule['saturday']),
                      buildCard(
                          context, "Sunday", snapshot.data.schedule['sunday']),
                    ],
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Are you connected to the internet?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28.0),
                    ),
                  ),
                  FlatButton.icon(
                      onPressed: () {
                        setState(() {
                          fetchPost();
                        });
                      },
                      icon: Icon(Icons.refresh),
                      label: Text("Tap to refresh"))
                ],
              );
            }
            // By default, show a loading spinner
            return LinearProgressIndicator();
          },
        ),
      ),
    );
  }
}
