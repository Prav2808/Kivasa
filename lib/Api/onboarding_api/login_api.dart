// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, empty_catches

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kivasa/Api/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

var login_msg;
var UserId;
var UserEmail;
var UserName;
var UserToken;
Future login_API(var password, var phoneNo) async {
  try {
    var response = await http.post(Uri.parse(loginurl), body: {
      'password': phoneNo,
      "phone_no": password,
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      login_msg = data['message'];
      if (data['status']) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", data["token"].toString());
        await prefs.setString('u_id', data['data']["id"].toString());
        await prefs.setString('u_email', data['data']["email"].toString());
        await prefs.setString('u_name', data['data']["name"].toString());

        login_msg = data['message'].toString();
        assignPrefData();
        return true;
      } else {
        login_msg = data['message'].toString();
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {}
}
