// ignore_for_file: prefer_const_constructors, unused_local_variable, camel_case_types

import 'package:flutter/material.dart';
import 'package:kivasa/constants/text_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utills/custom_appbar.dart';
class Contect_Us extends StatefulWidget {
  const Contect_Us({super.key});

  @override
  State<Contect_Us> createState() => _Contect_UsState();
}

class _Contect_UsState extends State<Contect_Us> {
  @override
  Widget build(BuildContext context) {
     var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
return Scaffold( appBar: custom_appbar(context,text: contact_us),
        body: WebView(
          initialUrl: "https://kivasa.com/contactus",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      
    );
  }
}
