// ignore_for_file: camel_case_types, unused_import, prefer_typing_uninitialized_variables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:kivasa/constants/image_constants.dart';
import 'package:kivasa/screens/landing_screen/scan_screen.dart';
import 'package:kivasa/screens/onboarding/sign_in/sign_in.dart';
import 'package:kivasa/utills/text_styles.dart';
import '../../constants/colors_constants.dart';
import '../../constants/icon_constants.dart';
import '../../constants/text_constants.dart';
import '../../utills/custom_button.dart';
import '../../utills/navigation_rought.dart';

class Landing_Screen extends StatefulWidget {
  const Landing_Screen({super.key});

  @override
  State<Landing_Screen> createState() => _Landing_ScreenState();
}

class _Landing_ScreenState extends State<Landing_Screen> {
  var h, w;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.only(
            left: w * 0.04155, right: w * 0.04155, top: h * 0.0275),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                logo,
                height: h * 0.1,
              ),
            ),
            SizedBox(
              height: h * .1,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/images/welcome.png")),
            Padding(
                padding: EdgeInsets.only(
                  top: h * 0.025,
                ),
                child: custom_text(
                  "Scan N Call is a unique product which is solves All Cars/Taxi/Truck/Van/Auto, owner problem, which I have seen daily in our lives.",
                  style: CustomStyle().style_16_reguler(black50),
                  textAlign: TextAlign.justify,
                )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: h * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            custom_con_button(
              context,
              onTap: () {
                push_to(context, Scan());
              },
              icon: scan_icon,
            ),
            custom_con_button(
              context,
              onTap: () {
                push_to(context, LogIn());
              },
              icon: login_icon,
            )
          ],
        ),
      ),
    );
  }
}
