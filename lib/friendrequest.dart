import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FriendRequest extends StatefulWidget {
  @override
  _FriendRequestState createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var phoneNumber;

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
      print("mapping and submitting number $phoneNumber");
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
                            //if no error, show this
                            showErrMessage("Request sent!", Colors.green);
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
}
