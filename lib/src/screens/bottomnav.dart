import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';

import 'messages.dart';
import 'clubs.dart';
import '../colors/allcolors.dart';
import 'drawer.dart';

AppColors c = AppColors();
DrawersElements drawers = DrawersElements();
var appBarTitle = "Messages";

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTab = 0;
  Messages one;
  Clubs two;

  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    one = Messages();
    two = Clubs();
    pages = [one, two];
    currentPage = one;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$appBarTitle",),backgroundColor: c.purple,),
      drawer: drawers.buildDrawers(context),
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: (int index) {
            setState(() {
              currentTab = index;
              currentPage = pages[index];
              index == 0 ? appBarTitle = "Messages" : appBarTitle = "Clubs";
              //if 0, set to Messages, if  not, Clubs
            });
          },
          fixedColor: c.purple,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.message),
                title: Text(
                  "Messages",
                  style: TextStyle(color: c.black),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.people),
                title: Text("Clubs", style: TextStyle(color: c.black))),
          ]),
    );
  }
}
