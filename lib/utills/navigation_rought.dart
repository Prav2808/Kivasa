// ignore_for_file: non_constant_identifier_names, unused_import

import 'package:flutter/material.dart';
import 'package:kivasa/screens/onboarding/sign_in/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

push_to(BuildContext context, Widget name) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => name));
}

replaceRoute(BuildContext context, Widget name) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => name));
}

pushAndRevoveUntil(BuildContext context, Widget name) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: ((context) => name)), (route) => false);
}

onlogOut(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.clear();
  const snackBar = SnackBar(
    content: Text("Session Expire"),
    backgroundColor: (Colors.red),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // ignore: use_build_context_synchronously
  pushAndRevoveUntil(context, const LogIn());
}
