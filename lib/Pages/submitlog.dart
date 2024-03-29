import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'logdetails.dart';

SignUpDetails sign = SignUpDetails();
EnterCodeLoginDetails enterCode = EnterCodeLoginDetails();
LogInDetails logIn = LogInDetails();
//SaveGetLoadAccessToken accessKey = SaveGetLoadAccessToken();
bool status;
String accessToken;

class ContactService {
  static const _serviceUrl = 'https://yime.herokuapp.com/api/login';
  static final _headers = {'Content-Type': 'application/json'};

  Future<dynamic> createContact(logIn) async {
    try {
      String data = _toJson(logIn);
      final response =
          await http.post(_serviceUrl, headers: _headers, body: data);
      var c = (jsonDecode(response.body));
      sign.token = c["token"];
      enterCode.token = c["token"];
      status = c["registration"];
      return (sign.token);
    } catch (e) {
      bool y = false;
      print("server exception on create contact");
      return y.toString();
    }
  }

  String _toJson(logIn) {
    var mapData = new Map();
    mapData["phonenumber"] = logIn.phonenumber;
    String data = json.encode(mapData);
    return data;
  }

  //returns the status of registration
  bool getStatus() {
    return status;
  }
}

class SignUpService {
  static const _serviceUrl = 'https://yime.herokuapp.com/api/register';
  static final _headers = {'Content-Type': 'application/json'};

  Future<dynamic> createSignUp(sign) async {
    try {
      String data2 = _toJson(sign);
      print(data2);
      final response =
          await http.post(_serviceUrl, headers: _headers, body: data2);
      var c = (jsonDecode(response.body)); //do we get the access token now?
      accessToken = c["accesstoken"];
      print(accessToken);
      return accessToken;
    } catch (e) {
      var y = 'failed';
      print("server exception on create signup");
      print(e);
      return y;
    }
  }

  String _toJson(sign) {
    var mapData = new Map();
    mapData["token"] = sign.token;
    mapData["code"] = sign.code;
    mapData["name"] = sign.name;
    mapData["zipcode"] = sign.zipcode;
    String data = json.encode(mapData);
    return data;
  }
}

class EnterCodeLoginService {
  static const _serviceUrl = 'https://yime.herokuapp.com/api/code';
  static final _headers = {'Content-Type': 'application/json'};

  Future<dynamic> createCodeLogin(enterCode) async {
    try {
      String data = _toJson(enterCode);
      final response =
          await http.post(_serviceUrl, headers: _headers, body: data);
      var c = (jsonDecode(response.body));
      accessToken = c["accesstoken"];
      print(accessToken); //the access token
      //accessKey.savedTokenPreference(accessToken);
      return accessToken; //return the access code
    } catch (e) {
      var y = 'failed';
      print('Server Exception login!!!');
      print(e);
      return y;
    }
  }

  String _toJson(enterCode) {
    var mapData = new Map();
    //mapData["name"] = contact.name;
    //mapData["dob"] = new DateFormat.yMd().format(contact.dob);
    mapData["token"] = enterCode.token;
    mapData["code"] = enterCode.code;
    //mapData["favoriteColor"] = contact.favoriteColor;
    String data = json.encode(mapData);
    return data;
  }
}


