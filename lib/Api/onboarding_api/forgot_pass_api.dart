// ignore_for_file: prefer_typing_uninitialized_variables, empty_catches

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kivasa/Api/url.dart';

var forgetmsg;
bool forgotloader = false;
Future forgetpasswordApi(
  var phoneNo,
) async {
  forgetmsg;
  try {
    var resdata = await http.post(Uri.parse(forget_url), body: {
      'phone_no': phoneNo,
      'type': "1",
    });
    if (resdata.statusCode == 200) {
      final data = json.decode(resdata.body);
      forgetmsg = data['message'];
      if (data["status"]) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {}
}
