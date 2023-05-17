// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kivasa/constants/image_constants.dart';
import 'package:kivasa/utills/text_styles.dart';

import '../constants/colors_constants.dart';

custom_appbar(BuildContext context, {String? text, Color? backgroundColor}) {
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: white),
    title: custom_text(
      text,
      style: CustomStyle().style_22_bold(white),
    ),
    centerTitle: true,
    backgroundColor: backgroundColor,
    leading: Padding(
      padding: const EdgeInsets.only(right: 9),
      child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          )),
    ),
  );
}

custom_appbr(BuildContext context) {
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: black),
    backgroundColor: white,
    leading: Padding(
      padding: const EdgeInsets.only(right: 9),
      child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          )),
    ),
  );
}

custom_app(BuildContext context,
    {String? text, Color? backgroundColor = white}) {
  return AppBar(
    elevation: 1,
    iconTheme: IconThemeData(color: white),
    centerTitle: true,
    backgroundColor: backgroundColor,
    leading: Image.asset(
      logo2,
      color: white,
    ),
    leadingWidth: 180,
  );
}
