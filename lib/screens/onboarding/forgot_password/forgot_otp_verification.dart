// ignore_for_file: unnecessary_import, camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_is_empty

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kivasa/utills/custom_otp_text_field.dart';

import '../../../Api/onboarding_api/forgot_pass_api.dart';
import '../../../Api/onboarding_api/forgototp_api.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/text_constants.dart';
import '../../../utills/custom_button.dart';
import '../../../utills/navigation_rought.dart';
import '../../../utills/text_styles.dart';
import 'create_new_password.dart';
import 'forgot_password.dart';

class OTP_Verification_Forgot extends StatefulWidget {
  const OTP_Verification_Forgot({super.key});

  @override
  State<OTP_Verification_Forgot> createState() =>
      _OTP_Verification_ForgotState();
}

class _OTP_Verification_ForgotState extends State<OTP_Verification_Forgot> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  String otpall = "";
  var h, w;
  var forgotloader = false;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: black,
            )),
        title: Text(otp_verifi, style: TextStyle(color: black)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.05,
        ),
        child: ListView(children: [
          Padding(
            padding: EdgeInsets.only(top: h * 0.15, bottom: h * 0.002),
            child: custom_text(suggestion_otp,
                style: CustomStyle().style_18_reguler(black)),
          ),
          Row(
            children: [
              custom_text(phone_number,
                  style: CustomStyle().style_18_reguler(black)),
              SizedBox(
                width: w * 0.02,
              ),
              custom_text(nmbr,
                  style: CustomStyle().style_18_reguler(buttonclr)),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: h * 0.1, bottom: h * 0.1),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                  (index) => Textfromfield(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.length == 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                      controller: index == 0
                          ? controller1
                          : index == 1
                              ? controller2
                              : index == 2
                                  ? controller3
                                  : controller4),
                )),
          ),
          forgototploader
              ? Center(child: CircularProgressIndicator.adaptive())
              : custom_button(
                  onPressed: () {
                    if (otpall.length <= 4) {
                      setState(() {
                        forgototploader = true;
                      });
                      otpall = controller1.text +
                          controller2.text +
                          controller3.text +
                          controller4.text;
                      forgetotpApi(nmbr, otpall.toString()).then((value) {
                        if (value) {
                          final snackBar = SnackBar(
                            content: Text(forgetotpmsg ?? ""),
                            backgroundColor: (Colors.green),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          replaceRoute(context, Create_New_Password());
                          setState(() {
                            forgototploader = false;
                          });
                        } else {
                          final snackBar = SnackBar(
                            content: Text(forgetotpmsg ?? ""),
                            backgroundColor: (Colors.red),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {
                            forgototploader = false;
                          });
                        }
                      });
                    }
                  },
                  height: h * 0.0625,
                  minWidth: h * 1,
                  text: submit),
          SizedBox(height: h * 0.025),
          forgotloader
              ? Center(child: CircularProgressIndicator())
              : InkWell(
                  onTap: () {
                    setState(() {
                      forgotloader = true;
                    });
                    forgetpasswordApi(
                      nmbr.toString(),
                    ).then((value) {
                      if (value) {
                        final snackBar = SnackBar(
                          content: Text(forgetmsg ?? ""),
                          backgroundColor: (Colors.green),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        setState(() {
                          forgotloader = false;
                        });
                      } else {
                        final snackBar = SnackBar(
                          content: Text(forgetmsg ?? ""),
                          backgroundColor: (Colors.red),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                          forgotloader = false;
                        });
                      }
                    });
                  },
                  child: custom_text_with_center(
                      text: resend,
                      style: CustomStyle().style_15_medium(buttonclr))),
        ]),
      ),
    );
  }
}
