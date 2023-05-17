// ignore_for_file: non_constant_identifier_names, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kivasa/utills/text_styles.dart';
import '../constants/colors_constants.dart';

custom_button({
  Function()? onPressed,
  double? height,
  double? minWidth,
  String? text,
}) {
  return MaterialButton(
    onPressed: onPressed,
    color: buttonclr,
    height: height,
    minWidth: minWidth,
    child: custom_text(text, style: CustomStyle().style_18_reguler(white)),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

custom_con_button(
  BuildContext context, {
  Function()? onTap,
  String? icon,
}) {
  var h = MediaQuery.of(context).size.height;
  var w = MediaQuery.of(context).size.width;
  return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: h * 0.13,
        width: w * 0.28,
        child: Image.asset(
          icon!,
        ),
      ));
}
