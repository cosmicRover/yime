import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'logdetails.dart'; //for the login phone number
import 'submitlog.dart'; //this is to submit stuff to api
import 'signup.dart';
import 'entercode.dart';

LogInDetails newLogin = LogInDetails(); //creating a handler for LogInDetails()

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void showErrMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(backgroundColor: color, content: Text(message)));
  }

  //the submit form function
  void _submitForm() async {
    final FormState form = _formKey.currentState;

    //checking to see if the form's requirements been met
    if (!form.validate()) {
      showErrMessage('Invalid! Number must be 10 digits long.');
    } else {
      form.save();
      var contactService = ContactService();
      contactService.createContact(newLogin).then((value) {
        bool status = contactService.getStatus();
        print(status);
        if (status == null) {
          //the registration status decides which path to go to
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EnterCode(value)));
        } else if (status == true) {
          print(value);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUp(value)));
        }
        //this else if can't work because server returns null when unavailable
        else if (status == false) {
          showErrMessage('Are you connected to the interent?');
        }
      });
      //the value is returned by the createContact function which is being passed to SignUp function
    }
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
                  Center(
                      child: Text(
                    "Let's Start",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  )),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                      labelText: 'Phone number',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (num) => num.length < 10
                        ? 'Number must be 10 digits long'
                        : null,
                    inputFormatters: [
                      //WhitelistingTextInputFormatter(new RegExp(r'^[()\d -]{1,15}$')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    onSaved: (num) => newLogin.phonenumber = num,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FlatButton.icon(
                          onPressed: _submitForm,
                          icon: Icon(
                            Icons.send,
                          ),
                          label: Text("Login")),
                    ),
                  )
                ]),
              ))),
        ),
      ),
    );
  }
}
