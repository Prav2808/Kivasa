// ignore_for_file: unused_import, implementation_imports, unnecessary_import, depend_on_referenced_packages, non_constant_identifier_names, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:kivasa/constants/colors_constants.dart';
import 'package:kivasa/constants/text_constants.dart';
import 'package:kivasa/screens/onboarding/sign_up/sign_up.dart';
import 'package:kivasa/utills/custom_button.dart';
import 'package:kivasa/utills/custom_textformfield.dart';
import 'package:kivasa/utills/text_styles.dart';

import '../../../Api/onboarding_api/login_api.dart';
import '../../../constants/icon_constants.dart';
import '../../../constants/image_constants.dart';
import '../../../utills/navigation_rought.dart';
import '../../bottom_bar/bottom_appbar_screen.dart';
import '../forgot_password/forgot_password.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController phone_numcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var h, w;
  var loginloader = false;
  bool visiblepass = false;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04155),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: h * 0.02),
              Padding(
                padding: EdgeInsets.only(bottom: h * 0.075),
                child: Image.asset(
                  logo,
                  height: h * 0.125,
                ),
              ),
              custom_text_with_center(
                  text: suggestion_signin1,
                  style: CustomStyle().style_17_reguler(black)),
              Padding(
                padding: EdgeInsets.only(top: h * 0.03125, bottom: h * 0.00875),
                child: custom_text(phone_number,
                    style: CustomStyle().style_16_reguler(black)),
              ),
              custom_textformfield(
                context,
                hintText: phone_number,
                keyboardType: TextInputType.number,
                controller: phone_numcontroller,
                prefixIcon: phone,
                maxLength: 10,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter phone number';
                  } else if (value.length < 10) {
                    return 'Please enter valid number';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 0.01875, bottom: h * 0.00875),
                child: custom_text(password,
                    style: CustomStyle().style_16_reguler(black)),
              ),
              custom_textformfield(
                context,
                hintText: password,
                keyboardType: TextInputType.visiblePassword,
                controller: passwordcontroller,
                prefixIcon: password_icon,
                suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        visiblepass = !visiblepass;
                      });
                    },
                    child: visiblepass
                        ? Icon(
                            Icons.visibility,
                            color: black50,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: black50,
                          )),
                obscureText: visiblepass ? false : true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 6) {
                    return 'Please enter minimun 6 characters';
                  }
                  return null;
                },
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding: EdgeInsets.only(top: h * 0.02, bottom: h * 0.03),
                      child: InkWell(
                          onTap: () {
                            push_to(context, Forgot_Password());
                          },
                          child: custom_text(forgot_password,
                              style:
                                  CustomStyle().style_16_reguler(buttonclr))))),
              loginloader
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : custom_button(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loginloader = true;
                          });
                          login_API(
                            phone_numcontroller.text.trim(),
                            passwordcontroller.text.trim(),
                          ).then((value) {
                            if (value) {
                              final snackBar = SnackBar(
                                content: Text(login_msg ?? ""),
                                backgroundColor: (Colors.green),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              pushAndRevoveUntil(context, Bottom_App_Bar());
                              setState(() {
                                loginloader = false;
                              });
                            } else {
                              final snackBar = SnackBar(
                                content: Text(login_msg ?? ""),
                                backgroundColor: (Colors.red),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              setState(() {
                                loginloader = false;
                              });
                            }
                          });
                        }
                      },
                      height: h * 0.0625,
                      minWidth: h * 1,
                      text: log_in),
              SizedBox(
                height: h * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  custom_text(suggestion_signup,
                      style: CustomStyle().style_16_reguler(black50)),
                  InkWell(
                      onTap: () {
                        push_to(context, SignUp());
                      },
                      child: custom_text(sign_up,
                          style: CustomStyle().style_16_reguler(buttonclr))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
