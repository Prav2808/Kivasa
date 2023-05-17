// ignore_for_file: unnecessary_import, must_be_immutable, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Textfromfield extends StatelessWidget {
  TextEditingController? controller;

  Function(String)? onChanged;
  Textfromfield({
    Key? key,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);
  var h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Container(
        width: w * 0.1385,
        height: w * 0.1385,
        child: TextFormField(
          maxLength: 1,
          textAlign: TextAlign.center,
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
              counterText: "",
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff848484)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff848484)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff848484)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff848484)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff848484)),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          onChanged: onChanged,
        ));
  }
}
