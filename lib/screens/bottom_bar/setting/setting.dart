// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kivasa/constants/colors_constants.dart';
import 'package:kivasa/constants/icon_constants.dart';
import 'package:kivasa/constants/image_constants.dart';
import 'package:kivasa/constants/text_constants.dart';
import 'package:kivasa/screens/bottom_bar/setting/privacy_policy.dart';
import 'package:kivasa/screens/bottom_bar/setting/terms_&_conditoin.dart';
import 'package:kivasa/utills/custom_button.dart';
import 'package:kivasa/utills/navigation_rought.dart';
import '../../../utills/custom_container.dart';
import '../../../utills/custom_dialog.dart';
import '../../../utills/custom_listtile.dart';
import 'about_us.dart';
import 'change_password.dart';
import 'contect_us.dart';
import 'faq.dart';
import 'my_account.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04155),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: h * 0.0625, bottom: h * 0.03125),
              child: Image.asset(
                logo,
                height: h * 0.125,
              ),
            ),
            custom_container(
                width: w * 1,
                border: Border.all(color: black05),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.04155),
                  child: Column(children: [
                    custom_list_tile(context, my_mccount, onTap: () {
                      push_to(context, My_Account());
                    }, leading: person),
                    custom_list_tile(context, change_password, onTap: () {
                      push_to(context, ChangePassword());
                    },
                        leading: Image.asset(
                          change_password_icon,
                          height: h * 0.02687,
                          color: black50,
                        )),
                    custom_list_tile(context, about_us, onTap: () {
                      push_to(context, About_Us());
                    },
                        leading: Image.asset(
                          about_us_icon,
                          height: h * 0.0275,
                          color: black50,
                        )),
                    custom_list_tile(context, privacy_policy, onTap: () {
                      push_to(context, Privacy_Policy());
                    }, leading: Privacy_Polocy_icon),
                    custom_list_tile(context, terms_condition, onTap: () {
                      push_to(context, Terms_Condition());
                    },
                        leading: Image.asset(
                          terms_condition_icon,
                          height: h * 0.025,
                          color: black50,
                        )),
                    custom_list_tile(context, faq, onTap: () {
                      push_to(context, FAQ());
                    },
                        leading: Image.asset(
                          faq_icon,
                          height: h * 0.0225,
                          color: black50,
                        )),
                    custom_list_tile(context, contact_us, onTap: () {
                      push_to(context, Contect_Us());
                    }, leading: mobile)
                  ]),
                )),
            SizedBox(height: h * 0.0575),
            custom_button(
                onPressed: () {
                  showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) => Dialog_Box(),
                  );
                },
                height: h * 0.0625,
                minWidth: w * 1,
                text: log_out)
          ],
        ),
      ),
    );
  }
}
