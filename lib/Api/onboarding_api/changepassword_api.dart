// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, empty_catches

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kivasa/Api/onboarding_api/login_api.dart';
import 'dart:convert';

import 'package:kivasa/Api/url.dart';

import '../../utills/navigation_rought.dart';

var changepass_msg;
Future changepass_API(BuildContext context, var currentPassword,
    var newPassword, var confirmPassword, var userId) async {
  try {
    var response = await http.post(Uri.parse(changepass_url), body: {
      'current_password': currentPassword,
      "new_password": newPassword,
      "confirm_password": confirmPassword,
      "user_id": userId
    }, headers: {
      "Authorization": "Bearer $UserToken"
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null) {
        changepass_msg = data['message'];
        if (data['status']) {
          changepass_msg = data['message'].toString();
          return true;
        } else {
          changepass_msg = data['message'].toString();

          return false;
        }
      }
    } else if (response.statusCode == 501) {
      onlogOut(context);
    }
  } catch (e) {}
}
