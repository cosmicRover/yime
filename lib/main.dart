
import './pages/bottomnav.dart';
import './pages/intropage.dart';
import './pages/schedule.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(Yime());

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
        '/schedule': (context) => SetSchedule(),
        '/bottomnav': (context) => BottomNavigation(),
      },
      home: IntroPage(),
      //disabling the debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}
