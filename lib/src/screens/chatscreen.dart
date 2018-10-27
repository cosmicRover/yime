import 'package:flutter/material.dart';
import '../colors/allcolors.dart';

TextEditingController editingController = TextEditingController();
AppColors c = AppColors();
enum BlockPoint { blockValue }

//TODO needs a way to have the texts appear from the bottom and maybe a border around input box
Widget chatCardSample() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(),
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            color: Color.fromRGBO(0, 204, 70, 1.0),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Hello',
                  style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0)),
                ),
              ),
            ),
          )
        ],
      ))
    ],
  );
}

void blockHim() {
  print("Blocked");
}

Widget chatScreen(BuildContext context) {
  return Material(
    child: Theme(
      data: ThemeData(canvasColor: c.lightGrey),
      child: Scaffold(
        appBar: AppBar(
          title: RichText(
              text: TextSpan(
                text: "Cody Johnson",
                style: TextStyle(fontSize: 22.0),
                children: <TextSpan>[
                  TextSpan(text: "   offline", style: TextStyle(fontSize: 12.0))
                ]
              ),
          ),
          backgroundColor: c.darkGrey,
          leading: Container(
              color: c.red,
              height: 52.0,
              width: 46.0,
              child: IconButton(
                  icon: Icon(Icons.keyboard_backspace), onPressed: () {})),
          actions: <Widget>[
            //takes enum values
            PopupMenuButton<BlockPoint>(
              onSelected: (BlockPoint result) {
                blockHim();
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<BlockPoint>>[
                    PopupMenuItem(
                      value: BlockPoint.blockValue,
                      child: Text('Block'),
                    ),
                  ],
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Material(
                color: c.lightGrey,
                child: ListView(

                    ///the actual chat blocks go here
                    ),
              ),
            ),
            Padding(
              ///color right outside of rectangle needs changing
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: c.lighterGrey),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    color: c.maxWhite),
                //color: c.maxWhite,
                padding: EdgeInsets.symmetric(horizontal: 9.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                        child: TextField(
                      controller: editingController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type here',
                      ),
                    )),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                        ),

                        ///change color if controller has text
                        onPressed: null),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return chatScreen(context);
  }
}
