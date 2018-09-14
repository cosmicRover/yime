import './mepage.dart';
import './freenowpage.dart';
import './friendspage.dart';
import './login.dart';
import './submitlog.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//handler for accesskey class

class BottomNavigation extends StatefulWidget {
  @override
  BottomNavigationState createState() => new BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  //setting up variables and class handlers for functions from other dart files
  //currentTab determines at what icon the app starts with, 0 being home
  int currentTab = 1;
  //home, prices, maps, rules, events are classes from other dart files
  Me one;
  FreeNow two;
  Friends three;

  List<Widget> pages;
  //the widget will be connected to currentPage
  Widget currentPage;

  //overriding the initState()
  @override
  void initState() {
    //using the class handlers, assigning them functions from their respective classes
    one = Me();
    two = FreeNow();
    three = Friends();
    //list pages will take the above values as arguments
    pages = [one, two, three];
    //current page is set to one so that app starts from home
    currentPage = two;
    //loadKey.getTokenPreference().then(upDateKey);//loading the accesskey from disk
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(
            splashColor: Colors.red,
        ),
        child: Scaffold(
          body: currentPage,
          bottomNavigationBar: BottomNavigationBar(
              fixedColor: Colors.black,
              currentIndex: currentTab,
              onTap: (int index) {
                setState(() {
                  currentTab = index;
                  currentPage = pages[index];
                });
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      color: Colors.yellow[900],
                    ),
                    title: Text(
                      "Me",
                      style: TextStyle(color: Colors.black),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.free_breakfast,
                      color: Colors.yellow[900],
                    ),
                    title: Text(
                      "Free now",
                      style: TextStyle(color: Colors.black),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.people,
                      color: Colors.yellow[900],
                    ),
                    title: Text(
                      "Friends",
                      style: TextStyle(color: Colors.black),
                    )),
              ]),
        ),
      ),
    );
  }
}
