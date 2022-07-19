import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kit_19/model/get_enqleadmobmodel.dart';
import 'package:kit_19/ui/TaskFile/upload_document_page.dart';
import 'package:kit_19/ui/appointment/add_appoinments.dart';
import 'package:kit_19/ui/enquiries/widgets/send_mail.dart';
import 'package:kit_19/ui/enquiries/widgets/send_sms.dart';
import 'package:kit_19/ui/enquiries/widgets/send_voice.dart';
import 'package:kit_19/ui/follwup/add_followup.dart';
import 'package:kit_19/ui/leads/lead_common_data.dart';
import 'package:http/http.dart' as http;
import 'package:kit_19/ui/leads/lead_tab_bar.dart';
import 'package:kit_19/ui/notes/add_notes%20(5).dart';
import 'package:kit_19/ui/task/add_task.dart';

import '../../model/user_data.dart';
import '../../utils/app_theme.dart';
import '../notes/add_deal (2).dart';
import '../notes/add_notes (6).dart';

String pagename = 'Select';

class CallPopupUpdated extends StatefulWidget {
  const CallPopupUpdated({
    Key? key,
  }) : super(key: key);

  @override
  State<CallPopupUpdated> createState() => _CallPopupUpdatedState();
}

class _CallPopupUpdatedState extends State<CallPopupUpdated> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        elevation: 0,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 200,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          shape: BoxShape.rectangle),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                            size: const Size.fromRadius(30), // Image radius
                            child: Image.asset(
                                "assets/icons/user_place_holder.png")),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: EnqorLeadByMobile(),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.cancel))
                ],
              ),
              DropDownButtonPopup(),
              //  if (pagename == 'Webform') ...[
              //   TextButton(
              //     onPressed: () {},
              //     child: Container(
              //       color: Colors.green,
              //       width: MediaQuery.of(context).size.width * 0.8,
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Center(
              //           child: Text(
              //             'Proceed',
              //             style: TextStyle(color: Colors.black),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ] else if (pagename == 'Add Invoice') ...[
              //   TextButton(
              //     onPressed: () {},
              //     child: Container(
              //       color: Colors.green,
              //       width: MediaQuery.of(context).size.width * 0.8,
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Center(
              //           child: Text(
              //             'Proceed',
              //             style: TextStyle(color: Colors.black),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ] else if (pagename == 'Add Quoatation') ...[
              //   TextButton(
              //     onPressed: () {},
              //     child: Container(
              //       color: Colors.green,
              //       width: MediaQuery.of(context).size.width * 0.8,
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Center(
              //           child: Text(
              //             'Proceed',
              //             style: TextStyle(color: Colors.black),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ] else if (pagename == 'Add Tax Setting') ...[
              //   TextButton(
              //     onPressed: () {},
              //     child: Container(
              //       color: Colors.green,
              //       width: MediaQuery.of(context).size.width * 0.8,
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Center(
              //           child: Text(
              //             'Proceed',
              //             style: TextStyle(color: Colors.black),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ] else
              if (pagename == 'Add Deal') ...[
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => AddDeal()));
                  },
                  child: Container(
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else if (pagename == 'Add Appointment') ...[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => AddAppointment()));
                  },
                  child: Container(
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else if (pagename == 'Add Task') ...[
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => AddTask()));
                  },
                  child: Container(
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else if (pagename == 'Upload Document') ...[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => UploadDocuments()));
                  },
                  child: Container(
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else if (pagename == 'Add Note') ...[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => AddNotesPage()));
                  },
                  child: Container(
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else if (pagename == 'Add Followup') ...[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => AddFollowUp()));
                  },
                  child: Container(
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else if (pagename == 'Send Mail') ...[
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => SendMail()));
                  },
                  child: Container(
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else if (pagename == 'Send Voice') ...[
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => SendVoice()));
                  },
                  child: Container(
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else if (pagename == 'Send SMS') ...[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SendSmsPage()));
                  },
                  child: Container(
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else if (pagename == 'Open Lead') ...[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => TabBarLeadDetails(
                                  id: LeadDetailsCommon.leadidcommon,
                                )));
                  },
                  child: Container(
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class DropDownButtonPopup extends StatefulWidget {
  const DropDownButtonPopup({Key? key}) : super(key: key);

  @override
  _DropDownButtonPopupState createState() => _DropDownButtonPopupState();
}

class _DropDownButtonPopupState extends State<DropDownButtonPopup> {
  String dropdownvalue = 'Add Followup';

  var items = [
    // 'Open Lead',
    // 'Webform',
    // 'Add Invoice',
    // 'Add Quoatation',
    // 'Add Tax Setting',
    'Add Followup',
    'Open Lead',
    'Add Appointment',
    'Add Task',
    'Upload Document',
    'Send Mail',
    'Send Voice',
    'Send SMS',
    'Add Deal',
    'Add Note',
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButton(
            value: dropdownvalue,

            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),

            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
                pagename = dropdownvalue;
              });
            },
          ),
        ],
      ),
    );
  }
}

Future<GetEnqOrLeadMobModel> getEnqorLeadNumber() async {
  var url = "https://services.kit19.com/UserCRM/GetEnquiryLeadByMobileNo";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "MobileNo": LeadDetailsCommon.mobile1,
      "UserId": UserDetails.userId
    }
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

    return GetEnqOrLeadMobModel.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

class EnqorLeadByMobile extends StatefulWidget {
  const EnqorLeadByMobile({Key? key}) : super(key: key);

  @override
  State<EnqorLeadByMobile> createState() => _EnqorLeadByMobileState();
}

class _EnqorLeadByMobileState extends State<EnqorLeadByMobile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Builder(
        builder: (context) => Container(
          color: Colors.white,
          child: FutureBuilder<GetEnqOrLeadMobModel>(
            future:
                getEnqorLeadNumber(), // here get_datacall()  can be call directly
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(" show data on screen " + snapshot.data.toString());

                return Column(
                  children: [
                    Text(snapshot.data!.details!.personName.toString()),
                    Text(LeadDetailsCommon.mobile1),
                    Text(snapshot.data!.details!.type.toString()),
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
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: AppTheme.colorPrimary),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
