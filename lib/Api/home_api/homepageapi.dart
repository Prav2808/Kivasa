// ignore_for_file: empty_catches, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kivasa/Api/url.dart';

import '../../utills/navigation_rought.dart';
import '../onboarding_api/login_api.dart';

Future homepageapi(BuildContext context) async {
  try {
    var response = await http.post(
      Uri.parse(homepageurl),
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

Future qr_activeapi(BuildContext context, int? qrId) async {
  try {
    var response = await http.post(
      Uri.parse(update_qrstatus),
      body: {
        "qr_id": qrId.toString(),
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
