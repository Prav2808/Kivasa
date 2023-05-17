// ignore_for_file: camel_case_types, prefer_const_constructors, unused_import, prefer_typing_uninitialized_variables, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:kivasa/constants/colors_constants.dart';
import 'package:kivasa/screens/onboarding/sign_up/sign_up.dart';
import 'package:kivasa/utills/text_styles.dart';

import '../../../Api/onboarding_api/signup_api.dart';
import '../../../Api/onboarding_api/verifyotp_api.dart';
import '../../../constants/icon_constants.dart';
import '../../../constants/text_constants.dart';
import '../../../utills/custom_button.dart';
import '../../../utills/custom_otp_text_field.dart';
import '../../../utills/custom_textformfield.dart';
import '../../../utills/navigation_rought.dart';
import '../sign_in/sign_in.dart';

class OTP_Verification_signup extends StatefulWidget {
  const OTP_Verification_signup({super.key});

  @override
  State<OTP_Verification_signup> createState() =>
      _OTP_Verification_signupState();
}

class _OTP_Verification_signupState extends State<OTP_Verification_signup> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  bool signupLoader = false;
  bool verifyotpLoader = false;
  String otp = "";
  var h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: black,
            )),
        backgroundColor: white,
        centerTitle: true,
        title: Text(
          "OTP Varification",
          style: TextStyle(color: black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.05,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: h * 0.15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: h * 0.002),
              child: custom_text(suggestion_otp,
                  style: CustomStyle().style_18_reguler(black)),
            ),
          ),
          Row(
            children: [
              custom_text(phone_number,
                  style: CustomStyle().style_18_reguler(black)),
              SizedBox(
                width: w * 0.01,
              ),
              custom_text(Phonenumber,
                  style: CustomStyle().style_18_reguler(buttonclr)),
            ],
          ),
          SizedBox(
            height: h * 0.05,
          ),
          Padding(
            padding: EdgeInsets.only(top: h * 0.02, bottom: h * 0.05),
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
                        } else if (controller1.text.length == 0) {
                          FocusScope.of(context).nextFocus();
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
          verifyotpLoader
              ? Center(child: CircularProgressIndicator.adaptive())
              : custom_button(
                  onPressed: () {
                    if (otp.length <= 4) {
                      setState(() {
                        verifyotpLoader = true;
                      });
                      otp = controller1.text +
                          controller2.text +
                          controller3.text +
                          controller4.text;
                      verify_otp_API(Phonenumber, otp).then((value) {
                        if (value) {
                          final snackBar = SnackBar(
                            content: Text(msgverifyotp ?? ""),
                            backgroundColor: (Colors.green),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          pushAndRevoveUntil(context, LogIn());
                          setState(() {
                            verifyotpLoader = false;
                          });
                        } else {
                          final snackBar = SnackBar(
                            content: Text(msgverifyotp ?? ""),
                            backgroundColor: (Colors.red),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {
                            verifyotpLoader = false;
                          });
                        }
                      });
                    }
                  },
                  height: h * 0.0625,
                  minWidth: h * 1,
                  text: submit),
          SizedBox(height: h * 0.025),
          if (signupLoader)
            Center(child: CircularProgressIndicator())
          else
            GestureDetector(
                onTap: () {
                  setState(() {
                    signupLoader = true;
                  });
                  signup_API(NameUSer, EmailAddress, Phonenumber, PasswordUser,
                          PasswordUser, 1.toString())
                      .then((value) {
                    if (value) {
                      final snackBar = SnackBar(
                        content: Text(msgsignup ?? ""),
                        backgroundColor: (Colors.green),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      setState(() {
                        signupLoader = false;
                      });
                    } else {
                      final snackBar = SnackBar(
                        content: Text(msgsignup ?? ""),
                        backgroundColor: (Colors.red),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {
                        signupLoader = false;
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
