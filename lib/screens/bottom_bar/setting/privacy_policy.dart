// ignore_for_file: prefer_const_constructors, unused_local_variable, camel_case_types

import 'package:flutter/material.dart';
import 'package:kivasa/constants/text_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utills/custom_appbar.dart';
class Privacy_Policy extends StatefulWidget {
  const Privacy_Policy({super.key});

  @override
  State<Privacy_Policy> createState() => _Privacy_PolicyState();
}

class _Privacy_PolicyState extends State<Privacy_Policy> {
  @override
  Widget build(BuildContext context) {
     var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
return Scaffold( appBar: custom_appbar(context,text: privacy_policy),
        body: WebView(
          initialUrl: "https://kivasa.com/privacy-policy",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      
    );
  }
}
