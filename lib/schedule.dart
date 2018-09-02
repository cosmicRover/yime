import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class SetSchedule extends StatefulWidget {
  @override
  SetScheduleState createState() => new SetScheduleState();
}

class SetScheduleState extends State<SetSchedule> {
  static String accessToken;
  static String authCode;
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

  static const _serviceUrl =
      'https://yime.herokuapp.com/api/schedule'; //schedule, available, friend and me(coming soon)
  static final _headers = {
    'Authorization': authCode,
    'Content-Type': 'application/json'
  };
  var hasInfo = false;
  Future<dynamic> getInfo() async {
    //this function will get the response for api/me and then it will assign
    //the proper values to the variables
    if (hasInfo == false) {
      try {
        final response =
            await http.get(Uri.encodeFull(_serviceUrl), headers: _headers);
        var c = jsonDecode(response.body);
        print(c);
        var schedule = c["schedule"];

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

        valueAssigner(tueHours);
        boolAssigner(days[1], tueHours);

        valueAssigner(wedHours);
        boolAssigner(days[2], wedHours);

        valueAssigner(thuHours);
        boolAssigner(days[3], thuHours);

        valueAssigner(friHours);
        boolAssigner(days[4], friHours);

        valueAssigner(satHours);
        boolAssigner(days[5], satHours);

        valueAssigner(sunHours);
        boolAssigner(days[6], sunHours);
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
    if (hasAccessCode == false) {
      //calling shared pref plugin and getString()
      SharedPreferences prefs = await SharedPreferences.getInstance();
      accessToken = prefs.getString("accesstoken");
      print("accesstoken retreived");
      authCode = 'Bearer ' +
          accessToken; //adding bearer to accesscode for security reason
      print(authCode);
      hasAccessCode = true;
    }
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
    /*  this plan don't work.. value don't update more than once
    Widget buildChip(bool x, String t) {
      return ChoiceChip(
          label: Text(t),
          selected: x,
          onSelected: (bool v) {
            setState(() {
              x = v;
              print("bool setstate called");
              print(x);
            });
          });
    }
*/
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
                          children: <Widget>[
                            ChoiceChip(
                              label: Text(
                                "1 am",
                                style: chipText,
                              ),
                              selected: monHours[0],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[0] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "2 am",
                                style: chipText,
                              ),
                              selected: monHours[1],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[1] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "3 am",
                                style: chipText,
                              ),
                              selected: monHours[2],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[2] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "4 am",
                                style: chipText,
                              ),
                              selected: monHours[3],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[3] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "5 am",
                                style: chipText,
                              ),
                              selected: monHours[4],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[4] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "6 am",
                                style: chipText,
                              ),
                              selected: monHours[5],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[5] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "7 am",
                                style: chipText,
                              ),
                              selected: monHours[6],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[6] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "8 am",
                                style: chipText,
                              ),
                              selected: monHours[7],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[7] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "9 am",
                                style: chipText,
                              ),
                              selected: monHours[8],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[8] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "10 am",
                                style: chipText,
                              ),
                              selected: monHours[9],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[9] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "11 am",
                                style: chipText,
                              ),
                              selected: monHours[10],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[10] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "12 pm",
                                style: chipText,
                              ),
                              selected: monHours[11],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[11] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "1 pm",
                                style: chipText,
                              ),
                              selected: monHours[12],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[12] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "2 pm",
                                style: chipText,
                              ),
                              selected: monHours[13],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[13] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "3 pm",
                                style: chipText,
                              ),
                              selected: monHours[14],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[14] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "4 pm",
                                style: chipText,
                              ),
                              selected: monHours[15],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[15] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "5 pm",
                                style: chipText,
                              ),
                              selected: monHours[16],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[16] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "6 pm",
                                style: chipText,
                              ),
                              selected: monHours[17],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[17] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "7 pm",
                                style: chipText,
                              ),
                              selected: monHours[18],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[18] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "8 pm",
                                style: chipText,
                              ),
                              selected: monHours[19],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[19] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "9 pm",
                                style: chipText,
                              ),
                              selected: monHours[20],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[20] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "10 pm",
                                style: chipText,
                              ),
                              selected: monHours[21],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[21] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "11 pm",
                                style: chipText,
                              ),
                              selected: monHours[22],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[22] = value;
                                  print(monHours);
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text(
                                "12 am",
                                style: chipText,
                              ),
                              selected: monHours[23],
                              selectedColor: chipColor,
                              onSelected: (bool value) {
                                setState(() {
                                  monHours[23] = value;
                                  print(monHours);
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    ExpansionTile(
                      title: Text("Tuesday"),
                    ),
                    Divider(),
                    ExpansionTile(
                      title: Text("Wednesday"),
                    ),
                    Divider(),
                    ExpansionTile(
                      title: Text("Thursday"),
                    ),
                    Divider(),
                    ExpansionTile(
                      title: Text("Friday"),
                    ),
                    Divider(),
                    ExpansionTile(
                      title: Text("Saturday"),
                    ),
                    Divider(),
                    ExpansionTile(
                      title: Text("Sunday"),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                //if the snapshot has error
                return Text("${snapshot.error}");
              }
              // By default, show a linear progress indicator
              return LinearProgressIndicator();
            },
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.save),
              onPressed: () => submitHours().then((onValue) {})),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
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

    var schedule = Map();
    schedule["schedule"] = mapData;
    print(schedule);
    //ready to post schedule

    return true;
  }
}
