import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import './saveaccesscode.dart';

///The global variables
var accessToken;
var rawResponse;
var jsonResponse;
var dataResponse;
var scrollBool = true;
int userId;
int countOld;
String talkingTo;
bool scrolledOnce = false;
bool chatActive = false;
List<dynamic> texts = [];
List<String> testString = [];
List<int> testString2 = [];
AcCodeStorage saveKey = AcCodeStorage();

class WebSocket extends StatefulWidget {

  WebSocket(var x){
    userId = x;
  }

  @override
  _WebSocketState createState() => _WebSocketState();
}

Future<dynamic> getAcCode() async {
  accessToken = await saveKey.readAcCode();
  return accessToken.toString();
}

///Function to send accessToken
Future<dynamic> sendAuthData() async {
  await getAcCode();
  //mapData and then encode to json before sending
  var mapAuth = new Map();
  mapAuth['type'] = 'authData';
  mapAuth['data'] = '$accessToken';
  String data = jsonEncode(mapAuth);
  return data;
}

///Function to send messages
dynamic sendMessage(String x) {
  var mapText = new Map();
  mapText['type'] = 'message';
  mapText['data'] = '$x';
  String data = jsonEncode(mapText);
  return data;
}

///Function to initiate finding partner
dynamic findPartner() {
  //mapData and then encode to json before sending
  var mapAuth = new Map();
  mapAuth['type'] = 'findPartner';
  String data = jsonEncode(mapAuth);
  print("Requesting partner");
  return data;
}

///function to end a chat connection
dynamic sayBye() {
  var mapAuth = new Map();
  mapAuth['type'] = 'bye';
  String data = jsonEncode(mapAuth);
  print("Saying bye!");
  return data;
}

class _WebSocketState extends State<WebSocket> {
  final channel = IOWebSocketChannel.connect("wss://yime.app");
  TextEditingController editingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController scroller;
  AnimationController animationController;

