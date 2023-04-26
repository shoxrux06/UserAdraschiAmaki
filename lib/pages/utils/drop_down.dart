import 'package:afisha_market/pages/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<String> regionList = <String>[
  'Tashkent city',
  'Tashkent region',
  'Karakalpakistan',
  'Samarkand',
  'Bukhara',
  'Andijan',
  'Khorezm',
  'Kashkadarya',
  'Jizzakh',
  'Navoi',
  'Surkhandarya',
  'Namangan',
  'Syrdarya',
  'Fergana',
];

class MyDropDown extends StatefulWidget {
  const MyDropDown({Key? key}) : super(key: key);

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  String dropdownValue = regionList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        dropdownColor: helperColor,
        style: TextStyle(color: disableColor),
        decoration: InputDecoration(
          fillColor: helperColor,
          filled: true,
          prefixIcon: const Icon(Icons.not_listed_location_outlined),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: mainColor, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: mainColor, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: mainColor, width: 0.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: mainColor, width: 0.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: mainColor, width: 0.5),
          ),
        ),
        items: regionList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        });
  }
}
