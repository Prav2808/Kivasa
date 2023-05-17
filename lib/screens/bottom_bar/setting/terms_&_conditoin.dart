// ignore_for_file: prefer_const_constructors, unused_local_variable, file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:kivasa/constants/text_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utills/custom_appbar.dart';
class Terms_Condition extends StatefulWidget {
  const Terms_Condition({super.key});

  @override
  State<Terms_Condition> createState() => _Terms_ConditionState();
}

class _Terms_ConditionState extends State<Terms_Condition> {
  @override
  Widget build(BuildContext context) {
     var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
return Scaffold(appBar: custom_appbar(context ,text: terms_condition,),
        body: WebView(
          initialUrl: "https://kivasa.com/term-and-condition",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      
    );
  }
}
