// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kivasa/Api/onboarding_api/login_api.dart';
import '../../../Api/onboarding_api/changepassword_api.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/text_constants.dart';
import '../../../utills/custom_button.dart';
import '../../../utills/custom_textformfield.dart';
import '../../../utills/text_styles.dart';
import '../bottom_appbar_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  var password_controller = TextEditingController();
  var new_password_controller = TextEditingController();
  var confirm_password_controller = TextEditingController();
  bool changepasswordloader = false;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        centerTitle: true,
        title: Text(
          "Change Password",
          style: TextStyle(color: black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: black,
            )),
        elevation: 0,
      ),
      body: changepasswordloader
          ? Center(child: CircularProgressIndicator.adaptive())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.05,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: h * 0.1, bottom: h * 0.00875),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: h * 0.025, bottom: h * 0.00875),
                                    child: custom_text(current_password,
                                        style: CustomStyle()
                                            .style_17_reguler(black)),
                                  ),
                                  custom_textformfield(
                                    context,
                                    hintText: current_password,
                                    controller: password_controller,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter current password';
                                      } else if (value.length < 6) {
                                        return 'Please enter minimun 6 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: h * 0.025, bottom: h * 0.00875),
                                    child: custom_text(new_password,
                                        style: CustomStyle()
                                            .style_17_reguler(black)),
                                  ),
                                  custom_textformfield(
                                    context,
                                    hintText: new_password,
                                    controller: new_password_controller,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter new password';
                                      } else if (value.length < 6) {
                                        return 'Please enter minimun 6 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: h * 0.025, bottom: h * 0.00875),
                                    child: custom_text(con_new_password,
                                        style: CustomStyle()
                                            .style_17_reguler(black)),
                                  ),
                                  custom_textformfield(context,
                                      hintText: con_new_password,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: confirm_password_controller,
                                      validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter confirm password';
                                    } else if (value.length < 6) {
                                      return 'Please enter minimun 6 characters';
                                    } else if (confirm_password_controller
                                            .text !=
                                        new_password_controller.text) {
                                      return 'Confirm password do`es not match!';
                                    }
                                    return null;
                                  }),
                                  SizedBox(height: h * 0.2),
                                ]),
                          ),
                        ])),
              )),
      floatingActionButton: Padding(
          padding: EdgeInsets.only(left: w * 0.086, bottom: h * 0.05),
          child: custom_button(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    changepasswordloader = true;
                  });
                  changepass_API(
                          context,
                          password_controller.text.trim(),
                          new_password_controller.text.trim(),
                          confirm_password_controller.text.trim(),
                          UserId)
                      .then((value) {
                    if (value) {
                      final snackBar = SnackBar(
                        content: Text(changepass_msg ?? ""),
                        backgroundColor: (Colors.green),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Bottom_App_Bar()));
                      setState(() {
                        changepasswordloader = false;
                      });
                    } else {
                      final snackBar = SnackBar(
                        content: Text(changepass_msg ?? ""),
                        backgroundColor: (Colors.red),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {
                        changepasswordloader = false;
                      });
                    }
                  });
                }
              },
              height: h * 0.0625,
              minWidth: h * 1,
              text: change_password)),
    );
  }
}
