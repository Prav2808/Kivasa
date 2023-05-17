// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, empty_catches

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kivasa/Api/url.dart';

var msgverifyotp;
Future verify_otp_API(var phoneNo, var otp) async {
  try {
    var response = await http
        .post(Uri.parse(varifyurl), body: {"phone_no": phoneNo, "otp": otp});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      msgverifyotp = data['message'];
      if (data['status']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {}
}
