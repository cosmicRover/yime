import './pages/bottomnav.dart';
import './pages/freenowpage.dart';
import './pages/intropage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './src/screens/login.dart';
import './src/screens/register.dart';
import './src/screens/messages.dart';
import './src/screens/chatscreen.dart';

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
      home: ChatScreen(),
      //disabling the debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}
