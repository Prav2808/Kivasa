// ignore_for_file: prefer_typing_uninitialized_variables, empty_catches

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kivasa/Api/url.dart';

var forgetotpmsg;
bool forgototploader = false;
Future forgetotpApi(var phoneNo, var otp) async {
  forgetotpmsg;
  try {
    var resdata = await http
        .post(Uri.parse(forget_url), body: {'phone_no': phoneNo, 'otp': otp});

    if (resdata.statusCode == 200) {
      final data = json.decode(resdata.body);
      forgetotpmsg = data['message'];
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
