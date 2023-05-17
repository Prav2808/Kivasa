// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, override_on_non_overriding_member, annotate_overrides, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../Api/home_api/closedorder_api.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/text_constants.dart';
import '../../../utills/custom_container.dart';
import '../../../utills/text_styles.dart';

class Closed_Order extends StatefulWidget {
  const Closed_Order({super.key});

  @override
  State<Closed_Order> createState() => _Closed_OrderState();
}

class _Closed_OrderState extends State<Closed_Order> {
  var userData;

  @override
  void initState() {
    super.initState();

    closedorderapi(context).then((value) {
      if (value != null) {
        setState(() {
          userData = value["data"]["closed_order"] as List;
        });
      }
    });
  }

  var h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : userData.length == 0
              ? Center(
                  child: Text("No Closed Order List"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: userData.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: w * 0.0277, top: h * 0.02),
                  itemBuilder: (BuildContext context, int index) {
                    return custom_container(
                      width: w * 1,
                      margin: EdgeInsets.only(bottom: h * 0.0375),
                      border: Border.all(color: black05),
                      child: Column(
                        children: [
                          custom_container(
                            width: w * 1,
                            color: blue50,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.02216, vertical: h * 0.015),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          custom_text(order,
                                              style: CustomStyle()
                                                  .style_16_medium(white)),
                                          SizedBox(width: w * 0.01385),
                                          custom_text(
                                              userData[index]['orderid'],
                                              style: CustomStyle()
                                                  .style_15_medium(white))
                                        ],
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        width: w * 0.4,
                                        child: custom_text(
                                            "${userData[index]["open_status_date"].toString()} ${userData[index]["open_status_time"].toString()}",
                                            style: CustomStyle()
                                                .style_15_medium(black50)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w * 0.02216, vertical: h * 0.015),
                            child: custom_container(
                              height: h * 0.2105,
                              width: w * 1,
                              border: Border.all(color: black05, width: 1),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w * 0.04155,
                                    vertical: h * 0.01875),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        custom_text(
                                            userData[index]['vehicle']
                                                ["company_name"],
                                            style: CustomStyle()
                                                .style_16_medium(black)),
                                        custom_text(" - ",
                                            style: CustomStyle()
                                                .style_16_medium(black)),
                                        custom_text(
                                            userData[index]['vehicle']["modal"],
                                            style: CustomStyle()
                                                .style_16_medium(black)),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: h * 0.015),
                                      child: Row(
                                        children: [
                                          custom_text(vehicle_registration,
                                              style: CustomStyle()
                                                  .style_14_reguler(black30)),
                                          SizedBox(
                                            width: w * 0.01,
                                          ),
                                          custom_text(
                                              userData[index]['vehicle']
                                                  ["vehicle_reg_no"],
                                              style: CustomStyle()
                                                  .style_12_reguler(black30)),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        custom_text(phone_number1,
                                            style: CustomStyle()
                                                .style_14_reguler(black30)),
                                        SizedBox(
                                          width: w * 0.01,
                                        ),
                                        custom_text(
                                            userData[index]['vehicle']
                                                ["phone_number"],
                                            style: CustomStyle()
                                                .style_14_reguler(black30)),
                                      ],
                                    ),
                                    SizedBox(height: h * 0.0225),
                                    custom_container(
                                      height: h * 0.04,
                                      width: w * 0.25,
                                      alignment: Alignment.center,
                                      color: black,
                                      borderRadius: BorderRadius.circular(5),
                                      child: custom_text(completed,
                                          style: CustomStyle()
                                              .style_15_medium(white)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          custom_container(
                            width: w * 1,
                            color: black05,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.03324,
                                  vertical: h * 0.0075),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      custom_text(complete_order,
                                          style: CustomStyle()
                                              .style_16_reguler(green)),
                                      Spacer(),
                                      custom_text(
                                          userData[index]['status_date'],
                                          style: CustomStyle()
                                              .style_15_reguler(green)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: h * 0.01,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      custom_text(
                                          userData[index]['status_time'],
                                          style: CustomStyle()
                                              .style_15_reguler(green)),
                                      Spacer(),
                                      custom_text(total_paid,
                                          style: CustomStyle()
                                              .style_16_medium(black)),
                                      custom_text(
                                          userData[index]['vehicle']["price"],
                                          style: CustomStyle()
                                              .style_16_medium(black)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
    );
  }
}
