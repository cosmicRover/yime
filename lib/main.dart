import './pages/bottomnav.dart';
import './pages/freenowpage.dart';
import './pages/wsinitial.dart';

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
        '/bottomnav': (context) => BottomNavigation(),
        '/freenow': (context) => FreeNow(),
      },
      home: BottomNavigation(),
      //disabling the debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}
