// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';

import '../constants/colors_constants.dart';

custom_container(
    {double? height,
    double? width,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    AlignmentGeometry? alignment,
    BorderRadiusGeometry? borderRadius,
    Color? color,
    BoxBorder? border,
    Widget? child,
    DecorationImage? image}) {
  return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
          border: border,
          image: image),
      child: child);
}
