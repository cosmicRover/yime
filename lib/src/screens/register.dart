import 'package:flutter/material.dart';
import '../colors/allcolors.dart';

AppColors c = AppColors();//needs some color fixing

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                  "YIME",
                  style: TextStyle(fontSize: 57.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "make new friends",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0, color: c.darkerGrey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 41.0, bottom: 41.0),
                child: Text(
                  "so what's your...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22.0,
                      color: c.darkerGrey2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 23.0, right: 23.0),
                child: Form(
                    child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Your Name',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 33.0, bottom: 33.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Your College',
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Friend Code (optional)',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ],
                )),
              ),
            ],
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 35.17),
                child: Container(
                  width: 159.0,
                  height: 49.83,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(46.0)),
                      color: c.purple),
                  child: FlatButton(
                      onPressed: () {},
                      child: Text("REGISTER", style: TextStyle(color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
