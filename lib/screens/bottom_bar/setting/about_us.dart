// ignore_for_file: prefer_const_constructors, unused_local_variable, camel_case_types

import 'package:flutter/material.dart';
import 'package:kivasa/constants/text_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../utills/custom_appbar.dart';
class About_Us extends StatefulWidget {
  const About_Us({super.key});

  @override
  State<About_Us> createState() => _About_UsState();
}

class _About_UsState extends State<About_Us> {
  @override
  Widget build(BuildContext context) {
     var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
return Scaffold( appBar: custom_appbar(context,text: about_us),
        body: WebView(
          initialUrl: "https://kivasa.com/about-us",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      
    );
  }
}
