// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, annotate_overrides
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kivasa/screens/bottom_bar/get_qr.dart';
import 'package:kivasa/utills/navigation_rought.dart';
import '../../Api/home_api/homepageapi.dart';
import '../../constants/colors_constants.dart';
import '../../constants/text_constants.dart';
import '../../utills/custom_appbar.dart';
import '../../utills/custom_container.dart';
import '../../utills/text_styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var userData;
  var h, w;

  @override
  void initState() {
    super.initState();

    homepageapi(context).then((value) {
      if (value != null) {
        setState(() {
          userData = value["data"] as List;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: white,
        appBar:
            custom_app(context, text: home_text, backgroundColor: buttonclr),
        body: userData == null
            ? Center(child: CircularProgressIndicator())
            : userData.length == 0
                ? Center(
                    child: Text("No Vechile List"),
                  )
                : ListView.builder(
                    itemCount: userData.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: w * 0.04155),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: h * 0.015),
                                child: custom_container(
                                  height: h * 0.225,
                                  width: w * 1,
                                  border: Border.all(color: black05, width: 1),
                                  borderRadius: BorderRadius.circular(7),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: w * 0.04155,
                                        vertical: h * 0.01875),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            custom_text(
                                                userData[index]["vehicle"]
                                                    ['company_name'],
                                                style: CustomStyle()
                                                    .style_16_medium(black)),
                                            custom_text(" - ",
                                                style: CustomStyle()
                                                    .style_16_medium(black)),
                                            custom_text(
                                                userData[index]["vehicle"]
                                                    ['modal'],
                                                style: CustomStyle()
                                                    .style_16_medium(black)),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: h * 0.022),
                                          child: Row(
                                            children: [
                                              custom_text(vehicle_registration,
                                                  style: CustomStyle()
                                                      .style_14_reguler(
                                                          black30)),
                                              SizedBox(
                                                width: w * 0.01,
                                              ),
                                              custom_text(
                                                  userData[index]["vehicle"]
                                                      ['vehicle_reg_no'],
                                                  style: CustomStyle()
                                                      .style_12_reguler(
                                                          black30)),
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
                                                userData[index]["vehicle"]
                                                    ["phone_number"],
                                                style: CustomStyle()
                                                    .style_14_reguler(black30)),
                                          ],
                                        ),
                                        SizedBox(height: h * 0.0225),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.qr_code,
                                              color: black30,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: w * 0.02),
                                              child: SizedBox(
                                                height: h * 0.04,
                                                width: w * 0.1,
                                                child: Transform.scale(
                                                  scale: 0.8,
                                                  child: CupertinoSwitch(
                                                    activeColor: buttonclr,
                                                    value: userData[index]
                                                                ["qrstatus"] ==
                                                            1
                                                        ? true
                                                        : false,
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        userData[index]
                                                                ["qrstatus"] =
                                                            value ? 1 : 0;
                                                        int? id = int.parse(
                                                            userData[index][
                                                                    "qrstatus_id"]
                                                                .toString());
                                                        qr_activeapi(
                                                            context, id);
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                push_to(
                                                    context,
                                                    Get_Qr(
                                                      vechileid: userData[index]
                                                          ["vehicle_id"],
                                                    ));
                                              },
                                              child: custom_container(
                                                height: h * 0.04,
                                                width: w * 0.1939,
                                                alignment: Alignment.center,
                                                color: buttonclr,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: custom_text(reorder,
                                                    style: CustomStyle()
                                                        .style_15_medium(
                                                            white)),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ));
                    }));
  }
}
