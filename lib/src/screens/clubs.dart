import 'package:flutter/material.dart';
import '../colors/allcolors.dart';

AppColors c = AppColors();

class Clubs extends StatefulWidget {
  @override
  _ClubsState createState() => _ClubsState();
}

//clubs that users are currently in
Widget currentlyIn(){
  return FractionallySizedBox(
    widthFactor: 0.9,
    child: Container(
        color: c.maxWhite,
        height: 49.83,
        child: ListTile(
          title: Text(
            "Club Name",
            style: TextStyle(color: c.black),
          ),
          onTap: () {},
          trailing: Icon(Icons.close),
        )),
  );
}

//all the clubs
Widget allClubs(){
  return FractionallySizedBox(
    widthFactor: 0.9,
    child: Container(
        color: c.maxWhite,
        height: 49.83,
        child: ListTile(
          title: Text(
            "Club Name",
            style: TextStyle(color: c.black),
          ),
          onTap: () {},
          trailing: Icon(Icons.add),
        )),
  );
}

class _ClubsState extends State<Clubs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 47.0),
                child: Text("Currently In",),
              ),
              Divider(),
              currentlyIn()
            ],
          ),
          Column(
            children: <Widget>[
              Text("All"),
              Divider(),
              allClubs()
            ],
          )

        ],
      ),
    );
  }
}
