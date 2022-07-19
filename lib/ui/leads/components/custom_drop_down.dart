import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kit_19/model/source_list_model.dart';
import 'package:http/http.dart' as http;

import '../../../model/user_data.dart';
import '../../../utils/app_theme.dart';

// class CustomDropDown extends StatefulWidget {
//   CustomDropDown({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<CustomDropDown> createState() => _CustomDropDownState();
// }

// class _CustomDropDownState extends State<CustomDropDown> {
//   final List<CustomDropDown> items = [];
//   String? selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         isExpanded: true,
//         hint: Row(
//           children: [
//             Container(
//               child: const Text(
//                 'All Lead',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//                 // overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         items: items
//             .map((item) => DropdownMenuItem<String>(
//                   value: text,
//                   child: Text(
//                     item,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ))
//             .toList(),
//         value: selectedValue,
//         onChanged: (value) {
//           setState(() {
//             selectedValue = value as String;
//           });
//         },
//         icon: const Icon(
//           Icons.keyboard_arrow_down,
//         ),
//         iconSize: 25,
//         iconEnabledColor: Colors.black,
//         iconDisabledColor: Colors.grey,
//         buttonHeight: 30,
//         buttonWidth: 310,
//         buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//         buttonDecoration: const BoxDecoration(color: Colors.transparent),
//         itemHeight: 40,
//         itemPadding: const EdgeInsets.only(left: 14, right: 14),
//         dropdownMaxHeight: 500,
//         dropdownWidth: 300,
//         dropdownDecoration: const BoxDecoration(
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

// class CustomDropDownEnquiry extends StatefulWidget {
//   const CustomDropDownEnquiry({Key? key}) : super(key: key);

//   @override
//   State<CustomDropDownEnquiry> createState() => _CustomDropDownEnquiryState();
// }

// class _CustomDropDownEnquiryState extends State<CustomDropDownEnquiry> {
//   final List<String> items = [
//     'Item1',
//     'Item2',
//     'Item3',
//     'Item4',
//     'Item5',
//     'Item6',
//     'Item7',
//     'Item8',
//   ];
//   String? selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         isExpanded: true,
//         hint: Row(
//           children: [
//             Container(
//               child: const Text(
//                 'All Enquiry',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//                 // overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         items: items
//             .map((item) => DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(
//                     item,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ))
//             .toList(),
//         value: selectedValue,
//         onChanged: (value) {
//           setState(() {
//             selectedValue = value as String;
//           });
//         },
//         icon: const Icon(
//           Icons.keyboard_arrow_down,
//         ),
//         iconSize: 25,
//         iconEnabledColor: Colors.black,
//         iconDisabledColor: Colors.grey,
//         buttonHeight: 30,
//         buttonWidth: 310,
//         buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//         buttonDecoration: const BoxDecoration(color: Colors.transparent),
//         itemHeight: 40,
//         itemPadding: const EdgeInsets.only(left: 14, right: 14),
//         dropdownMaxHeight: 500,
//         dropdownWidth: 300,
//         dropdownDecoration: const BoxDecoration(
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

// class CustomDropDown extends StatefulWidget {
//   const CustomDropDown({Key? key}) : super(key: key);

//   @override
//   State<CustomDropDown> createState() => _CustomDropDownState();
// }

// class _CustomDropDownState extends State<CustomDropDown> {
//   final List<String> items = [
//     'Item1',
//     'Item2',
//     'Item3',
//     'Item4',
//     'Item5',
//     'Item6',
//     'Item7',
//     'Item8',
//   ];
//   String? selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         isExpanded: true,
//         hint: Row(
//           children: [
//             Container(
//               child: const Text(
//                 'All Lead',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//                 // overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         items: items
//             .map((item) => DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(
//                     item,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ))
//             .toList(),
//         value: selectedValue,
//         onChanged: (value) {
//           setState(() {
//             selectedValue = value as String;
//           });
//         },
//         icon: const Icon(
//           Icons.keyboard_arrow_down,
//         ),
//         iconSize: 25,
//         iconEnabledColor: Colors.black,
//         iconDisabledColor: Colors.grey,
//         buttonHeight: 30,
//         buttonWidth: 310,
//         buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//         buttonDecoration: const BoxDecoration(color: Colors.transparent),
//         itemHeight: 40,
//         itemPadding: const EdgeInsets.only(left: 14, right: 14),
//         dropdownMaxHeight: 500,
//         dropdownWidth: 300,
//         dropdownDecoration: const BoxDecoration(
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

Future<SourceListData> getCustomSearchCall() async {
  var url = "https://services.kit19.com/UserCRM/GetCustomSearchNameList";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"EntityName": "lead"}
  };
  final bodyjson = json.encode(body);
  // pass headers parameters if any
  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: bodyjson);
  print(" url call from " + url);
  if (response.statusCode == 200) {
    print('url hit successful' + response.body);
    String data = response.body;

    return SourceListData.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

class CustomSearchDropDown extends StatefulWidget {
  const CustomSearchDropDown({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomSearchDropDown> createState() => _CustomSearchDropDownState();
}

class _CustomSearchDropDownState extends State<CustomSearchDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (context) => FutureBuilder<SourceListData>(
          future:
              getCustomSearchCall(), // here get_datacall()  can be call directly
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(" show data on screen " + snapshot.data.toString());
              var len = snapshot.data!.details!.length;

              return Container(
                  height: 30,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ListView.builder(
                        itemCount: snapshot.data!.details!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(snapshot.data!.details![index].text
                                    .toString()),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          );
                        }),
                  ));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return Center(
              child: Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                child: const SpinKitFadingCircle(
                  color: AppTheme.white,
                  size: 34,
                ),
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: AppTheme.colorPrimary),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BottomsheetWidget extends StatelessWidget {
  const BottomsheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              // ignore: unnecessary_const
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
          backgroundColor: Colors.white,
          context: context,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                SizedBox(
                  height: 20,
                ),
                CustomSearchDropDown(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        child: Row(
          children: const [
            Text(
              'All Lead',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              // overflow: TextOverflow.ellipsis,
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
