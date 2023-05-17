// ignore_for_file: non_constant_identifier_names, empty_catches

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kivasa/Api/url.dart';

// ignore: prefer_typing_uninitialized_variables
var resetpass_msg;
Future resetpass_API(var password, var phoneNo) async {
  try {
    var response = await http.post(Uri.parse(resetpass_url), body: {
      'password': phoneNo,
      "phone_no": password,
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      resetpass_msg = data['message'];
      if (data['status']) {
        resetpass_msg = data['message'].toString();
        return true;
      } else {
        resetpass_msg = data['message'].toString();
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {}
}
