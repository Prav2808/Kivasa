// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:kivasa/constants/text_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utills/custom_appbar.dart';
class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
     var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
return Scaffold( appBar: custom_appbar(context,text: faq),
        body: WebView(
          initialUrl: "https://kivasa.com/faqs",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      
    );
  }
}
