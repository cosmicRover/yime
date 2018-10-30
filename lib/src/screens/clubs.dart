import 'package:flutter/material.dart';

class Clubs extends StatefulWidget {
  @override
  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clubs"),),
      body: ListView(
        children: <Widget>[
          Text("Clubs")
        ],
      ),
    );
  }
}
