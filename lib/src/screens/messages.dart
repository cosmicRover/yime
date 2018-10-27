import 'package:flutter/material.dart';
import '../colors/allcolors.dart';

AppColors c = AppColors();

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
          Container(
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
              ))
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
          Container(
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
              ))
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
          Container(
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
              ))
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
          Container(
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
              ))
        ],
      );
    }
  }
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Messages",),
            backgroundColor: c.purple,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 22.0),
            //if snapshot is empty say you didn't talk to anyone
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 6.17),
                    child: Column(
                      children: <Widget>[messageList(true, "Joy Paul", false)],
                    ),
                  );
                }),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 51.17),
                child: Container(
                  width: 179.0,
                  height: 49.83,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(46.0)),
                      color: c.purple),
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "FIND NEW 0/5",
                        style: TextStyle(color: c.maxWhite),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
