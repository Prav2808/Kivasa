// ignore_for_file: unnecessary_import, non_constant_identifier_names, unused_local_variable, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kivasa/constants/colors_constants.dart';
import 'package:kivasa/utills/text_styles.dart';

custom_list_tile(BuildContext context, String ?text,{ Function()? onTap,
  Widget? leading,}) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
  return ListTile(
    onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: h*0.001),
      // dense: true,
      leading: leading,
      minLeadingWidth: w*0.0277,
      horizontalTitleGap: w*0.02216,
      trailing: Icon(Icons.arrow_forward_ios_sharp, color: black, size: h*0.0225),
      title: custom_text(
         text, style: CustomStyle().style_15_reguler(black)));
}
