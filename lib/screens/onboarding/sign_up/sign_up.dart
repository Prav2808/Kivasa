// ignore_for_file: unused_import, implementation_imports, unnecessary_import, depend_on_referenced_packages, non_constant_identifier_names, prefer_const_constructors, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:kivasa/Api/onboarding_api/signup_api.dart';
import 'package:kivasa/screens/onboarding/sign_in/sign_in.dart';
import 'package:kivasa/screens/onboarding/sign_up/signup_otp_verification.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/icon_constants.dart';
import '../../../constants/image_constants.dart';
import '../../../constants/text_constants.dart';
import '../../../utills/custom_listtile.dart';
import '../../../utills/custom_button.dart';
import '../../../utills/custom_textformfield.dart';
import '../../../utills/email_validation.dart';
import '../../../utills/navigation_rought.dart';
import '../../../utills/text_styles.dart';

String Phonenumber = "";
String EmailAddress = "";
String NameUSer = "";
String PasswordUser = "";

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phone_numcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController con_passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var h, w;
  bool value = false;
  int checkbox = 0;
  bool visiblepass = false;
  bool visiblepassConfirm = false;
  bool signupLoader = false;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Create New Account",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.04155,
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(top: h * 0.03125, bottom: h * 0.00875),
                child: custom_text(name,
                    style: CustomStyle().style_16_reguler(black)),
              ),
              custom_textformfield(
                context,
                hintText: name,
                keyboardType: TextInputType.name,
                controller: namecontroller,
                prefixIcon: person,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter name';
                  } else if (namecontroller.text.trim().isEmpty) {
                    return "Please enter valid name";
                  }
                  NameUSer = value;
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 0.01875, bottom: h * 0.00875),
                child: custom_text(email,
                    style: CustomStyle().style_16_reguler(black)),
              ),
              custom_textformfield(
                context,
                hintText: email,
                keyboardType: TextInputType.emailAddress,
                controller: emailcontroller,
                prefixIcon: email_icon,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email';
                  } else if (!emailPattern
                      .hasMatch(emailcontroller.text.toString())) {
                    return 'Please enter valid email';
                  }
                  EmailAddress = value;
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 0.01875, bottom: h * 0.00875),
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
                  } else if (phone_numcontroller.text.trim().isEmpty) {
                    return "Please enter valid number";
                  }
                  Phonenumber = value;
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
                  } else if (passwordcontroller.text.trim().isEmpty) {
                    return "Please enter valid name";
                  }
                  PasswordUser = value;
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 0.01875, bottom: h * 0.00875),
                child: custom_text(con_password,
                    style: CustomStyle().style_16_reguler(black)),
              ),
              custom_textformfield(context,
                  hintText: con_password,
                  keyboardType: TextInputType.visiblePassword,
                  controller: con_passwordcontroller,
                  prefixIcon: password_icon,
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          visiblepassConfirm = !visiblepassConfirm;
                        });
                      },
                      child: visiblepassConfirm
                          ? Icon(
                              Icons.visibility,
                              color: black50,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: black50,
                            )),
                  obscureText: visiblepassConfirm ? false : true,
                  validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter confirm password';
                } else if (value.length < 6) {
                  return 'Please enter minimun 6 characters';
                } else if (con_passwordcontroller.text !=
                    passwordcontroller.text) {
                  return 'Confirm password does not match!';
                }
                return null;
              }),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                        activeColor: primarycolor,
                        value: value,
                        onChanged: (bool? Newvalue) {
                          value != true ? checkbox = 1 : checkbox = 0;
                          setState(() {
                            value = Newvalue!;
                          });
                        }),
                  ),
                  SizedBox(
                    width: w * 0.04,
                  ),
                  InkWell(
                    onTap: () {},
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: black, fontSize: 36),
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'I agree to the ',
                          ),
                          TextSpan(
                              text: ' Terms & Conditions',
                              style: TextStyle(color: primarycolor)),
                        ],
                      ),
                      textScaleFactor: 0.5,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 0.03, bottom: h * 0.02),
                child: signupLoader
                    ? Center(child: CircularProgressIndicator.adaptive())
                    : custom_button(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (checkbox != 1) {
                              const snackBar = SnackBar(
                                content:
                                    Text("Please agree Terms & Conditions"),
                                backgroundColor: (Colors.red),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (checkbox == 1) {
                              setState(() {
                                signupLoader = true;
                              });
                              signup_API(
                                      namecontroller.text.trim(),
                                      emailcontroller.text.trim(),
                                      phone_numcontroller.text.trim(),
                                      passwordcontroller.text.trim(),
                                      con_passwordcontroller.text.trim(),
                                      checkbox.toString())
                                  .then((value) {
                                if (value) {
                                  final snackBar = SnackBar(
                                    content: Text(msgsignup ?? ""),
                                    backgroundColor: (Colors.green),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);

                                  push_to(context, OTP_Verification_signup());
                                  setState(() {
                                    signupLoader = false;
                                  });
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text(msgsignup ?? ""),
                                    backgroundColor: (Colors.red),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  setState(() {
                                    signupLoader = false;
                                  });
                                }
                              });
                            }
                          }
                        },
                        height: h * 0.0625,
                        minWidth: h * 1,
                        text: sign_up),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  custom_text(suggestion_signin,
                      style: CustomStyle().style_16_reguler(black50)),
                  InkWell(
                      onTap: () {
                        push_to(context, LogIn());
                      },
                      child: custom_text(log_in,
                          style: CustomStyle().style_16_reguler(buttonclr))),
                ],
              ),
              SizedBox(
                height: h * 0.025,
              )
            ],
          ),
        ),
      ),
    );
  }
}
