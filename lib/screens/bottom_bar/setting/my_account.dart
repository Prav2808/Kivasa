// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_const_constructors, avoid_init_to_null, deprecated_member_use
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kivasa/Api/url.dart';
import 'package:kivasa/constants/colors_constants.dart';
import 'package:kivasa/screens/bottom_bar/bottom_appbar_screen.dart';
import 'package:kivasa/utills/custom_button.dart';
import 'package:kivasa/utills/custom_container.dart';
import '../../../Api/home_api/profile_api.dart';
import '../../../constants/icon_constants.dart';
import '../../../constants/image_constants.dart';
import '../../../constants/text_constants.dart';
import '../../../utills/custom_appbar.dart';
import '../../../utills/custom_textformfield.dart';
import '../../../utills/email_validation.dart';
import '../../../utills/navigation_rought.dart';
import '../../../utills/text_styles.dart';

class My_Account extends StatefulWidget {
  const My_Account({super.key});
  @override
  State<My_Account> createState() => _My_AccountState();
}

class _My_AccountState extends State<My_Account> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phone_numcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> userData = {};
  String imageUrl = "";

  @override
  void initState() {
    profilegetLoader = true;
    super.initState();

    myAccountUpdate(context).then((value) {
      if (value != null) {
        userData = value["data"];

        namecontroller.text = userData["name"];
        emailcontroller.text = userData["email"];
        phone_numcontroller.text = userData["phone_no"];
        imageUrl = userData["profile_pic"] ?? "";
        print(imageUrl);

        setState(() {});
      }
      profilegetLoader = false;
    });
  }

  bool profileupdateLoader = false;
  bool profilegetLoader = false;
  var h, w;
  String imagePath = 'assets/images/person.png';
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: white,
        appBar: custom_appbr(context),
        body: profilegetLoader == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: w * 0.04155,
                    left: w * 0.04155,
                  ),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Center(
                          child: custom_container(
                              height: w * 0.32,
                              width: w * 0.32,
                              alignment: Alignment.center,
                              border: Border.all(color: black05),
                              borderRadius: BorderRadius.circular(100),
                              child: custom_container(
                                  height: w * 0.30,
                                  width: w * 0.30,
                                  alignment: Alignment.center,
                                  border: Border.all(color: black05),
                                  borderRadius: BorderRadius.circular(100),
                                  image: imagePath != 'assets/images/person.png'
                                      ? DecorationImage(
                                          image:
                                              FileImage(File(ImageFile!.path)),
                                          fit: BoxFit.cover)
                                      : userData["profile_pic"] != null
                                          ? DecorationImage(
                                              image: NetworkImage(imageBaseurl +
                                                  userData["profile_pic"]),
                                              fit: BoxFit.cover)
                                          : DecorationImage(
                                              image: AssetImage(photo))))),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      Center(
                          child: custom_button(
                        onPressed: () {
                          _openGallery(context);
                        },
                        height: h * 0.0375,
                        minWidth: w * 0.2216,
                        text: ImageFile == null ? "Upload Image" : change_image,
                      )),
                      Padding(
                        padding:
                            EdgeInsets.only(top: h * 0.05, bottom: h * 0.00875),
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
                          return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: h * 0.025, bottom: h * 0.00875),
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
                          return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: h * 0.025, bottom: h * 0.00875),
                        child: custom_text(phone_number,
                            style: CustomStyle().style_16_reguler(black)),
                      ),
                      custom_textformfield(
                        context,
                        readOnly: true,
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
                      SizedBox(
                        height: h * 0.12,
                      )
                    ],
                  ),
                ),
              ),
        floatingActionButton: profilegetLoader == true
            ? Center(
                child: Container(),
              )
            : Padding(
                padding: EdgeInsets.only(left: w * 0.08, bottom: h * 0.02),
                child: profileupdateLoader == true
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: CircularProgressIndicator())
                    : SizedBox(
                        height: h * 0.0625,
                        child: custom_button(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  profileupdateLoader = true;
                                });
                                regFirst(
                                        context,
                                        namecontroller.text.trim(),
                                        emailcontroller.text.trim(),
                                        imagePath.toString(),
                                        imageUrl)
                                    .then((value) {
                                  if (value) {
                                    final snackBar = SnackBar(
                                      content: Text(msgprofileupdate ?? ""),
                                      backgroundColor: (Colors.green),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);

                                    replaceRoute(context, Bottom_App_Bar());
                                    setState(() {
                                      profileupdateLoader = false;
                                    });
                                  } else {
                                    final snackBar = SnackBar(
                                      content: Text(msgprofileupdate ?? ""),
                                      backgroundColor: (Colors.red),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    setState(() {
                                      profileupdateLoader = false;
                                    });
                                  }
                                });
                              }
                            },
                            height: h * 0.0625,
                            minWidth: double.infinity,
                            text: save),
                      )));
  }

  PickedFile? ImageFile = null;
  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      ImageFile = pickedFile;
      imagePath = ImageFile!.path.toString();
      print(imagePath);
    });
  }
}
