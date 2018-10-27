import 'package:flutter/material.dart';
import '../colors/allcolors.dart';

AppColors c = AppColors();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(
          canvasColor: c.lightGrey,
        ),
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 46.0),
                child: Text(
                  "Yime",
                  style: TextStyle(fontSize: 57.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "make new friends",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 77.0, right: 77.0, top: 45.0),
                child: Text(
                  "anonymously chat with new people on campus",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 103.0, bottom: 33.0),
                child: Text(
                  "Login with ...",
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 204.0,
                    height: 49.83,
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        color: c.maxWhite),
                    child: FlatButton.icon(
                        onPressed: () {},
                        icon: Image.asset("pics/google.png",),
                        label: Text("Google")),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 21.17),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 204.0,
                      height: 49.83,
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          color: c.maxWhite),
                      child: FlatButton.icon(
                          onPressed: () {},
                          icon: Image.asset("pics/snapchat.png"),
                          label: Text("Snapchat")),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 21.17),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 204.0,
                      height: 49.83,
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          color: c.maxWhite),
                      child: FlatButton.icon(
                          onPressed: () {},
                          icon: Image.asset("pics/facebook.png"),
                          label: Text("Facebook")),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
