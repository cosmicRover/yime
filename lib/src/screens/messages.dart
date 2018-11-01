import 'package:flutter/material.dart';
import '../colors/allcolors.dart';
import 'drawer.dart';

AppColors c = AppColors();
DrawersElements drawers = DrawersElements();

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

Widget messageList(bool online, var userName, bool hasUnreadMessage) {
  if (online == true) {
    if (hasUnreadMessage == true) {
      return Wrap(
        children: <Widget>[
          Container(
            color: c.lightGreen,
            height: 50.0,
            width: 4.0,
          ),
          //FractionallySized box detects the height and weight of the view
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
                color: c.purple,
                //width: 331.0,
                height: 49.83,
                child: ListTile(
                  title: Text(
                    "$userName",
                    style: TextStyle(color: c.maxWhite),
                  ),
                  onTap: () {},
                  trailing: Text(
                    "5",
                    style: TextStyle(color: c.maxWhite),
                  ),
                )),
          )
        ],
      );
    } else {
      return Wrap(
        children: <Widget>[
          Container(
            color: c.lightGreen,
            height: 50.0,
            width: 4.0,
          ),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
                color: c.maxWhite,
                width: 300.0,
                height: 49.83,
                child: ListTile(
                  title: Text(
                    "$userName",
                    style: TextStyle(color: c.lightBlack),
                  ),
                  onTap: () {},
                  //trailing: Text("5", style: TextStyle(color: Colors.white),),
                )),
          )
        ],
      );
    }
  }
  if (online == false) {
    if (hasUnreadMessage == true) {
      return Wrap(
        children: <Widget>[
          Container(
            color: c.lighterGrey,
            height: 50.0,
            width: 4.0,
          ),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
                color: c.purple,
                width: 300.0,
                height: 49.83,
                child: ListTile(
                  title: Text(
                    "$userName",
                    style: TextStyle(color: c.maxWhite),
                  ),
                  onTap: () {},
                  trailing: Text(
                    "5",
                    style: TextStyle(color: c.maxWhite),
                  ),
                )),
          )
        ],
      );
    } else {
      return Wrap(
        children: <Widget>[
          Container(
            color: c.lighterGrey,
            height: 50.0,
            width: 4.0,
          ),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
                color: c.maxWhite,
                width: 300.0,
                height: 49.83,
                child: ListTile(
                  title: Text(
                    "$userName",
                    style: TextStyle(color: c.lightBlack),
                  ),
                  onTap: () {},
                  //trailing: Text("5", style: TextStyle(color: Colors.white),),
                )),
          )
        ],
      );
    }
  }
}

//and empty
Widget emptyWidget(){
  return Text("");
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 22.0),
            //if snapshot is empty say you didn't talk to anyone
            child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 6.17),
                    child: Column(
                      children: <Widget>[messageList(false, "Joy Paul", true)],
                    ),
                  );
                }),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
              onPressed: (){},
              icon: emptyWidget(),
              backgroundColor: c.lightBlack,
              label: Text("FIND NEW 0/5 ", style: TextStyle(color: c.maxWhite),)),
        ),
      ),
    );
  }
}
