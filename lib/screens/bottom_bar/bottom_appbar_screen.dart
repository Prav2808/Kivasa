// ignore_for_file: unnecessary_import, unused_import, camel_case_types, duplicate_ignore, prefer_typing_uninitialized_variables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kivasa/constants/colors_constants.dart';
import 'package:kivasa/constants/image_constants.dart';
import 'package:kivasa/constants/text_constants.dart';
import 'package:kivasa/screens/bottom_bar/get_qr.dart';
import 'package:kivasa/screens/bottom_bar/scan_qr.dart';
import 'package:kivasa/screens/bottom_bar/setting/setting.dart';
import '../../constants/icon_constants.dart';
import 'home.dart';
import 'my_order/my_order.dart';

class Bottom_App_Bar extends StatefulWidget {
  const Bottom_App_Bar({super.key});
  @override
  State<Bottom_App_Bar> createState() => _Bottom_App_BarState();
}

class _Bottom_App_BarState extends State<Bottom_App_Bar> {
  int currentIndex = 0;
  List<Widget> navigationpage = [
    const Home(),
    const Scan_Qr(),
    Get_Qr(),
    const My_Order(),
    const Setting()
  ];
  var h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: buttonclr,
          unselectedItemColor: black,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: home_icon,
              label: home_text,
            ),
            BottomNavigationBarItem(icon: scanner_icon, label: scan_qr),
            BottomNavigationBarItem(icon: get_scanner, label: get_qr),
            BottomNavigationBarItem(
                icon: Image.asset(
                  order_ican,
                  height: h * 0.03125,
                  color: currentIndex == 3 ? buttonclr : black,
                ),
                label: my_order),
            BottomNavigationBarItem(icon: setting_icon, label: setting)
          ]),
      body: navigationpage.elementAt(currentIndex),
    );
  }
}
