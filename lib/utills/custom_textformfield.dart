// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:kivasa/utills/text_styles.dart';

import '../constants/colors_constants.dart';

Widget custom_textformfield(BuildContext context,
    {String? hintText,
    int? maxLength,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    Widget? prefixIcon,
    TextEditingController? controller,
    String? Function(String?)? validator,
    bool? obscureText = false,
    bool readOnly = false}) {
  var h = MediaQuery.of(context).size.height;
  var w = MediaQuery.of(context).size.width;
  return TextFormField(
    readOnly: readOnly,
    obscureText: obscureText!,
    obscuringCharacter: "●",
    maxLength: maxLength,
    keyboardType: keyboardType,
    keyboardAppearance: Brightness.light,
    cursorWidth: w * 0.00277,
    controller: controller,
    style: CustomStyle().style_16_reguler(black),
    decoration: InputDecoration(
      counterText: "",
      contentPadding: EdgeInsets.symmetric(horizontal: w * 0.0277),
      fillColor: black05,
      filled: true,
      hintText: hintText,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintStyle: CustomStyle().style_16_reguler(black50),
      border: InputBorder.none,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: transparent),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: black),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: black),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: black),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    validator: validator,
  );
}

Widget custom_textformfield1(
  BuildContext context, {
  String? hintText,
  int? maxLength,
  TextInputType? keyboardType,
  Widget? suffixIcon,
  Widget? prefixIcon,
  TextEditingController? controller,
  String? Function(String?)? validator,
  bool readOnly = false,
  int? itemCount,
  List? text,
  double? container_height,
}) {
  var h = MediaQuery.of(context).size.height;
  var w = MediaQuery.of(context).size.width;
  return TextFormField(
    readOnly: readOnly,
    maxLength: maxLength,
    keyboardType: keyboardType,
    keyboardAppearance: Brightness.light,
    cursorWidth: w * 0.00277,
    controller: controller,
    style: CustomStyle().style_16_reguler(black),
    decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.only(left: w * 0.0277),
        fillColor: black05,
        filled: true,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintStyle: CustomStyle().style_16_reguler(black50),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: black),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: black),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: black),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: black),
          borderRadius: BorderRadius.circular(8),
        )),
    validator: validator,
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          contentPadding: EdgeInsets.all(10),
          actionsPadding: EdgeInsets.all(10),
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          backgroundColor: Colors.white,
          content: Builder(builder: (context) {
            return Container(
              height: container_height,
              width: 0.3601,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: white,
              ),
              child: ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: InkWell(
                          onTap: () {
                            controller!.text = text?.elementAt(index);
                            Navigator.pop(context);
                          },
                          child: custom_text(text?.elementAt(index),
                              style: CustomStyle().style_16_reguler(black))),
                    );
                  }),
            );
          }),
        ),
      );
    },
  );
}
