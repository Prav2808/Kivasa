// Regisration_API

// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, empty_catches

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kivasa/Api/url.dart';

import '../../utills/navigation_rought.dart';
import '../onboarding_api/login_api.dart';

var msggetqr;

Future getqr_API(
  BuildContext context,
  var vehicleType,
  var companyName,
  var model,
  var vehicleRegistrationNumber,
  var phoneNumber,
  var emergencyNumber,
  var price,
  var addressType,
  var name,
  var pinCode,
  var houseNo,
  var landmark,
  var country,
  var state,
  var city,
  var rc,
  var paymentId,
  var vehicle_id,
) async {
  try {
    var headers = {"Authorization": "Bearer $UserToken"};
    var request = http.MultipartRequest('POST', Uri.parse(getqrurl));
    request.fields.addAll(
      {
        "vehicle_type": vehicleType.toString(),
        "company_name": companyName.toString(),
        "model": model.toString(),
        'vehicle_registration_number': vehicleRegistrationNumber.toString(),
        "phone_number": phoneNumber.toString(),
        "emergency_number": emergencyNumber.toString(),
        "price": price.toString(),
        "address_type": addressType.toString(),
        "name": name.toString(),
        "pin_code": pinCode.toString(),
        "house_no": houseNo.toString(),
        "landmark": landmark.toString(),
        "country": country.toString(),
        "state": state.toString(),
        "city": city.toString(),
        "user_id": UserId.toString(),
        "payment_id": paymentId.toString(),
        "vehicle_id": vehicle_id.toString()
      },
    );
    if (rc != "") {
      request.files.add(await http.MultipartFile.fromPath('rc', rc));
    } else {
      request.fields.addAll({'rc': rc});
    }

    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();

      var jsonRes = jsonDecode(res.toString());
      msggetqr = jsonRes["message"];

      if (jsonRes["status"]) {
        return true;
      }
      return false;
    } else if (response.statusCode == 501) {
      onlogOut(context);
    }
  } catch (e) {
    print("$e Server Error");
    return false;
  }
}

Future getqrreorder(BuildContext context, int? vehicleId) async {
  try {
    var response = await http.post(
      Uri.parse(get_reorderurl),
      body: {
        "vehicle_id": vehicleId.toString(),
      },
      headers: {"Authorization": "Bearer $UserToken"},
    );
    if (response.statusCode == 200) {
      final data = json.decode((response.body));

      return data;
    } else if (response.statusCode == 501) {
      onlogOut(context);
    }
  } catch (e) {}
}
