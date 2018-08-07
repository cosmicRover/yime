import 'package:flutter/material.dart';
import 'package:flutter/services.dart';//for device orientation lock

class SetSchedule extends StatefulWidget {
  @override
  _SetScheduleState createState() => _SetScheduleState();
}

class _SetScheduleState extends State<SetSchedule> {
  bool _isChecked=false;

  void onChanged(bool value){
    setState(() {
      _isChecked=value;
    });
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
              body: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(8.0),
                crossAxisSpacing: 1.0,
                crossAxisCount: 8,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Card(
                    child: Center(child: Text("Days/time")),
                  ),
                  Card(
                    child: Center(child: Text("Mon")),
                  ),
                  Card(
                    child: Center(child: Text("Tue")),
                  ),
                  Card(
                    child: Center(child: Text("Wed")),
                  ),
                  Card(
                    child: Center(child: Text("Thu")),
                  ),
                  Card(
                    child: Center(child: Text("Fri")),
                  ),
                  Card(
                    child: Center(child: Text("Sat")),
                  ),
                  Card(
                    child: Center(child: Text("Sun")),
                  ),
                  Card(
                    child: Center(child: Text("8 am")),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Card(
                    child: Center(child: Text("8 am")),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Card(
                    child: Center(child: Text("8 am")),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Card(
                    child: Center(child: Text("8 am")),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Card(
                    child: Center(child: Text("8 am")),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Card(
                    child: Center(child: Text("8 am")),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Card(
                    child: Center(child: Text("8 am")),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Card(
                    child: Center(child: Text("8 am")),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Card(
                    child: Center(child: Text("8 am")),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Card(
                    child: Center(child: Text("8 am")),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Card(
                    child: Center(child: Text("8 am")),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Card(
                    child: Center(child: Text("8 am")),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value){
                      onChanged(value);
                    },
                  ),

                ],
              )
    )));
  }
}
