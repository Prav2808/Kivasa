// ignore_for_file: camel_case_types, override_on_non_overriding_member, non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_const_constructors, unused_import, avoid_init_to_null, deprecated_member_use, must_be_immutable, empty_catches, depend_on_referenced_packages

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kivasa/Api/home_api/get_qr_api.dart';
import 'package:kivasa/constants/colors_constants.dart';
import 'package:kivasa/constants/text_constants.dart';
import 'package:kivasa/screens/bottom_bar/home.dart';
import 'package:kivasa/utills/country_picker_library.dart';
import 'package:kivasa/utills/custom_button.dart';
import 'package:kivasa/utills/text_styles.dart';
import '../../Api/onboarding_api/login_api.dart';
import '../../constants/icon_constants.dart';
import '../../utills/custom_container.dart';
import '../../utills/custom_textformfield.dart';
import '../../utills/navigation_rought.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'bottom_appbar_screen.dart';

class Get_Qr extends StatefulWidget {
  var vechileid;
  Get_Qr({super.key, this.vechileid});
  @override
  State<Get_Qr> createState() => _Get_QrState();
}

class _Get_QrState extends State<Get_Qr> {
  @override
  List address = [home_text, work, other];
  List vehicle = [car, bike, tampo, truck];

  late String countryValue;
  late String stateValue;
  late String cityValue;
  bool getqrLoader = false;
  List modellst = [
    "2023",
    "2022",
    "2021",
    "2020",
    "2019",
    "2018",
    "2017",
    "2016",
    "2015",
    "2014",
    "2013",
    "2012",
    "2011",
    "2010",
    "2009",
    "2008",
    "2007",
    "2006",
    "2005",
    "2004",
    "2003",
    "2002",
    "2001"
  ];
  String addresstype = "";
  TextEditingController vehicle_type_controller = TextEditingController();
  TextEditingController company_name_controller = TextEditingController();
  TextEditingController model_controller = TextEditingController();
  TextEditingController registration_noumber_controller =
      TextEditingController();
  TextEditingController upload_rc_controller = TextEditingController();
  TextEditingController phone_number_controller = TextEditingController();
  TextEditingController emergency_number_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController house_no_controller = TextEditingController();
  TextEditingController pin_code_controller = TextEditingController();
  TextEditingController landmark_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int currentIndex = 0;
  int vechileindex = 0;

