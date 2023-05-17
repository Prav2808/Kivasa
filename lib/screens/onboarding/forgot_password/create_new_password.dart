// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kivasa/constants/colors_constants.dart';
import 'package:kivasa/constants/text_constants.dart';
import 'package:kivasa/utills/custom_button.dart';
import 'package:kivasa/utills/text_styles.dart';

import '../../../Api/onboarding_api/reset_pass_api.dart';
import '../../../constants/icon_constants.dart';
import '../../../utills/custom_textformfield.dart';
import '../../../utills/navigation_rought.dart';
import '../sign_in/sign_in.dart';
import 'forgot_password.dart';

class Create_New_Password extends StatefulWidget {
  const Create_New_Password({super.key});

  @override
  State<Create_New_Password> createState() => _Create_New_PasswordState();
}

class _Create_New_PasswordState extends State<Create_New_Password> {
  TextEditingController new_passwordcontroller = TextEditingController();
  TextEditingController confirmcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var h, w;

  bool changedpassloader = false;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(create_new_password, style: TextStyle(color: black)),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04155),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: h * 0.15),
              Padding(
                padding: EdgeInsets.only(top: h * 0.0375, bottom: h * 0.00875),
                child: custom_text(new_password,
                    style: CustomStyle().style_16_reguler(black)),
              ),
              custom_textformfield(
                context,
                hintText: new_password,
                controller: new_passwordcontroller,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: password_icon,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 6) {
                    return 'Please enter minimun 6 characters';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 0.025, bottom: h * 0.00875),
                child: custom_text(con_new_password,
                    style: CustomStyle().style_16_reguler(black)),
              ),
              custom_textformfield(context,
                  hintText: con_new_password,
                  keyboardType: TextInputType.visiblePassword,
                  controller: confirmcontroller,
                  prefixIcon: password_icon, validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                } else if (value.length < 6) {
                  return 'Please enter minimun 6 characters';
                } else if (confirmcontroller.text !=
                    new_passwordcontroller.text) {
                  return 'Confirm password does not match!';
                }
                return null;
              }),
              SizedBox(height: h * 0.05),
              changedpassloader
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : custom_button(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            changedpassloader = true;
                          });
                          resetpass_API(
                            nmbr,
                            new_passwordcontroller.text.trim(),
                          ).then((value) {
                            if (value) {
                              final snackBar = SnackBar(
                                content: Text(resetpass_msg ?? ""),
                                backgroundColor: (Colors.green),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              pushAndRevoveUntil(context, LogIn());
                              setState(() {
                                changedpassloader = false;
                              });
                            } else {
                              final snackBar = SnackBar(
                                content: Text(resetpass_msg ?? ""),
                                backgroundColor: (Colors.red),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              setState(() {
                                changedpassloader = false;
                              });
                            }
                          });
                        }
                      },
                      height: h * 0.0625,
                      minWidth: h * 1,
                      text: submit),
            ],
          ),
        ),
      ),
    );
  }
}
