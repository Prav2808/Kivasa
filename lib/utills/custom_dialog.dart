// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kivasa/Api/url.dart';
import 'package:kivasa/utills/navigation_rought.dart';
import 'package:kivasa/utills/text_styles.dart';

import '../constants/colors_constants.dart';
import '../constants/text_constants.dart';
import '../screens/onboarding/sign_in/sign_in.dart';
import 'custom_button.dart';

class Dialog_Box extends StatefulWidget {
  const Dialog_Box({super.key});

  @override
  State<Dialog_Box> createState() => _Dialog_BoxState();
}

class _Dialog_BoxState extends State<Dialog_Box> {
  var h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Center(
        child: AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.white,
      content: Container(
        margin: EdgeInsets.only(left: w * 0.04155, right: w * 0.04155),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: white,
        ),
        height: h * 0.15,
        width: w * 0.83931,
        child: Column(
          children: [
            SizedBox(height: h * 0.025),
            custom_text_with_center(
                text: logut_contents,
                style: CustomStyle().style_16_reguler(black)),
            SizedBox(height: h * 0.03125),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: custom_text(cancel,
                        style: CustomStyle().style_16_reguler(blue))),
                SizedBox(
                  height: h * 0.045,
                  child: custom_button(
                      minWidth: w * 0.035,
                      onPressed: () {
                        logoutPrefData();
                        pushAndRevoveUntil(context, LogIn());
                      },
                      height: h * 0.05,
                      text: log_out),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
