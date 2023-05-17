// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kivasa/Api/url.dart';

import '../../utills/navigation_rought.dart';
import '../onboarding_api/login_api.dart';

Future trackorderapi(BuildContext context, orderId) async {
  try {
    var response = await http.post(
      Uri.parse(trackorderurl),
      body: {
        "order_id": orderId,
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
