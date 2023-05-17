// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, empty_catches, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kivasa/Api/url.dart';
import 'package:kivasa/utills/navigation_rought.dart';

import '../onboarding_api/login_api.dart';

Future myAccountUpdate(
  BuildContext context,
) async {
  try {
    var response = await http.post(
      Uri.parse(getuserprofile),
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
  } catch (e) {
    print("$e server error");
  }
}

class UserProfile {
  final int id;
  final String name;
  final String email;
  final String phone_no;
  final String image;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone_no,
    required this.image,
  });

  factory UserProfile.fromJson(Map<String, dynamic> data) {
    return UserProfile(
        id: data["data"]['id'],
        name: data["data"]['name'],
        email: data["data"]['email'],
        phone_no: data["data"]['phone_no'],
        image: data["data"]['profile_pic']);
  }
}

var msgprofileupdate;

Future regFirst(BuildContext context, var name, var email, var image, l) async {
  try {
    var headers = {"Authorization": "Bearer $UserToken"};
    var request = http.MultipartRequest('POST', Uri.parse(profileupdateurl));
    request.fields.addAll(
      {"user_id": UserId, 'name': name, "email": email},
    );

    if (image != 'assets/images/person.png') {
      request.files.add(await http.MultipartFile.fromPath('image', image));
    }

    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();

      var jsonRes = jsonDecode(res.toString());
      msgprofileupdate = jsonRes["message"];

      if (jsonRes["status"]) {
        return true;
      }
      return false;
    } else if (response.statusCode == 501) {
      onlogOut(context);
    }
  } catch (e) {
    print("$e server error");
  }
}
