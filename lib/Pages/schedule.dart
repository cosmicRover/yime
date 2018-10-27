import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'saveaccesscode.dart';

String accessToken;
String authCode;

String _serviceUrl =
    'https://yime.herokuapp.com/api/schedule'; //schedule, available, friend and me(coming soon)
final _headers = {
  'Authorization': authCode,
  'Content-Type': 'application/json'
};

AcCodeStorage saveKey = AcCodeStorage();

class SetSchedule extends StatefulWidget {
  SetSchedule(String x) {
    authCode = x;
  }

  @override
  SetScheduleState createState() => new SetScheduleState();
}

class SetScheduleState extends State<SetSchedule> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List days = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];

  List<bool> monHours = List(24);
  List<bool> tueHours = List(24);
  List<bool> wedHours = List(24);
  List<bool> thuHours = List(24);
  List<bool> friHours = List(24);
  List<bool> satHours = List(24);
  List<bool> sunHours = List(24);

  Map<String, bool> monMap, tueMap, wedMap, thuMap, friMap, satMap, sunMap;

  void showErrMessage(String message, Color c) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(backgroundColor: c, content: Text(message)));
  }

  var hasInfo = false;
  Future<dynamic> getInfo() async {
    //this function will get the response for api/me and then it will assign
    //the proper values to the variables
    if (hasInfo == false) {
      try {
        final response =
            await http.get(Uri.encodeFull(_serviceUrl), headers: _headers);
        var c = jsonDecode(response.body);
        print("schedule is $c");
        var schedule = c;

        //assigning the retrieved values to a list of days
        //if length is 0, assign null
        //else assign values
        for (var i = 0; i < days.length; i++) {
          if (schedule[days[i]].length == 0) {
            days[i] = null;
            print(days[i]);
          } else {
            days[i] = schedule[days[i]];
            print(days[i]);
          }
        }
        //valueAssigner and boolAssigner are helper functions
        //they are used to assign values to lists and converting to bool values
        valueAssigner(monHours);
        boolAssigner(days[0], monHours);
        monMap = {
          '1 am': monHours[0],
          '2 am': monHours[1],
          '3 am': monHours[2],
          '4 am': monHours[3],
          '5 am': monHours[4],
          '6 am': monHours[5],
          '7 am': monHours[6],
          '8 am': monHours[7],
          '9 am': monHours[8],
          '10 am': monHours[9],
          '11 am': monHours[10],
          '12 pm': monHours[11],
          '1 pm': monHours[12],
          '2 pm': monHours[13],
          '3 pm': monHours[14],
          '4 pm': monHours[15],
          '5 pm': monHours[16],
          '6 pm': monHours[17],
          '7 pm': monHours[18],
          '8 pm': monHours[19],
          '9 pm': monHours[20],
          '10 pm': monHours[21],
          '11 pm': monHours[22],
          '12 am': monHours[23],
        };

        valueAssigner(tueHours);
        boolAssigner(days[1], tueHours);
        tueMap = {
          '1 am': tueHours[0],
          '2 am': tueHours[1],
          '3 am': tueHours[2],
          '4 am': tueHours[3],
          '5 am': tueHours[4],
          '6 am': tueHours[5],
          '7 am': tueHours[6],
          '8 am': tueHours[7],
          '9 am': tueHours[8],
          '10 am': tueHours[9],
          '11 am': tueHours[10],
          '12 pm': tueHours[11],
          '1 pm': tueHours[12],
          '2 pm': tueHours[13],
          '3 pm': tueHours[14],
          '4 pm': tueHours[15],
          '5 pm': tueHours[16],
          '6 pm': tueHours[17],
          '7 pm': tueHours[18],
          '8 pm': tueHours[19],
          '9 pm': tueHours[20],
          '10 pm': tueHours[21],
          '11 pm': tueHours[22],
          '12 am': tueHours[23],
        };

        valueAssigner(wedHours);
        boolAssigner(days[2], wedHours);
        wedMap = {
          '1 am': wedHours[0],
          '2 am': wedHours[1],
          '3 am': wedHours[2],
          '4 am': wedHours[3],
          '5 am': wedHours[4],
          '6 am': wedHours[5],
          '7 am': wedHours[6],
          '8 am': wedHours[7],
          '9 am': wedHours[8],
          '10 am': wedHours[9],
          '11 am': wedHours[10],
          '12 pm': wedHours[11],
          '1 pm': wedHours[12],
          '2 pm': wedHours[13],
          '3 pm': wedHours[14],
          '4 pm': wedHours[15],
          '5 pm': wedHours[16],
          '6 pm': wedHours[17],
          '7 pm': wedHours[18],
          '8 pm': wedHours[19],
          '9 pm': wedHours[20],
          '10 pm': wedHours[21],
          '11 pm': wedHours[22],
          '12 am': wedHours[23],
        };

        valueAssigner(thuHours);
        boolAssigner(days[3], thuHours);
        thuMap = {
          '1 am': thuHours[0],
          '2 am': thuHours[1],
          '3 am': thuHours[2],
          '4 am': thuHours[3],
          '5 am': thuHours[4],
          '6 am': thuHours[5],
          '7 am': thuHours[6],
          '8 am': thuHours[7],
          '9 am': thuHours[8],
          '10 am': thuHours[9],
          '11 am': thuHours[10],
          '12 pm': thuHours[11],
          '1 pm': thuHours[12],
          '2 pm': thuHours[13],
          '3 pm': thuHours[14],
          '4 pm': thuHours[15],
          '5 pm': thuHours[16],
          '6 pm': thuHours[17],
          '7 pm': thuHours[18],
          '8 pm': thuHours[19],
          '9 pm': thuHours[20],
          '10 pm': thuHours[21],
          '11 pm': thuHours[22],
          '12 am': thuHours[23],
        };

        valueAssigner(friHours);
        boolAssigner(days[4], friHours);
        friMap = {
          '1 am': friHours[0],
          '2 am': friHours[1],
          '3 am': friHours[2],
          '4 am': friHours[3],
          '5 am': friHours[4],
          '6 am': friHours[5],
          '7 am': friHours[6],
          '8 am': friHours[7],
          '9 am': friHours[8],
          '10 am': friHours[9],
          '11 am': friHours[10],
          '12 pm': friHours[11],
          '1 pm': friHours[12],
          '2 pm': friHours[13],
          '3 pm': friHours[14],
          '4 pm': friHours[15],
          '5 pm': friHours[16],
          '6 pm': friHours[17],
          '7 pm': friHours[18],
          '8 pm': friHours[19],
          '9 pm': friHours[20],
          '10 pm': friHours[21],
          '11 pm': friHours[22],
          '12 am': friHours[23],
        };

        valueAssigner(satHours);
        boolAssigner(days[5], satHours);
        satMap = {
          '1 am': satHours[0],
          '2 am': satHours[1],
          '3 am': satHours[2],
          '4 am': satHours[3],
          '5 am': satHours[4],
          '6 am': satHours[5],
          '7 am': satHours[6],
          '8 am': satHours[7],
          '9 am': satHours[8],
          '10 am': satHours[9],
          '11 am': satHours[10],
          '12 pm': satHours[11],
          '1 pm': satHours[12],
          '2 pm': satHours[13],
          '3 pm': satHours[14],
          '4 pm': satHours[15],
          '5 pm': satHours[16],
          '6 pm': satHours[17],
          '7 pm': satHours[18],
          '8 pm': satHours[19],
          '9 pm': satHours[20],
          '10 pm': satHours[21],
          '11 pm': satHours[22],
          '12 am': satHours[23],
        };

        valueAssigner(sunHours);
        boolAssigner(days[6], sunHours);
        sunMap = {
          '1 am': sunHours[0],
          '2 am': sunHours[1],
          '3 am': sunHours[2],
          '4 am': sunHours[3],
          '5 am': sunHours[4],
          '6 am': sunHours[5],
          '7 am': sunHours[6],
          '8 am': sunHours[7],
          '9 am': sunHours[8],
          '10 am': sunHours[9],
          '11 am': sunHours[10],
          '12 pm': sunHours[11],
          '1 pm': sunHours[12],
          '2 pm': sunHours[13],
          '3 pm': sunHours[14],
          '4 pm': sunHours[15],
          '5 pm': sunHours[16],
          '6 pm': sunHours[17],
          '7 pm': sunHours[18],
          '8 pm': sunHours[19],
          '9 pm': sunHours[20],
          '10 pm': sunHours[21],
          '11 pm': sunHours[22],
          '12 am': sunHours[23],
        };

        return hasInfo = true;
      } catch (e) {
        print('Server Exception!!! on getinfo ');
        print(e);
        return false;
      }
    } else {
      return true;
    }
  }

  //assigns a default value of false to the list
  dynamic valueAssigner(List hours) {
    for (var i = 0; i < 24; i++) {
      hours[i] = false;
    }
    return hours;
  }

  //assigns a value of true to the list if an element exits
  dynamic boolAssigner(List x, List y) {
    if (x != null) {
      for (var i = 0; i < x.length; i++) {
        if (x[i] != 0) {
          var z = x[i] - 1;
          y[z] = true;
        }
      }
      print(y);
    } else {
      print(y);
    }

    return y;
  }

  var hasAccessCode = false;
  Future<dynamic> checkUser() async {
    await getInfo();
    return getInfo();
    //calling the http.get function
  }

  //helper function for ChoiceChips
  Color chipColor = Colors.green;
  TextStyle chipText =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(
          primarySwatch: Colors.yellow,
          textTheme: TextTheme(
              subhead:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              button:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          canvasColor: Colors.white,
          splashColor: Colors.yellow,
          dividerColor: Colors.yellow[700],
        ),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Yime"),
            backgroundColor: Colors.yellow,
          ),
          body: FutureBuilder(
            future: checkUser(),
            builder: (context, snapshot) {
              //builder takes context and snapshot
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "Set your schedule",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24.0),
                      )),
                    ),
                    ExpansionTile(
                      title: Text("Monday"),
                      children: <Widget>[
                        Wrap(
                          children: monMap.keys.map((String key) {
                            return ChoiceChip(
                              label: Text(
                                key,
                                style: chipText,
                              ),
                              selected: monMap[key],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  //setting state and also updating the parent
                                  monMap[key] = value;
                                  switch (key) {
                                    case '1 am':
                                      monHours[0] = value;
                                      break;
                                    case '2 am':
                                      monHours[1] = value;
                                      break;
                                    case '3 am':
                                      monHours[2] = value;
                                      break;
                                    case '4 am':
                                      monHours[3] = value;
                                      break;
                                    case '5 am':
                                      monHours[4] = value;
                                      break;
                                    case '6 am':
                                      monHours[5] = value;
                                      break;
                                    case '7 am':
                                      monHours[6] = value;
                                      break;
                                    case '8 am':
                                      monHours[7] = value;
                                      break;
                                    case '9 am':
                                      monHours[8] = value;
                                      break;
                                    case '10 am':
                                      monHours[9] = value;
                                      break;
                                    case '11 am':
                                      monHours[10] = value;
                                      break;
                                    case '12 pm':
                                      monHours[11] = value;
                                      break;
                                    case '1 pm':
                                      monHours[12] = value;
                                      break;
                                    case '2 pm':
                                      monHours[13] = value;
                                      break;
                                    case '3 pm':
                                      monHours[14] = value;
                                      break;
                                    case '4 pm':
                                      monHours[15] = value;
                                      break;
                                    case '5 pm':
                                      monHours[16] = value;
                                      break;
                                    case '6 pm':
                                      monHours[17] = value;
                                      break;
                                    case '7 pm':
                                      monHours[18] = value;
                                      break;
                                    case '8 pm':
                                      monHours[19] = value;
                                      break;
                                    case '9 pm':
                                      monHours[20] = value;
                                      break;
                                    case '10 pm':
                                      monHours[21] = value;
                                      break;
                                    case '11 pm':
                                      monHours[22] = value;
                                      break;
                                    case '12 am':
                                      monHours[23] = value;
                                      break;
                                  }
                                });
                              },
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    Divider(),
                    ExpansionTile(
                      title: Text("Tuesday"),
                      children: <Widget>[
                        Wrap(
                          children: tueMap.keys.map((String key) {
                            return ChoiceChip(
                              label: Text(
                                key,
                                style: chipText,
                              ),
                              selected: tueMap[key],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  //setting state and also updating the parent
                                  tueMap[key] = value;
                                  switch (key) {
                                    case '1 am':
                                      tueHours[0] = value;
                                      break;
                                    case '2 am':
                                      tueHours[1] = value;
                                      break;
                                    case '3 am':
                                      tueHours[2] = value;
                                      break;
                                    case '4 am':
                                      tueHours[3] = value;
                                      break;
                                    case '5 am':
                                      tueHours[4] = value;
                                      break;
                                    case '6 am':
                                      tueHours[5] = value;
                                      break;
                                    case '7 am':
                                      tueHours[6] = value;
                                      break;
                                    case '8 am':
                                      tueHours[7] = value;
                                      break;
                                    case '9 am':
                                      tueHours[8] = value;
                                      break;
                                    case '10 am':
                                      tueHours[9] = value;
                                      break;
                                    case '11 am':
                                      tueHours[10] = value;
                                      break;
                                    case '12 pm':
                                      tueHours[11] = value;
                                      break;
                                    case '1 pm':
                                      tueHours[12] = value;
                                      break;
                                    case '2 pm':
                                      tueHours[13] = value;
                                      break;
                                    case '3 pm':
                                      tueHours[14] = value;
                                      break;
                                    case '4 pm':
                                      tueHours[15] = value;
                                      break;
                                    case '5 pm':
                                      tueHours[16] = value;
                                      break;
                                    case '6 pm':
                                      tueHours[17] = value;
                                      break;
                                    case '7 pm':
                                      tueHours[18] = value;
                                      break;
                                    case '8 pm':
                                      tueHours[19] = value;
                                      break;
                                    case '9 pm':
                                      tueHours[20] = value;
                                      break;
                                    case '10 pm':
                                      tueHours[21] = value;
                                      break;
                                    case '11 pm':
                                      tueHours[22] = value;
                                      break;
                                    case '12 am':
                                      tueHours[23] = value;
                                      break;
                                  }
                                });
                              },
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    Divider(),
                    ExpansionTile(
                      title: Text("Wednesday"),
                      children: <Widget>[
                        Wrap(
                          children: wedMap.keys.map((String key) {
                            return ChoiceChip(
                              label: Text(
                                key,
                                style: chipText,
                              ),
                              selected: wedMap[key],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  //setting state and also updating the parent
                                  wedMap[key] = value;
                                  switch (key) {
                                    case '1 am':
                                      wedHours[0] = value;
                                      break;
                                    case '2 am':
                                      wedHours[1] = value;
                                      break;
                                    case '3 am':
                                      wedHours[2] = value;
                                      break;
                                    case '4 am':
                                      wedHours[3] = value;
                                      break;
                                    case '5 am':
                                      wedHours[4] = value;
                                      break;
                                    case '6 am':
                                      wedHours[5] = value;
                                      break;
                                    case '7 am':
                                      wedHours[6] = value;
                                      break;
                                    case '8 am':
                                      wedHours[7] = value;
                                      break;
                                    case '9 am':
                                      wedHours[8] = value;
                                      break;
                                    case '10 am':
                                      wedHours[9] = value;
                                      break;
                                    case '11 am':
                                      wedHours[10] = value;
                                      break;
                                    case '12 pm':
                                      wedHours[11] = value;
                                      break;
                                    case '1 pm':
                                      wedHours[12] = value;
                                      break;
                                    case '2 pm':
                                      wedHours[13] = value;
                                      break;
                                    case '3 pm':
                                      wedHours[14] = value;
                                      break;
                                    case '4 pm':
                                      wedHours[15] = value;
                                      break;
                                    case '5 pm':
                                      wedHours[16] = value;
                                      break;
                                    case '6 pm':
                                      wedHours[17] = value;
                                      break;
                                    case '7 pm':
                                      wedHours[18] = value;
                                      break;
                                    case '8 pm':
                                      wedHours[19] = value;
                                      break;
                                    case '9 pm':
                                      wedHours[20] = value;
                                      break;
                                    case '10 pm':
                                      wedHours[21] = value;
                                      break;
                                    case '11 pm':
                                      wedHours[22] = value;
                                      break;
                                    case '12 am':
                                      wedHours[23] = value;
                                      break;
                                  }
                                });
                              },
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    Divider(),
                    ExpansionTile(
                      title: Text("Thursday"),
                      children: <Widget>[
                        Wrap(
                          children: thuMap.keys.map((String key) {
                            return ChoiceChip(
                              label: Text(
                                key,
                                style: chipText,
                              ),
                              selected: thuMap[key],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  //setting state and also updating the parent
                                  thuMap[key] = value;
                                  switch (key) {
                                    case '1 am':
                                      thuHours[0] = value;
                                      break;
                                    case '2 am':
                                      thuHours[1] = value;
                                      break;
                                    case '3 am':
                                      thuHours[2] = value;
                                      break;
                                    case '4 am':
                                      thuHours[3] = value;
                                      break;
                                    case '5 am':
                                      thuHours[4] = value;
                                      break;
                                    case '6 am':
                                      thuHours[5] = value;
                                      break;
                                    case '7 am':
                                      thuHours[6] = value;
                                      break;
                                    case '8 am':
                                      thuHours[7] = value;
                                      break;
                                    case '9 am':
                                      thuHours[8] = value;
                                      break;
                                    case '10 am':
                                      thuHours[9] = value;
                                      break;
                                    case '11 am':
                                      thuHours[10] = value;
                                      break;
                                    case '12 pm':
                                      thuHours[11] = value;
                                      break;
                                    case '1 pm':
                                      thuHours[12] = value;
                                      break;
                                    case '2 pm':
                                      thuHours[13] = value;
                                      break;
                                    case '3 pm':
                                      thuHours[14] = value;
                                      break;
                                    case '4 pm':
                                      thuHours[15] = value;
                                      break;
                                    case '5 pm':
                                      thuHours[16] = value;
                                      break;
                                    case '6 pm':
                                      thuHours[17] = value;
                                      break;
                                    case '7 pm':
                                      thuHours[18] = value;
                                      break;
                                    case '8 pm':
                                      thuHours[19] = value;
                                      break;
                                    case '9 pm':
                                      thuHours[20] = value;
                                      break;
                                    case '10 pm':
                                      thuHours[21] = value;
                                      break;
                                    case '11 pm':
                                      thuHours[22] = value;
                                      break;
                                    case '12 am':
                                      thuHours[23] = value;
                                      break;
                                  }
                                });
                              },
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    Divider(),
                    ExpansionTile(
                      title: Text("Friday"),
                      children: <Widget>[
                        Wrap(
                          children: friMap.keys.map((String key) {
                            return ChoiceChip(
                              label: Text(
                                key,
                                style: chipText,
                              ),
                              selected: friMap[key],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  //setting state and also updating the parent
                                  friMap[key] = value;
                                  switch (key) {
                                    case '1 am':
                                      friHours[0] = value;
                                      break;
                                    case '2 am':
                                      friHours[1] = value;
                                      break;
                                    case '3 am':
                                      friHours[2] = value;
                                      break;
                                    case '4 am':
                                      friHours[3] = value;
                                      break;
                                    case '5 am':
                                      friHours[4] = value;
                                      break;
                                    case '6 am':
                                      friHours[5] = value;
                                      break;
                                    case '7 am':
                                      friHours[6] = value;
                                      break;
                                    case '8 am':
                                      friHours[7] = value;
                                      break;
                                    case '9 am':
                                      friHours[8] = value;
                                      break;
                                    case '10 am':
                                      friHours[9] = value;
                                      break;
                                    case '11 am':
                                      friHours[10] = value;
                                      break;
                                    case '12 pm':
                                      friHours[11] = value;
                                      break;
                                    case '1 pm':
                                      friHours[12] = value;
                                      break;
                                    case '2 pm':
                                      friHours[13] = value;
                                      break;
                                    case '3 pm':
                                      friHours[14] = value;
                                      break;
                                    case '4 pm':
                                      friHours[15] = value;
                                      break;
                                    case '5 pm':
                                      friHours[16] = value;
                                      break;
                                    case '6 pm':
                                      friHours[17] = value;
                                      break;
                                    case '7 pm':
                                      friHours[18] = value;
                                      break;
                                    case '8 pm':
                                      friHours[19] = value;
                                      break;
                                    case '9 pm':
                                      friHours[20] = value;
                                      break;
                                    case '10 pm':
                                      friHours[21] = value;
                                      break;
                                    case '11 pm':
                                      friHours[22] = value;
                                      break;
                                    case '12 am':
                                      friHours[23] = value;
                                      break;
                                  }
                                });
                              },
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    Divider(),
                    ExpansionTile(
                      title: Text("Saturday"),
                      children: <Widget>[
                        Wrap(
                          children: satMap.keys.map((String key) {
                            return ChoiceChip(
                              label: Text(
                                key,
                                style: chipText,
                              ),
                              selected: satMap[key],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  //setting state and also updating the parent
                                  satMap[key] = value;
                                  switch (key) {
                                    case '1 am':
                                      satHours[0] = value;
                                      break;
                                    case '2 am':
                                      satHours[1] = value;
                                      break;
                                    case '3 am':
                                      satHours[2] = value;
                                      break;
                                    case '4 am':
                                      satHours[3] = value;
                                      break;
                                    case '5 am':
                                      satHours[4] = value;
                                      break;
                                    case '6 am':
                                      satHours[5] = value;
                                      break;
                                    case '7 am':
                                      satHours[6] = value;
                                      break;
                                    case '8 am':
                                      satHours[7] = value;
                                      break;
                                    case '9 am':
                                      satHours[8] = value;
                                      break;
                                    case '10 am':
                                      satHours[9] = value;
                                      break;
                                    case '11 am':
                                      satHours[10] = value;
                                      break;
                                    case '12 pm':
                                      satHours[11] = value;
                                      break;
                                    case '1 pm':
                                      satHours[12] = value;
                                      break;
                                    case '2 pm':
                                      satHours[13] = value;
                                      break;
                                    case '3 pm':
                                      satHours[14] = value;
                                      break;
                                    case '4 pm':
                                      satHours[15] = value;
                                      break;
                                    case '5 pm':
                                      satHours[16] = value;
                                      break;
                                    case '6 pm':
                                      satHours[17] = value;
                                      break;
                                    case '7 pm':
                                      satHours[18] = value;
                                      break;
                                    case '8 pm':
                                      satHours[19] = value;
                                      break;
                                    case '9 pm':
                                      satHours[20] = value;
                                      break;
                                    case '10 pm':
                                      satHours[21] = value;
                                      break;
                                    case '11 pm':
                                      satHours[22] = value;
                                      break;
                                    case '12 am':
                                      satHours[23] = value;
                                      break;
                                  }
                                });
                              },
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    Divider(),
                    ExpansionTile(
                      title: Text("Sunday"),
                      children: <Widget>[
                        Wrap(
                          children: sunMap.keys.map((String key) {
                            return ChoiceChip(
                              label: Text(
                                key,
                                style: chipText,
                              ),
                              selected: sunMap[key],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  //setting state and also updating the parent
                                  sunMap[key] = value;
                                  switch (key) {
                                    case '1 am':
                                      sunHours[0] = value;
                                      break;
                                    case '2 am':
                                      sunHours[1] = value;
                                      break;
                                    case '3 am':
                                      sunHours[2] = value;
                                      break;
                                    case '4 am':
                                      sunHours[3] = value;
                                      break;
                                    case '5 am':
                                      sunHours[4] = value;
                                      break;
                                    case '6 am':
                                      sunHours[5] = value;
                                      break;
                                    case '7 am':
                                      sunHours[6] = value;
                                      break;
                                    case '8 am':
                                      sunHours[7] = value;
                                      break;
                                    case '9 am':
                                      sunHours[8] = value;
                                      break;
                                    case '10 am':
                                      sunHours[9] = value;
                                      break;
                                    case '11 am':
                                      sunHours[10] = value;
                                      break;
                                    case '12 pm':
                                      sunHours[11] = value;
                                      break;
                                    case '1 pm':
                                      sunHours[12] = value;
                                      break;
                                    case '2 pm':
                                      sunHours[13] = value;
                                      break;
                                    case '3 pm':
                                      sunHours[14] = value;
                                      break;
                                    case '4 pm':
                                      sunHours[15] = value;
                                      break;
                                    case '5 pm':
                                      sunHours[16] = value;
                                      break;
                                    case '6 pm':
                                      sunHours[17] = value;
                                      break;
                                    case '7 pm':
                                      sunHours[18] = value;
                                      break;
                                    case '8 pm':
                                      sunHours[19] = value;
                                      break;
                                    case '9 pm':
                                      sunHours[20] = value;
                                      break;
                                    case '10 pm':
                                      sunHours[21] = value;
                                      break;
                                    case '11 pm':
                                      sunHours[22] = value;
                                      break;
                                    case '12 am':
                                      sunHours[23] = value;
                                      break;
                                  }
                                });
                              },
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    RaisedButton.icon(
                        onPressed: () => displayDialogue(),
                        color: Colors.yellow,
                        icon: Icon(Icons.save),
                        label: Text(
                          "Submit",
                          style: chipText,
                        )),
                  ],
                );
              } else if (snapshot.hasError) {
                //if the snapshot has error
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Are you connected to the internet?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28.0),
                      ),
                    ),
                  ],
                );
              }
              // By default, show a linear progress indicator
              return LinearProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  void displayDialogue() {
    //show dialogue will build an alert dialogue
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Submit?"),
            content: Text("Press yes to update your schedule"),
            //the actions of the alert dialogue
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    submitHours().then((onValue) {
                      if (onValue == 200) {
                        showErrMessage("Submitted!", Colors.green);
                      } else {
                        showErrMessage(
                            "Something went wrong, try later", Colors.red);
                      }
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Yes")),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No"))
            ],
          );
        });
  }

  dynamic extractHours(List<bool> x, List y) {
    for (int i = 0; i < 24; i++) {
      if (x[i] == true) {
        y.add(i + 1);
      }
    }
    print(y);
  }

  Future<dynamic> submitHours() async {
    List<int> monday = List();
    List<int> tuesday = List();
    List<int> wednesday = List();
    List<int> thursday = List();
    List<int> friday = List();
    List<int> saturday = List();
    List<int> sunday = List();

    extractHours(monHours, monday);
    extractHours(tueHours, tuesday);
    extractHours(wedHours, wednesday);
    extractHours(thuHours, thursday);
    extractHours(friHours, friday);
    extractHours(satHours, saturday);
    extractHours(sunHours, sunday);

    var mapData = Map();
    mapData["monday"] = monday;
    mapData["tuesday"] = tuesday;
    mapData["wednesday"] = wednesday;
    mapData["thursday"] = thursday;
    mapData["friday"] = friday;
    mapData["saturday"] = saturday;
    mapData["sunday"] = sunday;

    var data = jsonEncode(mapData);
    print(data);
    //encoding ready to post schedule

    const _serviceUrl =
        'https://yime.herokuapp.com/api/schedule'; //schedule, available, friend and me(coming soon)
    final _headers = {
      'Authorization': authCode,
      'Content-Type': 'application/json'
    };
    try {
      final response =
          await http.post(_serviceUrl, headers: _headers, body: data);
      var c = response.statusCode;
      print(c);
      return c;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