  Future<dynamic> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return "connected";
      }
    } on SocketException catch (_) {
      print('not connected');
      return "not connectted";
    }
  }

  @override
  void initState() {
    super.initState();
    channel.stream.listen((onData) {
      setState(() {
        //taking care of assigning some key data
        if (onData != null) {
          ///assigning the values to global variables
          rawResponse = onData;
          var z = jsonDecode(onData);
          jsonResponse = z['type'];
          dataResponse = z['data'];
          print('$rawResponse =>> $jsonResponse');
        }
      });

      ///triggers if partner found
      if (jsonResponse == 'partnerFound') {
        print("found partner!");
        setState(() {
          talkingTo = dataResponse;
          chatActive = true;
          testString = [];
          testString2 = [];
          texts = [];
        });
        print(talkingTo);
      }

      ///getting the old texts
      else if (jsonResponse == 'oldMessages') {
        setState(() {
          countOld = dataResponse['messages'].length;
          for (var i = 0; i < countOld; i++) {
            testString.add(dataResponse['messages'][i]['message']);
            testString2.add(dataResponse['messages'][i]['senderId']);
          }
        });
        print('Texts are... $texts');
        print(testString);
        print(countOld);
      }

      ///the new texts that will be coming
      else if (jsonResponse == 'message') {
        toEnd();
        setState(() {
          texts.add('$talkingTo$dataResponse');
        });
        print('Text ->> $texts');
      }

      ///.onError triggers when an error happens
    }).onError((e) {
      print(e);
      setState(() {
        jsonResponse = 'error!';
      });
    });

    ///sinks auth data to the webSocket
    sendAuthData().then((onValue) {
      print("requesting auth");
      channel.sink.add(onValue);
    });

    ///Initiating the scroller variable for listView on chatActive == true
    scroller =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  }

  ///Function to help change the reverse value of ListView on chatActive == true
  Future<dynamic> setBool() async {
    return scrollBool = false;
  }

  ///Function to help scroll to the end of the messages
  void toEnd() async {
    setBool().then((onValue) {
      scroller.animateTo(scroller.position.maxScrollExtent + 46,
          duration: Duration(seconds: 1), curve: Curves.linear);
    });
  }

  void displayDialogue() {
    //show dialogue will build an alert dialogue
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Connection lost!"),
            content: Text("Are you connected to the internet?"),
            //the actions of the alert dialogue
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok")),
            ],
          );
        });
  }

  ///The function that builds the conversations user had previously with this person
  ///Using Row, Expanded, Column, Container, SizedBox to display the texts
  Widget buildOldChatCards(BuildContext context) {
    if (testString2 != null) {
      List<Widget> list = new List<Widget>();
      for (var i = 0; i < testString2.length; i++) {
        if (testString2[i] != userId) {
          list.add(Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(),
                    margin:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    color: Color.fromRGBO(0, 204, 70, 1.0),
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${testString[i]}',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ))
            ],
          ));
        } else if (testString2[i] == userId){
          list.add(Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(),
                    margin:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    color: Color.fromRGBO(241, 241, 241, 1.0),
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${testString[i]}',
                          style: TextStyle(color: Color.fromRGBO(4, 4, 4, 1.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ))
            ],
          ));
        }
      }
      return Column(children: list);
    } else {
      return Card(
        child: Text('say hi!'),
        color: Colors.white,
      );
    }
  }

  ///The function that builds the conversations that will happen
  ///Using Row, Expanded, Column, Container, SizedBox to display the texts
  Widget cardSpec(String x) {
    if (x.contains('Me')) {
      x = x.replaceAll('Me:', '');
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(),
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                color: Color.fromRGBO(241, 241, 241, 1.0),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$x',
                      style: TextStyle(color: Color.fromRGBO(4, 4, 4, 1.0)),
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      );
    } else if (x.contains('$talkingTo')) {
      x = x.replaceAll('$talkingTo', '');
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
                    child: Text('$x',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1.0))),
                  ),
                ),
              )
            ],
          ))
        ],
      );
    }
    return Card(
      child: Text('Something went wrong!'),
      color: Colors.white,
    );
  }

  ///Using cardSpec's help, it displays the incomingTexts from both end
  Widget buildIncomingChat() {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < texts.length; i++) {
      var x = cardSpec(texts[i]);
      list.add(x);
    }
    return new Column(children: list);
  }

  ///The different types of states the chat screen will go through
  ///based on variable jsonResponse, chatActive
  Widget chatProcess(BuildContext context) {
    ///authSuccess
    if (jsonResponse == ("authSuccess") || jsonResponse == ("partnerLost")) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Yime"),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Discover!",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 8.0, right: 8.0, bottom: 30.0),
                  child: Text(
                    "Find new people from your community! We randomly connect you with another person to chat.",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 180.0,
                  height: 50.0,
                  child: RaisedButton(
                      child: Text(
                        "Connect",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.yellow,
                      onPressed: () {
                        var x = findPartner();
                        channel.sink.add(x);
                        setState(() {
                          jsonResponse = "findingPrtner";
                          scrollBool = true;
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 75.0),
                  child: Image.asset(
                    "pics/discover.png",
                    scale: 1.5,
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    ///findingPartner
    else if (jsonResponse == "findingPrtner") {
      return Scaffold(
        appBar: AppBar(
          title: Text("Yime"),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Looking for someone avaialbe.",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                LinearProgressIndicator(),
                FlatButton.icon(
                    onPressed: () {
                      var x = sayBye();
                      channel.sink.add(x);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.keyboard_backspace),
                    label: Text("Cancel and go back!"))
              ],
            )
          ],
        ),
      );
    }

    ///chatActive == true
    else if (chatActive == true) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Talking to $talkingTo"),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  var x = sayBye();
                  channel.sink.add(x);
                  Navigator.pop(context);
                  },
                icon: Icon(Icons.directions_run),
                label: Text("Leave"))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
              child: new Material(
                color: Colors.white,
                child: ListView(
                  reverse: scrollBool,
                  controller: scroller,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: buildOldChatCards(context),
                    ),
                    Divider(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: buildIncomingChat(),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              color: Colors.white,
              padding: new EdgeInsets.symmetric(horizontal: 9.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                    autofocus: true,
                    controller: editingController,
                    decoration: new InputDecoration(
                      hintText: 'Chat message',
                    ),
                  )),
                  IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (editingController.text.isNotEmpty) {
                          var x = sendMessage(editingController.text);
                          checkConnection().then((onValue) {
                            if (onValue.toString() == "connected") {
                              channel.sink.add(x);
                              setState(() {
                                var y = jsonDecode(x);
                                var z = y['data'];
                                texts.add('Me: $z');
                              });
                              editingController.text = "";
                              toEnd();
                            } else {
                              print("hiiiiiii");
                              displayDialogue();
                              toEnd();
                            }
                          });
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      );
    }

    ///if WebSocket has Error
    else if (jsonResponse == "error!") {
      return Scaffold(
        appBar: AppBar(
          title: Text("Yime"),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Are you connected to the internet?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28.0)),
                ),
                FlatButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.keyboard_backspace),
                    label: Text("Tap to go back"))
              ],
            )
          ],
        ),
      );
    }

    ///A default LinearProgressIndicator
    else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Yime"),
        ),
        body: ListView(
          children: <Widget>[LinearProgressIndicator()],
        ),
      );
    }
  }

  ///Main Widget build method for this class
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Theme(
            data: ThemeData(
              primarySwatch: Colors.yellow,
              splashColor: Colors.yellow,
            ),
            child: chatProcess(context)));
  }

  ///Disposing the channel
  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
    testString = [];
    testString2 = [];
    texts = [];
    chatActive = false;
    editingController = null;
  }
}
