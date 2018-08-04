import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'logdetails.dart'; //for the login phone number
import 'submitlog.dart'; //this is to submit stuff to api
import 'bottomnav.dart';

SignUpDetails newSignup = SignUpDetails();
//creating a handler for SignUpDetails()
SaveLoadAccessToken saveKey = SaveLoadAccessToken();
String globalToken;

class SignUp extends StatefulWidget {
  //signUp takes a string token as parameter
  SignUp(String token) {
    globalToken = token;
  } //token is then assigned to globalToken so that it can be accessed

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  //the submit form function
  void _submitForm() async {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showErrMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save();
      //var signUpService = SignUpService();
      //signUpService.createSignUp(newSignup).then((value)=> showMessage('Logged in'));
      newSignup.token = globalToken;
      print(newSignup.token);
      var signup = SignUpService();
      signup.createSignUp(newSignup).then((value) {
        if (value.length == 173) {
          saveKey.savedTokenPreference(value).then((onValue) {
            //saving key and pushing to a new screen with no back
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/bottomnav', (Route<dynamic> route) => false);
          });
        } else {
          //will think of something
        }
      });
      //navigate to bottom navigation
    }
  }

  void showErrMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
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
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter the code',
                            labelText: 'Code',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (num) =>
                              num.isEmpty ? 'Code is required' : null,
                          inputFormatters: [
                            //WhitelistingTextInputFormatter(new RegExp(r'^[()\d -]{1,15}$')),
                            LengthLimitingTextInputFormatter(6),
                          ],
                          onSaved: (num) => newSignup.code = num,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            labelText: 'Name',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (name) =>
                              name.isEmpty ? 'Name is required' : null,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(16),
                          ],
                          onSaved: (name) => newSignup.name = name,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: FlatButton.icon(
                                onPressed: _submitForm,
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.yellow[700],
                                ),
                                label: Text("Sign Up")),
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
