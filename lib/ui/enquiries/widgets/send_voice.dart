// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kit_19/model/dni_number_model.dart';
import 'package:kit_19/model/user_data.dart';
import 'package:kit_19/ui/enquiries/widgets/send_mail.dart';
import 'package:kit_19/ui/enquiries/widgets/send_sms.dart';
import 'package:http/http.dart' as http;

import '../../../model/enquiry_details.dart';
import '../../../utils/app_theme.dart';

String dninumber = 'DNI Number';
String appflow = 'App Flow';

class SendVoice extends StatefulWidget {
  const SendVoice({Key? key}) : super(key: key);

  @override
  State<SendVoice> createState() => _SendVoiceState();
}

class _SendVoiceState extends State<SendVoice> {
  bool value = false;

  void _modalsheet(String heading, int id) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.65,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      heading,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                id == 0 ? const ModalDniNumberList() : const ModalAppFlowList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colorPrimary,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Send Voice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      shape: BoxShape.circle),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                        size: const Size.fromRadius(24), // Image radius
                        child:
                            Image.asset("assets/icons/user_place_holder.png")),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  EnquiryDetails.name,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            if (EnquiryDetails.mobile1 == 'null') ...[
              const Text(''),
            ] else ...[
              Row(
                children: [
                  const CheckBoxCustom(),
                  Text(
                    EnquiryDetails.mobile1,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
            if (EnquiryDetails.mobile2 == 'null') ...[
              const Text(''),
            ] else ...[
              Row(
                children: [
                  const CheckBoxCustom(),
                  Text(
                    EnquiryDetails.mobile2,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
            if (EnquiryDetails.mobile3 == 'null') ...[
              const Text(''),
            ] else ...[
              Row(
                children: [
                  const CheckBoxCustom(),
                  Text(
                    EnquiryDetails.mobile3,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => _modalsheet('Please Select DNI Number', 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: Text(
                          dninumber,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => _modalsheet('Please Select App Flow/Audio', 1),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appflow,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomToggleButton(),
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.refresh)),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Voice will be sent to all numbers',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppTheme.colorPrimary,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                content: const Text("Voice sent Successfully"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text("Ok"),
                  ),
                ],
              ),
            );
          },
          child: Container(
            height: 50,
            child: const Center(
              child: Text(
                'Send Voice',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomToggleButton extends StatefulWidget {
  const CustomToggleButton({Key? key}) : super(key: key);

  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ToggleButtons(
          borderColor: Colors.black,
          fillColor: Colors.black54,
          borderWidth: 1,
          selectedBorderColor: Colors.black,
          selectedColor: Colors.white,
          borderRadius: BorderRadius.circular(5),
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Promotional',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Transactional',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = i == index;
              }
            });
          },
          isSelected: isSelected,
        ),
      ],
    );
  }
}

Future<DNINumber> getDniNumber() async {
  var url = "https://services.kit19.com/Common/GetDniOrAppId";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"ParentId": UserDetails.parentID, "AppId": 0, "Opt": 0}
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

    return DNINumber.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

class ModalDniNumberList extends StatefulWidget {
  const ModalDniNumberList({Key? key}) : super(key: key);

  @override
  State<ModalDniNumberList> createState() => _ModalDniNumberListState();
}

class _ModalDniNumberListState extends State<ModalDniNumberList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Builder(
          builder: (context) => Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: FutureBuilder<DNINumber>(
                    // initiallly get_prodModellist is empty so you will see a progreessbar on screen
                    // OR
                    // you can directly call the get_datacall() function here to automatically get
                    // data from sever and show on UI
                    future:
                        getDniNumber(), // here get_datacall()  can be call directly
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(
                            " show data on screen " + snapshot.data.toString());
                        var len = snapshot.data!.details!.length;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < len; i++) ...[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      dninumber = snapshot
                                          .data!.details![i].code
                                          .toString();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    snapshot.data!.details![i].code.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ]
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      // By default, show a loading spinner
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

Future<DNINumber> getAppFlowNumber() async {
  var url = "https://services.kit19.com/Common/GetDniOrAppId";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"ParentId": UserDetails.parentID, "AppId": 0, "Opt": 2}
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

    return DNINumber.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

class ModalAppFlowList extends StatefulWidget {
  const ModalAppFlowList({Key? key}) : super(key: key);

  @override
  State<ModalAppFlowList> createState() => _ModalAppFlowListState();
}

class _ModalAppFlowListState extends State<ModalAppFlowList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(children: [
          Builder(
            builder: (context) => Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: FutureBuilder<DNINumber>(
                      // initiallly get_prodModellist is empty so you will see a progreessbar on screen
                      // OR
                      // you can directly call the get_datacall() function here to automatically get
                      // data from sever and show on UI
                      future:
                          getAppFlowNumber(), // here get_datacall()  can be call directly
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(" show data on screen " +
                              snapshot.data.toString());
                          var len = snapshot.data!.details!.length;

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0; i < len; i++) ...[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        appflow = snapshot
                                            .data!.details![i].text
                                            .toString();
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      snapshot.data!.details![i].text
                                          .toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                              ]
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        // By default, show a loading spinner
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