  var h, w;
  String paymentid = "";
  Map<String, dynamic> userData = {};
  Razorpay? _razorpay;
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentid = (response.paymentId.toString());
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT : ${response.paymentId}", timeInSecForIosWeb: 4);
    getqr_API(
            context,
            vechileindex + 1,
            company_name_controller.text.trim(),
            model_controller.text.trim(),
            registration_noumber_controller.text.trim(),
            phone_number_controller.text.trim(),
            emergency_number_controller.text.trim(),
            widget.vechileid != null ? "199" : "499",
            currentIndex + 1,
            name_controller.text.trim(),
            pin_code_controller.text.trim(),
            house_no_controller.text.trim(),
            landmark_controller.text.trim(),
            countryValue.toString(),
            stateValue.toString(),
            cityValue.toString(),
            ImageFile != null
                ? ImageFile!.path.isEmpty
                    ? ""
                    : ImageFile!.path.toString()
                : "",
            paymentid.toString(),
            widget.vechileid != null ? widget.vechileid.toString() : "0")
        .then((value) {
      if (value) {
        final snackBar = SnackBar(
          content: Text(msggetqr ?? ""),
          backgroundColor: (Colors.green),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        replaceRoute(context, Bottom_App_Bar());
        setState(() {
          getqrLoader = false;
        });
      } else {
        final snackBar = SnackBar(
          content: Text(msggetqr ?? ""),
          backgroundColor: (Colors.red),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          getqrLoader = false;
        });
      }
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR HERE : ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    getqrreorder(context, widget.vechileid).then((value) {
      setState(() {
        profileupdateLoader = true;
      });
      if (value != null) {
        userData = value["data"];
        var typeno = userData["vehicle_type"];
        if (typeno.toString().isNotEmpty) {
          int pos = int.parse(typeno) - 1;
          vehicle_type_controller.text = vehicle[pos];
        }
        company_name_controller.text = userData["company_name"];
        model_controller.text = userData["modal"];
        registration_noumber_controller.text = userData["vehicle_reg_no"];
        upload_rc_controller.text = userData["rc_img"];
        phone_number_controller.text = userData["phone_number"];
        emergency_number_controller.text = userData["emergency_number"];
        name_controller.text = userData["address_data"]["name"];
        house_no_controller.text = userData["address_data"]["house_no"];
        landmark_controller.text = userData["address_data"]["landmark"];
        pin_code_controller.text = userData["address_data"]["pin_code"];
        countryValue = userData["address_data"]["country"];
        stateValue = userData["address_data"]["state"];
        cityValue = userData["address_data"]["city"];

        setState(() {});
      }
      setState(() {
        profileupdateLoader = false;
      });
    });
  }

  Future makePayment() async {
    String priceforqr = widget.vechileid != null ? "199" : "499";
    int amount = int.parse(priceforqr);
    var options = {
      "key": "rzp_test_h9UdDM2lDzl8Dr",
      "amount": amount * 100,
      "name": "Kivasa",
      "prefill": {
        "contact": phone_number_controller.text.toString(),
        "email": UserEmail
      }
    };
    try {
      _razorpay?.open(options);
    } catch (e) {}
  }

  bool profileupdateLoader = false;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: widget.vechileid == null
            ? Text("")
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: black,
                )),
        backgroundColor: white,
        title: custom_text(add_vehicle_details,
            style: CustomStyle().style_22_bold(black)),
      ),
      body: profileupdateLoader == true
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              top: h * 0.04, bottom: h * 0.00875),
                          child: custom_text(vehicle_type,
                              style: CustomStyle().style_16_reguler(black))),
                      TextFormField(
                        readOnly: true,
                        keyboardAppearance: Brightness.light,
                        cursorWidth: w * 0.00277,
                        controller: vehicle_type_controller,
                        style: CustomStyle().style_16_reguler(black),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: w * 0.0277),
                            fillColor: black05,
                            filled: true,
                            hintText: select_vevicle,
                            suffixIcon: drop_down,
                            hintStyle: CustomStyle().style_16_reguler(black50),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: transparent),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: black),
                              borderRadius: BorderRadius.circular(8),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter select vehicle type';
                          }

                          return null;
                        },
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              contentPadding: EdgeInsets.all(10),
                              actionsPadding: EdgeInsets.all(10),
                              insetPadding: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              backgroundColor: Colors.white,
                              content: Builder(builder: (context) {
                                return Container(
                                  height: 133,
                                  width: 0.3601,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: white,
                                  ),
                                  child: ListView.builder(
                                      itemCount: vehicle.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                          child: InkWell(
                                              onTap: () {
                                                vechileindex = index;
                                                vehicle_type_controller.text =
                                                    vehicle[index];
                                                Navigator.pop(context);
                                              },
                                              child: custom_text(vehicle[index],
                                                  style: CustomStyle()
                                                      .style_16_reguler(
                                                          black))),
                                        );
                                      }),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: h * 0.03, bottom: h * 0.00875),
                          child: custom_text(company_name,
                              style: CustomStyle().style_16_reguler(black))),
                      custom_textformfield(context,
                          hintText: company_name,
                          keyboardType: TextInputType.visiblePassword,
                          controller: company_name_controller,
                          validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter company name';
                        } else if (company_name_controller.text
                            .trim()
                            .isEmpty) {
                          return "Please enter valid company name";
                        }
                        return null;
                      }),
                      Padding(
                          padding: EdgeInsets.only(
                              top: h * 0.03, bottom: h * 0.00875),
                          child: custom_text(model,
                              style: CustomStyle().style_16_reguler(black))),
                      custom_textformfield1(
                        context,
                        hintText: select_model,
                        controller: model_controller,
                        readOnly: true,
                        suffixIcon: drop_down,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter select model';
                          }
                          return null;
                        },
                        itemCount: modellst.length,
                        text: modellst,
                        container_height: 1000,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: h * 0.03, bottom: h * 0.00875),
                          child: custom_text(registration_num,
                              style: CustomStyle().style_16_reguler(black))),
                      custom_textformfield(context,
                          hintText: registration_num,
                          controller: registration_noumber_controller,
                          validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter registration number';
                        } else if (registration_noumber_controller.text
                            .trim()
                            .isEmpty) {
                          return "Please enter valid registration number";
                        }
                        return null;
                      }),
                      Padding(
                          padding: EdgeInsets.only(
                              top: h * 0.03, bottom: h * 0.00875),
                          child: custom_text(upload_rc,
                              style: CustomStyle().style_16_reguler(black))),
                      TextFormField(
                        readOnly: true,
                        onTap: () {
                          _openGallery(context);
                        },
                        keyboardAppearance: Brightness.light,
                        cursorWidth: w * 0.00277,
                        controller: upload_rc_controller,
                        style: CustomStyle().style_16_reguler(black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: w * 0.0277, vertical: 10),
                          fillColor: black05,
                          filled: true,
                          prefixIcon: custom_container(
                              height: 48,
                              width: w * 0.25,
                              alignment: Alignment.center,
                              color: black30,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  bottomLeft: Radius.circular(7)),
                              child: custom_text(choose_file,
                                  style: CustomStyle().style_15_medium(black))),
                          hintText: no_file,
                          hintStyle: CustomStyle().style_16_reguler(black50),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter select image file';
                          }
                          return null;
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: h * 0.03, bottom: h * 0.00875),
                          child: custom_text(phone_number,
                              style: CustomStyle().style_16_reguler(black))),
                      custom_textformfield(
                        context,
                        hintText: phone_number,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: phone_number_controller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter phone number';
                          } else if (phone_number_controller.text
                                  .trim()
                                  .length <
                              10) {
                            return 'Please enter valid number';
                          }
                          return null;
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: h * 0.03, bottom: h * 0.00875),
                          child: custom_text(emergency_number,
                              style: CustomStyle().style_16_reguler(black))),
                      custom_textformfield(
                        context,
                        hintText: emergency_number,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: emergency_number_controller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter emergency number';
                          } else if (emergency_number_controller.text
                                  .trim()
                                  .length <
                              10) {
                            return 'Please enter valid number';
                          }
                          return null;
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: h * 0.03, bottom: h * 0.00875),
                          child: custom_text(price_for_qr,
                              style: CustomStyle().style_16_reguler(black))),
                      custom_container(
                          height: 48,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          borderRadius: BorderRadius.circular(8),
                          color: black05,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: w * 0.0277),
                            child: custom_text(
                                "₹  ${widget.vechileid != null ? "199" : "499"}",
                                style: CustomStyle().style_15_reguler(black)),
                          )),
                      // custom_textformfield1(
                      //   context,
                      //   hintText: select_price,
                      //   controller: price_for_controller,
                      //   readOnly: true,
                      //   suffixIcon: drop_down,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please enter select price';
                      //     }
                      //     return null;
                      //   },
                      //   itemCount: price.length,
                      //   text: price,
                      //   container_height: 66,
                      // ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: h * 0.03, bottom: h * 0.00875),
                          child: custom_text(select_address,
                              style: CustomStyle().style_16_reguler(black))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                            address.length,
                            (index) => InkWell(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                    addresstype = address[index];
                                  });
                                },
                                child: custom_container(
                                    height: 35,
                                    width: 75,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(right: 20),
                                    borderRadius: BorderRadius.circular(8),
                                    color: currentIndex == index
                                        ? buttonclr
                                        : black05,
                                    border: Border.all(
                                        color: currentIndex == index
                                            ? buttonclr
                                            : black05),
                                    child: custom_text(address.elementAt(index),
                                        style: CustomStyle().style_15_reguler(
                                            currentIndex == index
                                                ? white
                                                : black))))),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: h * 0.03, bottom: h * 0.00875),
                          child: custom_text(name,
                              style: CustomStyle().style_16_reguler(black))),
                      custom_textformfield(context,
                          hintText: name,
                          keyboardType: TextInputType.name,
                          controller: name_controller, validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter name';
                        } else if (name_controller.text.trim().isEmpty) {
                          return "Please enter valid name";
                        }
                        return null;
                      }),
                      Padding(
                          padding: EdgeInsets.only(
                              top: h * 0.03, bottom: h * 0.00875),
                          child: custom_text(house_no,
                              style: CustomStyle().style_16_reguler(black))),
                      custom_textformfield(context,
                          hintText: house_no,
                          controller: house_no_controller, validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter house no.';
                        } else if (house_no_controller.text.trim().isEmpty) {
                          return "Please enter valid house number";
                        }
                        return null;
                      }),
                      Padding(
                          padding: EdgeInsets.only(
                              top: h * 0.03, bottom: h * 0.00875),
                          child: custom_text(pin_code,
                              style: CustomStyle().style_16_reguler(black))),
                      custom_textformfield(context,
                          maxLength: 6,
                          hintText: pin_code,
                          keyboardType: TextInputType.number,
                          controller: pin_code_controller, validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter pin code';
                        } else if (pin_code_controller.text.trim().isEmpty) {
                          return "Please enter valid pin code";
                        }
                        return null;
                      }),
                      Padding(
                          padding: EdgeInsets.only(
                              top: h * 0.03, bottom: h * 0.00875),
                          child: custom_text(landmark,
                              style: CustomStyle().style_16_reguler(black))),
                      custom_textformfield(context,
                          hintText: landmark,
                          controller: landmark_controller, validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter landmark';
                        } else if (landmark_controller.text.trim().isEmpty) {
                          return "Please enter valid landmark";
                        }
                        return null;
                      }),
                      SelectCountryPicker(
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value;
                          });
                        },
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(top: h * 0.03, bottom: h * 0.03),
                          child: getqrLoader
                              ? Center(
                                  child: CircularProgressIndicator.adaptive())
                              : custom_button(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      makePayment();
                                    }
                                  },
                                  height: h * 0.0625,
                                  minWidth: w * 1,
                                  text: make_payment)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  PickedFile? ImageFile = null;

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      ImageFile = pickedFile!;
      upload_rc_controller.text = ImageFile!.path.split('/').last;
    });
  }
}
