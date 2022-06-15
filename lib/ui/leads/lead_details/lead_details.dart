import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kit_19/model/LeadModel.dart';
import 'package:kit_19/model/lead_data.dart';
import 'package:kit_19/ui/leads/lead_details/lead_details_body.dart';

import '../../../model/full_lead_details_model.dart';
import '../../../model/user_data.dart';
import '../../../utils/app_theme.dart';

class BasicDetailsPage extends StatefulWidget {
  BasicDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<BasicDetailsPage> createState() => _BasicDetailsPageState();
}

class _BasicDetailsPageState extends State<BasicDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Builder(
              builder: (context) => Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: FutureBuilder<FullLeadDetails>(
                        // initiallly get_prodModellist is empty so you will see a progreessbar on screen
                        // OR
                        // you can directly call the get_datacall() function here to automatically get
                        // data from sever and show on UI
                        future: getBasicLeadDetailsProdCall(widget
                            .id), // here get_datacall()  can be call directly
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(" show data on screen " +
                                snapshot.data.toString());
                            var len = snapshot.data!.details!.length;
                            return BasicDetailsApi(
                              address:
                                  snapshot.data!.details![0].address.toString(),
                              assignedto: snapshot.data!.details![0].assignedTo
                                  .toString(),
                              lastupdated: snapshot
                                  .data!.details![0].followupDate
                                  .toString(),
                              leadno:
                                  snapshot.data!.details![0].leadNo.toString(),
                              name: snapshot.data!.details![0].personName
                                  .toString(),
                              emailid: snapshot.data!.details![0].emailID1
                                  .toString(),
                              mobileno: snapshot.data!.details![0].mobileNo1
                                  .toString(),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class LeadFullDetailsFAButton extends StatelessWidget {
  const LeadFullDetailsFAButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      spaceBetweenChildren: 1,
      backgroundColor: AppTheme.colorPrimary,
      spacing: 1,
      icon: Icons.list,
      activeIcon: Icons.cancel,
      childPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
        bottomLeft: Radius.circular(50),
      )),
      children: [
        SpeedDialChild(
          labelWidget: Container(
            width: 200,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black),
            ),
            child: Center(child: Text('Webform')),
          ),
        ),
        SpeedDialChild(
          labelWidget: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
              ),
              width: 200,
              child: Center(child: Text('Add Invoice'))),
        ),
        SpeedDialChild(
          labelWidget: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
              ),
              width: 200,
              child: Center(child: Text('Add quotation'))),
        ),
        SpeedDialChild(
          labelWidget: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
              ),
              width: 200,
              child: Center(child: Text('Add Tax Settings'))),
        ),
        SpeedDialChild(
          labelWidget: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
              ),
              width: 200,
              child: Center(child: Text('Add Deal'))),
        ),
        SpeedDialChild(
          labelWidget: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
              ),
              width: 200,
              child: Center(child: Text('Add Appointment'))),
        ),
        SpeedDialChild(
          labelWidget: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
              ),
              width: 200,
              child: Center(child: Text('Add Task'))),
        ),
        SpeedDialChild(
          labelWidget: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
              ),
              width: 200,
              child: Center(child: Text('Upload Documents'))),
        ),
        SpeedDialChild(
          labelWidget: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
              ),
              width: 200,
              child: Center(child: Text('Add Notes'))),
        ),
        SpeedDialChild(
          labelWidget: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
              ),
              width: 200,
              child: Center(child: Text('Add Followup'))),
        ),
        SpeedDialChild(
          labelWidget: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
              ),
              width: 200,
              child: Center(child: Text('Mail'))),
        ),
        SpeedDialChild(
          labelWidget: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
              ),
              width: 200,
              child: Center(child: Text('Send voice'))),
        ),
        SpeedDialChild(
          labelWidget: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
              ),
              width: 200,
              child: Center(child: Text('sms'))),
        ),
      ],
    );
  }
}

