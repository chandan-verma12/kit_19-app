import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kit_19/ui/leads/lead_common_data.dart';
import '../../model/full_lead_details_model.dart';
import '../../model/user_data.dart';
import '../notes/full_lead_details_model.dart';

class MergeDetailPage extends StatefulWidget {
  const MergeDetailPage({Key? key}) : super(key: key);

  @override
  State<MergeDetailPage> createState() => _MergeDetailPageState();
}

class _MergeDetailPageState extends State<MergeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color.fromARGB(255, 15, 119, 19),
        title: const Text('Merge Lead to Lead'),
      ),
      body: Column(
        children: [
          FutureBuilder<FullLeadDetails>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(" show data on screen " + snapshot.data.toString());
                var len = snapshot.data!.details!.length;

                return Column(
                  children: [for (var i = 0; i < len; i++) ...[]],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Preview()),
          );
        },
        child: Container(
          height: 50,
          color: const Color.fromARGB(255, 15, 119, 19),
          child: const Center(
            child: Text(
              'Preview',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}

class LeadDetailsWidges extends StatefulWidget {
  const LeadDetailsWidges({Key? key}) : super(key: key);

  @override
  State<LeadDetailsWidges> createState() => _LeadDetailsWidgesState();
}

class _LeadDetailsWidgesState extends State<LeadDetailsWidges> {
  int selectedRadio = 0;
  Color _colorContainer = Color.fromARGB(255, 21, 109, 24);
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  final textController = TextEditingController();
  MyFormClass(var value) {
    // Set the text property to a value to be displayed
    if (value == 1) {
      textController.text = 'Beta';
    } else if (value == 2) {
      textController.text = 'Deta';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 19, 158, 24),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      height: 210,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ink(
              child: Container(
                height: 30,
                color: const Color.fromARGB(255, 19, 158, 24),
                child: const Padding(
                  padding: EdgeInsets.only(left: 8, top: 6),
                  child: Text(
                    'Serial',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 160,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SecondLeadData(
                          companyName2: '',
                          country2: '',
                          name2: '',
                          date2: '',
                          email2: '',
                          lead2: '',
                          mob2: '',
                          offAddress2: '',
                          resiAddress2: '',
                          state2: '',
                          yesNo2: '',
                          id: 2,
                        ),
                        const Text('Lead No.'),
                        const Text('7679'),
                        Radio(
                            activeColor: const Color.fromARGB(255, 11, 113, 14),
                            value: 1,
                            groupValue: selectedRadio,
                            onChanged: (val) {
                              setSelectedRadio(val as int);
                              MyFormClass(val);
                            }),
                        const Text('Beta')
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Lead No.'),
                        const Text('7679'),
                        Radio(
                            activeColor: const Color.fromARGB(255, 11, 113, 14),
                            value: 2,
                            groupValue: selectedRadio,
                            onChanged: (val) {
                              MyFormClass(val);
                              setSelectedRadio(val as int);
                            }),
                        const Text('Data')
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Final'),
                        const SizedBox(
                          width: 60,
                        ),
                        Flexible(
                          child: TextField(
                            controller: textController,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<FullLeadDetails> getBasicLeadDetailsProdCall(int leadid) async {
  var url = "https://services.kit19.com/UserCRM/GetLeadDetailById";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "LeadId": LeadDetailsCommon.leadidcommon,
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

    return FullLeadDetails.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

Future<FullLeadDetails> getBasicLeadDetailsByIdProdCall(int leadid) async {
  var url = "https://services.kit19.com/UserCRM/GetLeadDetailByLeadIdNew";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "LeadId": LeadDetailsCommon.leadidcommon,
      "UserId": UserDetails.token
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

    return FullLeadDetails.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

class FirstLeadData extends StatefulWidget {
  FirstLeadData(
      {Key? key,
      required this.name1,
      required this.companyName1,
      required this.mob1,
      required this.email1,
      required this.country1,
      required this.state1,
      required this.resiAddress1,
      required this.offAddress1,
      required this.yesNo1,
      required this.lead1,
      required this.date1,
      required this.id1})
      : super(key: key);
  String name1,
      companyName1,
      mob1,
      email1,
      country1,
      state1,
      resiAddress1,
      offAddress1,
      yesNo1,
      lead1,
      date1;
  int id1;
  @override
  State<FirstLeadData> createState() => _FirstLeadDataState();
}

class _FirstLeadDataState extends State<FirstLeadData> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SecondLeadData extends StatefulWidget {
  SecondLeadData(
      {Key? key,
      required this.name2,
      required this.companyName2,
      required this.mob2,
      required this.email2,
      required this.country2,
      required this.state2,
      required this.resiAddress2,
      required this.offAddress2,
      required this.yesNo2,
      required this.lead2,
      required this.date2,
      required this.id})
      : super(key: key);

  String name2,
      companyName2,
      mob2,
      email2,
      country2,
      state2,
      resiAddress2,
      offAddress2,
      yesNo2,
      lead2,
      date2;
  int id;
  @override
  State<SecondLeadData> createState() => _SecondLeadDataState();
}

class _SecondLeadDataState extends State<SecondLeadData> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FullLeadDetails>(
      future: getBasicLeadDetailsByIdProdCall(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const Text('Not Found data');
      },
    );
  }
}

class Preview extends StatefulWidget {
  const Preview({Key? key}) : super(key: key);

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  int selectedRadio = 0;
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Merge Lead to Lead'),
          backgroundColor: const Color.fromARGB(255, 15, 119, 19),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: Icon(Icons.arrow_back_ios),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Radio(
                          value: 1,
                          groupValue: selectedRadio,
                          onChanged: (val) {
                            setSelectedRadio(val as int);
                          }),
                      const Text("Keep lead 1 delete lead 2"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: 2,
                          groupValue: selectedRadio,
                          onChanged: (val) {
                            setSelectedRadio(val as int);
                          }),
                      const Text("Keep lead 2 delete lead 1"),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () {
                  print('Merge & Add Follow up Clicked');

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Expanded(
                        child: AlertDialog(
                          title: const Text('Success'),
                          content:
                              const Text('Lead Merged and Follw up created'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                    width: double.infinity,
                    height: 50,
                    color: const Color.fromARGB(255, 236, 230, 230),
                    child: const Center(
                        child: Text(
                      'Merge & Add Follow up',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    )))),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Expanded(
                      child: AlertDialog(
                        title: Text('Success'),
                        content: Text('Lead Merged Successfully'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: double.infinity,
                height: 50,
                color: const Color.fromARGB(255, 15, 119, 19),
                child: const Center(
                  child: Text(
                    'Merge to Lead',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

Future<FullLeadDetails> MergeleadToLeadCall(int leadid) async {
  var url = "https://services.kit19.com/UserCRM/MergeLeadToLead";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "LeadId1": 675813,
      "LeadId2": 675814,
      "MobileNo1": "",
      "MobileNo2": "",
      "MobileNo3": "",
      "EmailID1": "swati.malviyaeGNoYW5naW5nLmNvbQ==@naukri.com",
      "EmailID2": "",
      "EmailID3": "",
      "PersonName": "Xchanging",
      "CompanyName": "",
      "City": "New Delhi",
      "State": "Delhi",
      "Country": "India",
      "PinCode": 110071,
      "ResidentialAddress": "Plot No 4",
      "OfficeAddress": "Flat No 412",
      "ModifiedBy": leadid,
      "ParentID": leadid,
      "keepLead": 1,
      "lstCustomField": [
        {"FieldId": 366, "FieldName": "Name2", "FieldValue": "MyName"},
        {"FieldId": 367, "FieldName": "Name3", "FieldValue": "MyName"},
        {"FieldId": 888, "FieldName": "NEWMOBILE", "FieldValue": "748"},
        {"FieldId": 889, "FieldName": "NAMEONE", "FieldValue": "345"},
        {"FieldId": 881, "FieldName": "abcd", "FieldValue": ""}
      ],
      "followUp": {
        "AssignedTo": leadid,
        "FupValue": "35,1,0",
        "NextStatusDate": "17-Apr-2022 00:00:00",
        "Products": "7763,5555",
        "Remarks": "Follow this remarks",
        "AmountPaid": 0,
        "IsReAssign": true,
        "NotifyBySMS": true,
        "NotifyByEmail": true,
        "SmsScheduelDateTime": "16-Apr-2022 23:45:00",
        "EmailScheduelDateTime": "16-Apr-2022 23:45:00"
      }
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

    return FullLeadDetails.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}
