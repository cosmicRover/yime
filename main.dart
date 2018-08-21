import './pages/mepage.dart';
import './pages/freenowpage.dart';
import './pages/friendspage.dart';
import './pages/bottomnav.dart';
import './pages/login.dart';
import './pages/entercode.dart';
import './pages/signup.dart';
import './pages/submitlog.dart';
import './pages/intropage.dart';


import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main()=> runApp(Yime());

class Yime extends StatefulWidget {
  @override
  _YimeState createState() => _YimeState();
}

class _YimeState extends State<Yime> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yime',
      routes: {
        '/bottomnav': (context) => BottomNavigation(),
      },
      home: IntroPage(),
    );
  }
}

