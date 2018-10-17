import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sms/flutter_sms.dart';

var phoneNumber;
String accessToken;
String authCode;
String _serviceUrl =
    'https://yime.herokuapp.com/api/friendrequest/create'; //schedule, available, friend and me(coming soon)
final _headers = {
  'Authorization': authCode,
  'Content-Type': 'application/json'
};


class FriendRequest extends StatefulWidget {
  FriendRequest(String x){
    authCode = x;
  }

  @override
  _FriendRequestState createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showErrMessage(String message, Color c) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(backgroundColor: c, content: Text(message)));
  }

  Future<dynamic> _submitForm() async {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showErrMessage('Invalid! Number must be 10 digits long.', Colors.red);
    } else {
      form.save();
      try {
        var mapData = new Map();
        mapData["phonenumber"] = phoneNumber;
        var data = json.encode(mapData);
        final response =
        await http.post(Uri.encodeFull(_serviceUrl), headers: _headers, body: data);
        var d= response.statusCode;
        print(d);
        var e= jsonDecode(response.body);
        print(e);
        return e;
      } catch (e) {
        print('Server Exception!!! on getinfo ');
        //print(e);
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
                  Center(child: Text("Let's add some freinds!", style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0))),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter the phone number',
                      labelText: 'Phone number',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (num) => num.length < 10
                        ? 'Number must be 10 digits long'
                        : null,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    onSaved: (num) => phoneNumber=num,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FlatButton.icon(
                          onPressed:()=> _submitForm().then((onValue){
                            if(onValue.toString() =='{userExists: false}'){
                              displayDialogue();
                            }
                            else{
                              showErrMessage(onValue['message'].toString(), Colors.brown);
                            }

                          }),
                          icon: Icon(
                            Icons.send,
                          ),
                          label: Text("Send request")),
                    ),
                  )
                ]),
              ))),
        ),
      ),
    );
  }

  void displayDialogue() {
    //show dialogue will build an alert dialogue
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Friend not found!"),
            content: Text("Would you like to invite?"),
            //the actions of the alert dialogue
            actions: <Widget>[
              FlatButton(
                  //on pressed sends text
                  onPressed: () {
                    _sendSMS("Hey! Won't you join me on yime.app ?", ["$phoneNumber"]);
                    Navigator.pop(context);
                  },
                  child: Text("Yes")),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No"))
            ],
          );
        });
  }
  //sends text!
  Future<dynamic> _sendSMS(String message, List<String> recipents) async {
    String _result =
    await FlutterSms.sendSMS(message: message, recipients: recipents);
    //setState(() => _message = _result);
    print(_result);
  }

}
