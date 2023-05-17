// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kivasa/Api/url.dart';

import '../../utills/navigation_rought.dart';
import '../onboarding_api/login_api.dart';

Future closedorderapi(BuildContext context) async {
  try {
    var response = await http.post(
      Uri.parse(myorderurl),
      body: {
        "user_id": UserId,
      },
      headers: {"Authorization": "Bearer $UserToken"},
    );
    if (response.statusCode == 200) {
      final data = json.decode((response.body));

      return data;
    } else if (response.statusCode == 501) {
      onlogOut(context);
    }
  } catch (e) {}
}
