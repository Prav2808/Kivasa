// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kivasa/constants/colors_constants.dart';
import 'package:kivasa/utills/text_styles.dart';

import '../../../Api/onboarding_api/forgot_pass_api.dart';
import '../../../constants/icon_constants.dart';
import '../../../constants/text_constants.dart';
import '../../../utills/custom_button.dart';
import '../../../utills/custom_textformfield.dart';
import '../../../utills/navigation_rought.dart';
import 'forgot_otp_verification.dart';

String nmbr = "";

class Forgot_Password extends StatefulWidget {
  const Forgot_Password({super.key});

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
  TextEditingController phone_numcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var h, w;
  // bool forgotloader = false;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
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
        title: Text(forgot_password, style: TextStyle(color: black)),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04155),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.15),
              Padding(
                padding: EdgeInsets.only(top: h * 0.1, bottom: h * 0.00875),
                child: custom_text(phone_number,
                    style: CustomStyle().style_16_reguler(black)),
              ),
              custom_textformfield(context,
                  hintText: phone_number,
                  keyboardType: TextInputType.number,
                  controller: phone_numcontroller,
                  prefixIcon: phone,
                  maxLength: 10, validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter phone number';
                } else if (value.length < 10) {
                  return 'Please enter valid number';
                }
                nmbr = value;
                return null;
              }),
              SizedBox(height: h * 0.1),
              forgotloader
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : custom_button(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            forgotloader = true;
                          });
                          forgetpasswordApi(
                            phone_numcontroller.text.trim(),
                          ).then((value) {
                            if (value) {
                              final snackBar = SnackBar(
                                content: Text(forgetmsg ?? ""),
                                backgroundColor: (Colors.green),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              push_to(context, OTP_Verification_Forgot());
                              setState(() {
                                forgotloader = false;
                              });
                            } else {
                              final snackBar = SnackBar(
                                content: Text(forgetmsg ?? ""),
                                backgroundColor: (Colors.red),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              setState(() {
                                forgotloader = false;
                              });
                            }
                          });
                        }
                      },
                      height: h * 0.0625,
                      minWidth: h * 1,
                      text: send_otp),
            ],
          ),
        ),
      ),
    );
  }
}
