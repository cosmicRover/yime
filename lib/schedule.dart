import 'package:flutter/material.dart';
import 'package:flutter/services.dart';//for device orientation lock

class SetSchedule extends StatefulWidget {
  @override
  _SetScheduleState createState() => _SetScheduleState();
}

class _SetScheduleState extends State<SetSchedule> {

  //the values for the checkboxes, should take from api first and then submit
  //to api after the user is done
  Map<String, bool> values = {
    '8mon': true,
    '8tue': false,
    '8wed': false,
    '8thur': false,
    '8fri': true,
    '8sat': false,
    '8sun': false,
    '9mon': true,
    '9tue': false,
    '9wed': false,
    '9thur': false,
    '9fri': true,
    '9sat': false,
    '9sun': false,
    '10mon': true,
    '10tue': false,
    '10wed': false,
    '10thur': false,
    '10fri': true,
    '10sat': false,
    '10sun': false,
  };

  void onChanged(bool value){

  }

  //making sure the device stays locked to portrait up
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      //DeviceOrientation.landscapeLeft,
    ]);
  }

  //setting the device orientation back to the normal ones
  @override
  dispose(){
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
          data: ThemeData(
              primarySwatch: Colors.yellow,
              canvasColor: Colors.white,
              splashColor: Colors.yellow,
              cardColor: Colors.white,
              textTheme: TextTheme(
                body1: TextStyle(
                  fontWeight: FontWeight.bold
                )
              )
          ),
          child: Scaffold(
              appBar: AppBar(
                title: Text("Yime"),
              ),
              //gridview for the schedule
              body: SafeArea(
                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Card(
                            child: Text("8 am"),
                          )
                        ],
                      ),
                      

                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 33.0),
                            child: Card(
                              child: Text("Mon"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 65.0),
                            child: Card(
                              child: Text("Mon"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                            child: Card(
                              child: Text("Mon"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                            child: Card(
                              child: Text("Mon"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                            child: Card(
                              child: Text("Mon"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                            child: Card(
                              child: Text("Mon"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                            child: Card(
                              child: Text("Mon"),
                            ),
                          ),
                        ],
                      ),
                      
                      GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(8.0),
                        crossAxisSpacing: 1.0,
                        crossAxisCount: 7,
                        scrollDirection: Axis.horizontal,
                        children: values.keys.map((String key){
                          return Checkbox(
                              value: values[key],
                              onChanged: (bool value){
                                setState(() {
                                  values[key]= value;
                                });
                              }
                          );
                        }).toList(),//adds elements to the list as they arrive
                      )
                    ],
                  )
              )
    )));
  }
}
