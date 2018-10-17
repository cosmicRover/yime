import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

String name;
String accessToken;
String authCode;
String _serviceUrl = 'https://yime.herokuapp.com/api/me';
final _headers = {
  'Authorization': authCode,
  'Content-Type': 'application/json'
};


class ChangeName extends StatefulWidget {

  ChangeName(String y) {
    authCode = y;
  }

  @override
  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showErrMessage(String message, Color c) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(backgroundColor: c, content: Text(message)));
  }

  Future<dynamic> _submitForm() async {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showErrMessage('Invalid Name! ', Colors.red);
    } else {
      form.save();
      try {
        var mapData = new Map();
        mapData["name"] = name;
        var data = json.encode(mapData);
        final response = await http.post(Uri.encodeFull(_serviceUrl),
            headers: _headers, body: data);
        var c = response.statusCode;
        print("response is $c");
        return c;
      } catch (e) {
        print('Server Exception!!! on getinfo ');
        print(e);
        return e;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(
          primarySwatch: Colors.yellow,
          canvasColor: Colors.white,
          splashColor: Colors.yellow,
        ),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Yime"),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                  child: Form(
                key: _formKey,
                autovalidate: true,
                child: ListView(children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter your new name',
                      labelText: 'Name',
                    ),
                    keyboardType: TextInputType.text,
                    validator: (txt) => txt.length < 3
                        ? 'Name requires at least three characters'
                        : null,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(14),
                    ],
                    onSaved: (txt) => name = txt,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FlatButton.icon(
                          onPressed: () => _submitForm().then((onValue) {
                                if (onValue == 200) {
                                  showErrMessage("Name Updated", Colors.green);
                                } else {
                                  showErrMessage(
                                      "Something went wrong", Colors.red);
                                }
                              }),
                          icon: Icon(
                            Icons.send,
                          ),
                          label: Text("Update name")),
                    ),
                  )
                ]),
              ))),
        ),
      ),
    );
  }
}
