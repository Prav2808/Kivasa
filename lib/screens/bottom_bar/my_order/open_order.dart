// ignore_for_file: unnecessary_import, camel_case_types, prefer_typing_uninitialized_variables, override_on_non_overriding_member, annotate_overrides, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kivasa/constants/text_constants.dart';
import 'package:kivasa/screens/bottom_bar/my_order/trackorder.dart';
import '../../../Api/home_api/myorder_api.dart';
import '../../../constants/colors_constants.dart';
import '../../../utills/custom_container.dart';
import '../../../utills/navigation_rought.dart';
import '../../../utills/text_styles.dart';

class Open_Orders extends StatefulWidget {
  const Open_Orders({super.key});

  @override
  State<Open_Orders> createState() => _Open_OrdersState();
}

class _Open_OrdersState extends State<Open_Orders> {
  var h, w;

  var userData;

  @override
  void initState() {
    super.initState();

    myorderapi(context).then((value) {
      if (value != null) {
        setState(() {
          userData = value["data"]["open_orders"] as List;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : userData.length == 0
              ? Center(
                  child: Text("No Open Order List"),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userData.length,
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
                                  horizontal: w * 0.02216, vertical: h * 0.01),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                            "${userData[index]["status_date"]} ${userData[index]["status_time"]}"
                                                .toString(),
                                            style: CustomStyle()
                                                .style_15_medium(black50)),
                                      )
                                    ],
                                  ),
                                  custom_container(
                                    height: h * 0.0375,
                                    width: w * 0.1939,
                                    alignment: Alignment.center,
                                    color: black,
                                    borderRadius: BorderRadius.circular(5),
                                    child: custom_text(placed,
                                        style: CustomStyle()
                                            .style_16_medium(white)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w * 0.02216, vertical: h * 0.015),
                            child: custom_container(
                              width: w * 1,
                              border: Border.all(
                                color: black05,
                              ),
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
                                            width: w * 0.0277,
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
                                    InkWell(
                                        onTap: () {
                                          push_to(
                                              context,
                                              Trackorder(
                                                id: userData[index]["id"]
                                                    .toString(),
                                                company: userData[index]
                                                            ['vehicle']
                                                        ["company_name"]
                                                    .toString(),
                                                modal: userData[index]
                                                        ['vehicle']["modal"]
                                                    .toString(),
                                                orderid: userData[index]
                                                        ['orderid']
                                                    .toString(),
                                                phone_no: userData[index]
                                                            ['vehicle']
                                                        ["phone_number"]
                                                    .toString(),
                                                price: userData[index]
                                                        ['vehicle']["price"]
                                                    .toString(),
                                                vechile_reg_no: userData[index]
                                                            ['vehicle']
                                                        ["vehicle_reg_no"]
                                                    .toString(),
                                              ));
                                        },
                                        child: custom_container(
                                          height: h * 0.05,
                                          width: w * 0.277,
                                          alignment: Alignment.center,
                                          color: blue,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: custom_text(track_order,
                                              style: CustomStyle()
                                                  .style_12_medium(white)),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          custom_container(
                            width: w * 1,
                            color: black05,
                            height: h * 0.05,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                custom_text(total_paid,
                                    style:
                                        CustomStyle().style_16_medium(black)),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: w * 0.03324, left: w * 0.02216),
                                  child: custom_text(
                                      userData[index]['vehicle']["price"],
                                      style:
                                          CustomStyle().style_16_medium(black)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
    );
  }
}
