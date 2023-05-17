// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kivasa/Api/home_api/trackorder_api.dart';
import 'package:kivasa/constants/colors_constants.dart';
import 'package:kivasa/utills/custom_appbar.dart';

import '../../../Api/home_api/myorder_api.dart';
import '../../../constants/text_constants.dart';
import '../../../utills/custom_container.dart';
import '../../../utills/text_styles.dart';

class Trackorder extends StatefulWidget {
  Trackorder(
      {Key? key,
      required this.id,
      required this.company,
      required this.modal,
      required this.orderid,
      required this.phone_no,
      required this.price,
      required this.vechile_reg_no})
      : super(key: key);

  String orderid;
  String vechile_reg_no;
  String phone_no;
  String price;
  String modal;
  String company;
  String id;

  @override
  State<Trackorder> createState() => _TrackorderState();
}

class _TrackorderState extends State<Trackorder> {
  List<Stepper> stepperList = [];
  bool trackorderLoader = false;
  var userData;
  var h, w;
  @override
  void initState() {
    trackorderLoader = true;
    trackorderapi(context, widget.id).then((value) {
      if (value != null) {
        setState(() {
          userData = value["data"];
        });
        stepperList.add(Stepper(
          status: "Confirmed",
          date: userData["confirmedorder"] == null
              ? ""
              : "${userData["confirmedorder"]["status_date"]} ${userData["confirmedorder"]["status_time"]}",
          title: "your order has been confirmed",
          isDone: userData["confirmedorder"] == null ? false : true,
        ));
        stepperList.add(Stepper(
          status: "Packed",
          date: userData["packed_order"] != null
              ? "${userData["packed_order"]["status_date"]} ${userData["packed_order"]["status_time"]}"
              : "",
          title: "your order has been packed",
          isDone: userData["packed_order"] == null ? false : true,
        ));
        stepperList.add(Stepper(
          status: "Shipped",
          date: userData["shipped_order"] != null
              ? "${userData["shipped_order"]["status_date"]} ${userData["shipped_order"]["status_time"]}"
              : "",
          title: "your order has been shipped",
          isDone: userData["shipped_order"] == null ? false : true,
        ));
        stepperList.add(Stepper(
          status: "Delivered",
          date: userData["delivered_order"] != null
              ? "${userData["delivered_order"]["status_date"]} ${userData["delivered_order"]["status_time"]}"
              : "",
          title: "your order has been deliverd",
          isDone: userData["delivered_order"] == null ? false : true,
        ));
        trackorderLoader = false;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    double heightWithoutappBar = h - (kToolbarHeight);
    return Scaffold(
        appBar: custom_appbar(
          context,
          text: "Order Tracking",
        ),
        body: trackorderLoader
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  stepperList.clear();
                  trackorderapi(context, widget.id).then((value) {
                    if (value != null) {
                      setState(() {
                        userData = value["data"];
                      });
                      stepperList.add(Stepper(
                        status: "Confirmed",
                        date: userData["confirmedorder"] == null
                            ? ""
                            : "${userData["confirmedorder"]["status_date"]} ${userData["confirmedorder"]["status_time"]}",
                        title: "your order has been confirmed",
                        isDone:
                            userData["confirmedorder"] == null ? false : true,
                      ));
                      stepperList.add(Stepper(
                        status: "Packed",
                        date: userData["packed_order"] != null
                            ? "${userData["packed_order"]["status_date"]} ${userData["packed_order"]["status_time"]}"
                            : "",
                        title: "your order has been packed",
                        isDone: userData["packed_order"] == null ? false : true,
                      ));
                      stepperList.add(Stepper(
                        status: "Shipped",
                        date: userData["shipped_order"] != null
                            ? "${userData["shipped_order"]["status_date"]} ${userData["shipped_order"]["status_time"]}"
                            : "",
                        title: "your order has been shipped",
                        isDone:
                            userData["shipped_order"] == null ? false : true,
                      ));
                      stepperList.add(Stepper(
                        status: "Delivered",
                        date: userData["delivered_order"] != null
                            ? "${userData["delivered_order"]["status_date"]} ${userData["delivered_order"]["status_time"]}"
                            : "",
                        title: "your order has been deliverd",
                        isDone:
                            userData["delivered_order"] == null ? false : true,
                      ));
                    }
                  });
                },
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: heightWithoutappBar,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(children: [
                        custom_container(
                          width: w * 1,
                          color: blue50,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w * 0.02216, vertical: h * 0.02),
                            child: Row(
                              children: [
                                custom_text(order,
                                    style:
                                        CustomStyle().style_16_medium(white)),
                                SizedBox(width: w * 0.01385),
                                custom_text(widget.orderid,
                                    style: CustomStyle().style_16_medium(white))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration:
                              BoxDecoration(border: Border.all(color: black50)),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: black50)),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: stepperList.length,
                                  itemBuilder:
                                      (BuildContext context, int itemIndex) {
                                    return Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          stepperList[itemIndex]
                                                                      .isDone ==
                                                                  true
                                                              ? Colors.green
                                                              : Colors.grey,
                                                      shape: BoxShape.circle),
                                                ),
                                                itemIndex !=
                                                        stepperList.length - 1
                                                    ? SizedBox(
                                                        height: 60,
                                                        child: VerticalDivider(
                                                          width: 2,
                                                          thickness: 2.0,
                                                          color: stepperList[
                                                                          itemIndex]
                                                                      .isDone ==
                                                                  true
                                                              ? Colors.green
                                                              : Colors.grey,
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  stepperList[itemIndex]
                                                          .status ??
                                                      "",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    stepperList[itemIndex]
                                                                .isDone ==
                                                            true
                                                        ? stepperList[itemIndex]
                                                                .title ??
                                                            ""
                                                        : "",
                                                    style: const TextStyle(
                                                        color: Colors.black)),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    stepperList[itemIndex]
                                                                .isDone ==
                                                            true
                                                        ? stepperList[itemIndex]
                                                                .date ??
                                                            ""
                                                        : "",
                                                    style: const TextStyle(
                                                        color: Colors.grey)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: black50)),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: custom_text(
                                          "${widget.company} - ${widget.modal}",
                                          style: CustomStyle()
                                              .style_15_medium(black)),
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
                                            width: w * 0.0277,
                                          ),
                                          custom_text(widget.vechile_reg_no,
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
                                        custom_text(widget.phone_no,
                                            style: CustomStyle()
                                                .style_14_reguler(black30)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        custom_text(total_paid,
                                            style: CustomStyle()
                                                .style_16_medium(black)),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: w * 0.03324,
                                              left: w * 0.02216),
                                          child: custom_text(widget.price,
                                              style: CustomStyle()
                                                  .style_16_medium(black)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ));
  }
}

class Stepper {
  Stepper({
    this.status,
    this.date,
    this.title,
    this.isDone,
  });

  final String? date;
  bool? isDone = false;
  final String? status;
  final String? title;
}
