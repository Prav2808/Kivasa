// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, empty_catches

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kivasa/Api/url.dart';

var msgsignup;

Future signup_API(var name, var email, var phoneNo, var password,
    var confirmPassword, var termsAndCondition) async {
  try {
    var response = await http.post(Uri.parse(signupurl), body: {
      "name": name,
      "email": email,
      "phone_no": phoneNo,
      'password': password,
      "confirm_password": confirmPassword,
      "terms_and_condition": termsAndCondition
    });
    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      msgsignup = data['message'];
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
