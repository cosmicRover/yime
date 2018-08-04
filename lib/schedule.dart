import 'package:flutter/material.dart';

class SetSchedule extends StatefulWidget {
  @override
  _SetScheduleState createState() => _SetScheduleState();
}

class _SetScheduleState extends State<SetSchedule> {
  int _value, index = 1;
  bool value1 = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
          data: ThemeData(
              primarySwatch: Colors.yellow,
              canvasColor: Colors.white,
              splashColor: Colors.yellow),
          child: Scaffold(
              appBar: AppBar(
                title: Text("Yime"),
              ),
              body: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                      Text("12:00"),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("Monday"),
                      Text("Monday"),
                      Text("Monday"),
                      Text("Monday"),
                      Text("Monday"),
                      Text("Monday"),
                      Text("Monday"),
                    ],
                  ),
                  GridView.count(
                    crossAxisCount: 7,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),
                      Checkbox(
                          value: value1,
                          onChanged: (bool resp) {
                            setState(() {
                              value1 = resp;
                            });
                          }),

                    ],
                  )
                ],
              ))),
    );
  }
}
