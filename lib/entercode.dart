import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'logdetails.dart'; //for the login phone number
import 'submitlog.dart'; //this is to submit stuff to api

EnterCodeLoginDetails newCodeLogin = EnterCodeLoginDetails();
SaveLoadAccessToken saveKey = SaveLoadAccessToken();
//creating a handler for EnterCodeDetails()
String globalToken;

class EnterCode extends StatefulWidget {
  //signUp takes a string token as parameter
  EnterCode(String token) {
    globalToken = token;
  } //token is then assigned to globalToken so that it can be accessed
  //token string will be passed by material page route

  @override
  _EnterCodeState createState() => _EnterCodeState();
}

class _EnterCodeState extends State<EnterCode> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  //the submit form function
  void _submitForm() async {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showErrMessage('Incorrect code, please review.');
    } else {
      form.save();
      //var signUpService = SignUpService();
      //signUpService.createSignUp(newSignup).then((value)=> showMessage('Logged in'));
      newCodeLogin.token = globalToken;
      var codeLogin = EnterCodeLoginService();
      codeLogin.createCodeLogin(newCodeLogin).then((value) {
        if (value == "error" || value == null || value == 'failed') {
          showErrMessage('Error! Please retry');
        } else {
          saveKey.savedTokenPreference(value).then((onValue) {
            //saving key and pushing to a new screen with no back
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/bottomnav', (Route<dynamic> route) => false);
          });
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
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.yellow,
        canvasColor: Colors.white,
        splashColor: Colors.yellow,
      ),
      child: Material(
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
                        Center(
                            child: Text(
                              "Welcome back!",
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                            )),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter the code',
                            labelText: 'Code',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (num) => num.length < 6
                              ? '6 digit Code is required'
                              : null,
                          inputFormatters: [
                            //WhitelistingTextInputFormatter(new RegExp(r'^[()\d -]{1,15}$')),
                            LengthLimitingTextInputFormatter(6),
                          ],
                          onSaved: (num) => newCodeLogin.code = num,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: FlatButton.icon(
                                onPressed: _submitForm,
                                icon: Icon(Icons.send),
                                label: Text("Log In")),
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
