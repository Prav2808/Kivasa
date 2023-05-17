// ignore_for_file: library_prefixes, library_private_types_in_public_api, prefer_typing_uninitialized_variables, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:country_state_city_picker/model/select_status_model.dart'
    as StatusModel;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:kivasa/utills/text_styles.dart';

import '../constants/colors_constants.dart';
import '../constants/text_constants.dart';

class SelectCountryPicker extends StatefulWidget {
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onCityChanged;
  final TextStyle? style;
  final Color? dropdownColor;

  const SelectCountryPicker(
      {Key? key,
      required this.onCountryChanged,
      required this.onStateChanged,
      required this.onCityChanged,
      this.style,
      this.dropdownColor})
      : super(key: key);

  @override
  _SelectCountryPickerState createState() => _SelectCountryPickerState();
}

class _SelectCountryPickerState extends State<SelectCountryPicker> {
  List<String> _cities = ["Choose City"];
  final List<String> _country = ["Choose Country"];
  String _selectedCity = "Choose City";
  String _selectedCountry = "Choose Country";
  String _selectedState = "Choose State";
  List<String> _states = ["Choose State"];
  var responses;

  @override
  void initState() {
    getCounty();
    super.initState();
  }

  Future getResponse() async {
    var res = await rootBundle.loadString(
        'packages/country_state_city_picker/lib/assets/country.json');
    return jsonDecode(res);
  }

  Future getCounty() async {
    var countryres = await getResponse() as List;
    for (var data in countryres) {
      var model = StatusModel.StatusModel();
      model.name = data['name'];
      model.emoji = data['emoji'];
      if (!mounted) continue;
      setState(() {
        _country.add(model.name!);
      });
    }

    return _country;
  }

  Future getState() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    for (var f in states) {
      if (!mounted) continue;
      setState(() {
        var name = f.map((item) => item.name).toList();
        for (var statename in name) {
          _states.add(statename.toString());
        }
      });
    }

    return _states;
  }

  Future getCity() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      var name = f.where((item) => item.name == _selectedState);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        if (!mounted) return;
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {
            _cities.add(citynames.toString());
          }
        });
      });
    });
    return _cities;
  }

  void _onSelectedCountry(String value) {
    if (!mounted) return;
    setState(() {
      _selectedState = "Choose State";
      _states = ["Choose State"];
      _selectedCountry = value;
      widget.onCountryChanged(value);
      getState();
    });
  }

  void _onSelectedState(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = "Choose City";
      _cities = ["Choose City"];
      _selectedState = value;
      widget.onStateChanged(value);
      getCity();
    });
  }

  void _onSelectedCity(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = value;
      widget.onCityChanged(value);
    });
  }

  var h, w;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(top: h * 0.03, bottom: h * 0.00875),
              child: custom_text(country,
                  style: CustomStyle().style_16_reguler(black))),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: black05,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton<String>(
            underline: const SizedBox(),
            dropdownColor: widget.dropdownColor,
            isExpanded: true,
            items: _country.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Row(
                  children: [
                    Text(
                      dropDownStringItem,
                      style: widget.style,
                    )
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) => _onSelectedCountry(value!),
            value: _selectedCountry,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(top: h * 0.03, bottom: h * 0.00875),
              child: custom_text(state,
                  style: CustomStyle().style_16_reguler(black))),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: black05,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton<String>(
            underline: const SizedBox(),
            dropdownColor: widget.dropdownColor,
            isExpanded: true,
            items: _states.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem, style: widget.style),
              );
            }).toList(),
            onChanged: (value) => _onSelectedState(value!),
            value: _selectedState,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(top: h * 0.03, bottom: h * 0.00875),
              child: custom_text(city,
                  style: CustomStyle().style_16_reguler(black))),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: black05,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton<String>(
            underline: const SizedBox(),
            dropdownColor: widget.dropdownColor,
            isExpanded: true,
            items: _cities.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem, style: widget.style),
              );
            }).toList(),
            onChanged: (value) => _onSelectedCity(value!),
            value: _selectedCity,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
