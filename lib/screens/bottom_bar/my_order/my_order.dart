// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_typing_uninitialized_variables, override_on_non_overriding_member, annotate_overrides, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:kivasa/constants/colors_constants.dart';
import 'package:kivasa/constants/text_constants.dart';
import 'package:kivasa/utills/text_styles.dart';
import 'cloced_order.dart';
import 'open_order.dart';

class My_Order extends StatefulWidget {
  const My_Order({super.key});
  @override
  State<My_Order> createState() => _My_OrderState();
}

class _My_OrderState extends State<My_Order> {
  @override
  var h, w;
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          centerTitle: true,
          title: Text(my_order, style: CustomStyle().style_22_bold(black)),
          bottom: TabBar(
            physics: BouncingScrollPhysics(),
            indicatorWeight: w * 0.00554,
            indicatorColor: black,
            labelColor: black,
            unselectedLabelColor: black30,
            tabs: [
              Tab(child: custom_text(open_order)),
              Tab(child: custom_text(closed_order)),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.04155,
          ),
          child: Expanded(
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              children: [Open_Orders(), Closed_Order()],
            ),
          ),
        ),
      ),
    );
  }
}