class LeadFullDetailsBottomNavBar extends StatelessWidget {
  const LeadFullDetailsBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: Platform.isIOS ? 20 : 0),
        decoration: const BoxDecoration(
          color: AppTheme.colorPrimary,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.white,
                    backgroundColor: AppTheme.colorPrimary),
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage(
                      'assets/icons/mail.png',
                    ),
                    color: AppTheme.white,
                    height: 30,
                    width: 30,
                  ),
                )),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.white,
                    backgroundColor: AppTheme.colorPrimary),
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage(
                      'assets/icons/sms.png',
                    ),
                    color: AppTheme.white,
                    height: 30,
                    width: 30,
                  ),
                )),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.white,
                    backgroundColor: AppTheme.colorPrimary),
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage(
                      'assets/icons/voice.png',
                    ),
                    color: AppTheme.white,
                    height: 30,
                    width: 30,
                  ),
                )),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.white,
                    backgroundColor: AppTheme.colorPrimary),
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage(
                      'assets/icons/phone.png',
                    ),
                    color: AppTheme.white,
                    height: 30,
                    width: 30,
                  ),
                )),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.white,
                    backgroundColor: AppTheme.colorPrimary),
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage(
                      'assets/icons/whatsapp.png',
                    ),
                    color: AppTheme.white,
                    height: 30,
                    width: 30,
                  ),
                ))
          ],
        ));
  }
}

Future<FullLeadDetails> getBasicLeadDetailsProdCall(int leadid) async {
  var url = "https://services.kit19.com/UserCRM/GetLeadDetailById";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "LeadId": leadid,
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

Future<FullLeadDetails> getFullLeadDetailsProdCall(int leadid) async {
  var url = "https://services.kit19.com/UserCRM/GetLeadDetailById";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "LeadId": leadid,
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

class FullDetailsPage extends StatefulWidget {
  FullDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<FullDetailsPage> createState() => _FullDetailsPageState();
}

class _FullDetailsPageState extends State<FullDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      child: FutureBuilder<FullLeadDetails>(
                        // initiallly get_prodModellist is empty so you will see a progreessbar on screen
                        // OR
                        // you can directly call the get_datacall() function here to automatically get
                        // data from sever and show on UI
                        future: getFullLeadDetailsProdCall(widget
                            .id), // here get_datacall()  can be call directly
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(" show data on screen " +
                                snapshot.data.toString());
                            var len = snapshot.data!.details!.length;

                            return FullDetailsPageApi(
                              name: snapshot.data!.details![0].personName
                                  .toString(),
                              mob1: snapshot.data!.details![0].mobileNo1
                                  .toString(),
                              mob2: snapshot.data!.details![0].mobileNo2
                                  .toString(),
                              mob3: snapshot.data!.details![0].mobileNo3
                                  .toString(),
                              email1: snapshot.data!.details![0].emailID1
                                  .toString(),
                              email2: snapshot.data!.details![0].emailID2
                                  .toString(),
                              email3: snapshot.data!.details![0].emailID3
                                  .toString(),
                              comname: snapshot.data!.details![0].companyName
                                  .toString(),
                              leadno:
                                  snapshot.data!.details![0].leadNo.toString(),
                              assigto: snapshot.data!.details![0].assignedTo
                                  .toString(),
                              src: snapshot.data!.details![0].sourceName
                                  .toString(),
                              med: snapshot.data!.details![0].mediumName
                                  .toString(),
                              camp: snapshot.data!.details![0].campaignName
                                  .toString(),
                              createon: snapshot.data!.details![0].createdOn
                                  .toString(),
                              crtby: snapshot.data!.details![0].assignedUser
                                  .toString(),
                              raddr:
                                  snapshot.data!.details![0].address.toString(),
                              rcity: snapshot.data!.details![0].city.toString(),
                              rsta: snapshot.data!.details![0].state.toString(),
                              rctry:
                                  snapshot.data!.details![0].country.toString(),
                              rpinco:
                                  snapshot.data!.details![0].pincode.toString(),
                              oadd: snapshot.data!.details![0].officeAddress
                                  .toString(),
                              ocit: snapshot.data!.details![0].city.toString(),
                              osta: snapshot.data!.details![0].state.toString(),
                              ocnty:
                                  snapshot.data!.details![0].country.toString(),
                              opincode:
                                  snapshot.data!.details![0].pincode.toString(),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
