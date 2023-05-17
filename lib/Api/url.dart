// ignore_for_file: constant_identifier_names

import 'package:kivasa/Api/onboarding_api/login_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

const baseurl = "https://kivasa.com/api/";
const signupurl = "${baseurl}register";
const loginurl = "${baseurl}login";
const varifyurl = "${baseurl}varify-otp";
const forget_url = "${baseurl}forgot-password";
const resetpass_url = "${baseurl}reset-Password";
const changepass_url = "${baseurl}changepassword";
const getqrurl = "${baseurl}store-vehicle";
const getuserprofile = "${baseurl}userprofile";
const profileupdateurl = "${baseurl}profile-update";
const imageBaseurl = "https://kivasa.com";
const myorderurl = "${baseurl}myorders";
const homepageurl = "${baseurl}myvehicle";
const get_reorderurl = "${baseurl}get-reorder";
const update_qrstatus = "${baseurl}update-qrstatus";
const trackorderurl = "${baseurl}trackorder";

assignPrefData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  UserId = prefs.getString('u_id');
  UserEmail = prefs.getString('u_email');
  UserName = prefs.getString('u_name');
  UserToken = prefs.getString('token');
}

logoutPrefData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('u_id');
  await prefs.remove('u_email');
  await prefs.remove('u_name');
  await prefs.remove('token');
}
