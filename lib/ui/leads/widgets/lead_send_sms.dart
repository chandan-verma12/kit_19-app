// ignore_for_file: avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kit_19/model/mailandsms_template_list_model.dart';

import 'package:kit_19/model/sender_id_sms_model.dart';
import 'package:kit_19/model/sms_template_data.dart';
import 'package:kit_19/model/user_data.dart';

import '../../../utils/app_theme.dart';
import '../lead_common_data.dart';

class LeadSendSmsPage extends StatefulWidget {
  const LeadSendSmsPage({Key? key}) : super(key: key);

  @override
  State<LeadSendSmsPage> createState() => _LeadSendSmsPageState();
}

class _LeadSendSmsPageState extends State<LeadSendSmsPage> {
  bool value = false;

  void _modalsheet(String heading, int id) {
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
            id == 0
                ? const BottomModalSenderidList()
                : const BottomModalsmsTemplateList()
          ],
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
        title: const Text('Send SMS'),
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
                  LeadDetailsCommon.name,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            if (LeadDetailsCommon.mobile1 == 'null') ...[
              const Text(''),
            ] else ...[
              Row(
                children: [
                  const CheckBoxCustom(),
                  Text(
                    LeadDetailsCommon.mobile1,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
            if (LeadDetailsCommon.mobile2 == 'null') ...[
              const Text(''),
            ] else ...[
              Row(
                children: [
                  const CheckBoxCustom(),
                  Text(
                    LeadDetailsCommon.mobile2,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
            if (LeadDetailsCommon.mobile3 == 'null') ...[
              const Text(''),
            ] else ...[
              Row(
                children: [
                  const CheckBoxCustom(),
                  Text(
                    LeadDetailsCommon.mobile3,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _modalsheet('Please Select Sender ID', 0);
                setState(() {});
              },
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
                        ApiSendData.sendname,
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
            GestureDetector(
              onTap: () {
                _modalsheet('Please Select Template', 1);
                setState(() {});
              },
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
                        ApiSendData.templ,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.refresh)),
            const SizedBox(
              height: 20,
            ),
            // if (ApiSendData.templ == 'null')
            //   Container()
            // else
            //   Expanded(
            //     // ignore: avoid_unnecessary_containers
            //     child: Container(
            //       child: const SMSTemplatedataapi(),
            //     ),
            //   ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                CheckBoxCustom(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Is Unicode',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            )
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
                content: const Text("SMS Sent SuccessFully"),
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
                'Send SMS',
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

class CheckBoxCustom extends StatefulWidget {
  const CheckBoxCustom({Key? key}) : super(key: key);

  @override
  State<CheckBoxCustom> createState() => _CheckBoxCustomState();
}

class _CheckBoxCustomState extends State<CheckBoxCustom> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: rememberMe,
      onChanged: (bool? value) {
        setState(() {
          rememberMe = value!;
        });
      },
    );
  }
}

Future<TemplateDataSMS> getSmsTemplatedata() async {
  var url = "https://services.kit19.com/UserCRM/GetSmsDltTemplate";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"SenderName": ApiSendData.sendname}
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

    return TemplateDataSMS.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

Future<SMSSenderId> getSmssenderid() async {
  var url = "https://services.kit19.com/UserCRM/GetSenderIdList";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"UserId": UserDetails.userId}
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

    return SMSSenderId.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

Future<TemplateModel> getsmstemplatelist() async {
  var url = "https://services.kit19.com/UserCRM/GetEnquiryMailTemplate";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"ParentID": UserDetails.parentID, "isSMS": 1, "isMail": 0}
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

    return TemplateModel.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

class BottomModalsmsTemplateList extends StatefulWidget {
  const BottomModalsmsTemplateList({Key? key}) : super(key: key);

  @override
  State<BottomModalsmsTemplateList> createState() =>
      _BottomModalsmsTemplateListState();
}

class _BottomModalsmsTemplateListState
    extends State<BottomModalsmsTemplateList> {
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
                  child: FutureBuilder<TemplateModel>(
                    // initiallly get_prodModellist is empty so you will see a progreessbar on screen
                    // OR
                    // you can directly call the get_datacall() function here to automatically get
                    // data from sever and show on UI
                    future:
                        getsmstemplatelist(), // here get_datacall()  can be call directly
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
                                      ApiSendData.templ = snapshot
                                          .data!.details![i].mailTemplateName
                                          .toString();
                                      ApiSendData.templateid = snapshot
                                          .data!.details![i].mailTemplateId!
                                          .toInt();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    snapshot.data!.details![i].mailTemplateName
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
                      return Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          child: SpinKitFadingCircle(
                            color: AppTheme.white,
                            size: 34,
                          ),
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: AppTheme.colorPrimary),
                        ),
                      );
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

class ApiSendData {
  static int sendid = 0;
  static String sendname = 'Sender ID';
  static String templ = 'Template';
  static int templateid = 0;
}

class BottomModalSenderidList extends StatefulWidget {
  const BottomModalSenderidList({Key? key}) : super(key: key);

  @override
  State<BottomModalSenderidList> createState() =>
      _BottomModalSenderidListState();
}

class _BottomModalSenderidListState extends State<BottomModalSenderidList> {
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
                  child: FutureBuilder<SMSSenderId>(
                    future:
                        getSmssenderid(), // here get_datacall()  can be call directly
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(
                            " show data on screen " + snapshot.data.toString());
                        var len = snapshot.data!.senderid!.length;

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
                                      ApiSendData.sendname = snapshot
                                          .data!.senderid![i].senderName
                                          .toString();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    snapshot.data!.senderid![i].senderName
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
                      return Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          child: SpinKitFadingCircle(
                            color: AppTheme.white,
                            size: 34,
                          ),
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: AppTheme.colorPrimary),
                        ),
                      );
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

class SMSTemplatedataapi extends StatefulWidget {
  const SMSTemplatedataapi({Key? key}) : super(key: key);

  @override
  State<SMSTemplatedataapi> createState() => _SMSTemplatedataapiState();
}

class _SMSTemplatedataapiState extends State<SMSTemplatedataapi> {
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
                  child: FutureBuilder<TemplateDataSMS>(
                    future:
                        getSmsTemplatedata(), // here get_datacall()  can be call directly
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
                                    setState(() {});
                                  },
                                  child: Text(
                                    snapshot.data!.details![i].templateText
                                        .toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ]
                          ],
                        );
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
                          child: SpinKitFadingCircle(
                            color: AppTheme.white,
                            size: 34,
                          ),
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: AppTheme.colorPrimary),
                        ),
                      );
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
