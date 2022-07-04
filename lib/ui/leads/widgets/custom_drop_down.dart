import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({Key? key}) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            Container(
              child: const Text(
                'All Lead',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                // overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        iconSize: 25,
        iconEnabledColor: Colors.black,
        iconDisabledColor: Colors.grey,
        buttonHeight: 30,
        buttonWidth: 310,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: const BoxDecoration(color: Colors.transparent),
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 500,
        dropdownWidth: 300,
        dropdownDecoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}

class CustomDropDownEnquiry extends StatefulWidget {
  const CustomDropDownEnquiry({Key? key}) : super(key: key);

  @override
  State<CustomDropDownEnquiry> createState() => _CustomDropDownEnquiryState();
}

class _CustomDropDownEnquiryState extends State<CustomDropDownEnquiry> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            Container(
              child: const Text(
                'All Enquiry',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                // overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        iconSize: 25,
        iconEnabledColor: Colors.black,
        iconDisabledColor: Colors.grey,
        buttonHeight: 30,
        buttonWidth: 310,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: const BoxDecoration(color: Colors.transparent),
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 500,
        dropdownWidth: 300,
        dropdownDecoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}
