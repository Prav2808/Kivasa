// ignore_for_file: prefer_const_constructors, unused_import, unused_local_variable, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:kivasa/Api/onboarding_api/login_api.dart';
import 'package:kivasa/screens/bottom_bar/bottom_appbar_screen.dart';
import '../../Api/url.dart';
import '../../constants/colors_constants.dart';
import '../../constants/image_constants.dart';
import '../../utills/navigation_rought.dart';
import '../landing_screen/landing_screen_main.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  @mustCallSuper
  void initState() {
    assignPrefData();
    Future.delayed(const Duration(milliseconds: 1500), () {
      UserId == null || UserId == "null" || UserId == ''
          ? pushAndRevoveUntil(context, Landing_Screen())
          : pushAndRevoveUntil(context, Bottom_App_Bar());
    });
    super.initState();
  }

  var h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04155),
        child: Center(child: Image.asset(logo)),
      ),
    );
  }
}
