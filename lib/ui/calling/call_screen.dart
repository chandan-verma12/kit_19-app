import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kit_19/model/enquiry_details.dart';
import 'package:kit_19/model/user_data.dart';
import 'package:kit_19/model/voip_endpoint_model.dart';
import 'package:kit_19/ui/leads/lead_common_data.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_theme.dart';

String? selectedmobno;
String code = "+91 ";
int? callpath;

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({Key? key}) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          LeadDetailsCommon.mobile1 == ''
              ? Text('')
              : ListTile(
                  title: Text(LeadDetailsCommon.mobile1),
                  leading: Radio(
                      value: LeadDetailsCommon.mobile1,
                      groupValue: selectedmobno,
                      onChanged: (value) {
                        setState(() {
                          selectedmobno = value.toString();
                        });
                      }),
                ),
          LeadDetailsCommon.mobile2 == ''
              ? Container()
              : ListTile(
                  title: Text(LeadDetailsCommon.mobile2),
                  leading: Radio(
                      value: LeadDetailsCommon.mobile2,
                      groupValue: selectedmobno,
                      onChanged: (value) {
                        setState(() {
                          selectedmobno = value.toString();
                        });
                      }),
                ),
          LeadDetailsCommon.mobile3 == ''
              ? Container()
              : ListTile(
                  title: Text(LeadDetailsCommon.mobile3),
                  leading: Radio(
                      value: LeadDetailsCommon.mobile3,
                      groupValue: selectedmobno,
                      onChanged: (value) {
                        setState(() {
                          selectedmobno = value.toString();
                        });
                      }),
                ),
        ],
      ),
    );
  }
}

class CustomEnqRadioButton extends StatefulWidget {
  const CustomEnqRadioButton({Key? key}) : super(key: key);

  @override
  State<CustomEnqRadioButton> createState() => _CustomEnqRadioButtonState();
}

class _CustomEnqRadioButtonState extends State<CustomEnqRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          EnquiryDetails.mobile1 == ''
              ? Text('')
              : ListTile(
                  title: Text(EnquiryDetails.mobile1),
                  leading: Radio(
                      value: EnquiryDetails.mobile1,
                      groupValue: selectedmobno,
                      onChanged: (value) {
                        setState(() {
                          selectedmobno = value.toString();
                        });
                      }),
                ),
          EnquiryDetails.mobile2 == ''
              ? Container()
              : ListTile(
                  title: Text(EnquiryDetails.mobile2),
                  leading: Radio(
                      value: EnquiryDetails.mobile2,
                      groupValue: selectedmobno,
                      onChanged: (value) {
                        setState(() {
                          selectedmobno = value.toString();
                        });
                      }),
                ),
          EnquiryDetails.mobile3 == ''
              ? Container()
              : ListTile(
                  title: Text(EnquiryDetails.mobile3),
                  leading: Radio(
                      value: EnquiryDetails.mobile3,
                      groupValue: selectedmobno,
                      onChanged: (value) {
                        setState(() {
                          selectedmobno = value.toString();
                        });
                      }),
                ),
        ],
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int callval = 0;
  Widget CustomRadioButton1(String text, int index, String path) {
    return TextButton(
      onPressed: () {
        setState(() {
          callval = index;
          callpath = index;
        });
      },
      child: Container(
        width: 100,
        height: 100,
        child: Column(
          children: [
            Image.asset(
              path,
              height: 70,
              width: 70,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: (callval == index) ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: (callval == index) ? Colors.green : Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CustomRadioButton1("Sim", 1, 'assets/icons/sim.png'),
        CustomRadioButton1("VOIP", 2, 'assets/icons/voipIcons.png'),
      ],
    );
  }
}

Future<VoidCallEndPointModel> getLeadvoipCall() async {
  var url = "https://services.kit19.com/UserCRM/CallVoipEndpoint";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "ToMoblieNo": "+91 $selectedmobno",
      "AgentId": UserDetails.userId,
      "EntityId": LeadDetailsCommon.leadidcommon,
      "EntityName": "lead",
      "ProviderName": "default"
    }
  };

  final bodyjson = json.encode(body);
  print(code + selectedmobno!);
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

    return VoidCallEndPointModel.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

Future<VoidCallEndPointModel> getEnquiryvoipCall() async {
  var url = "https://services.kit19.com/UserCRM/CallVoipEndpoint";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "ToMoblieNo": "+91 $selectedmobno",
      "AgentId": UserDetails.userId,
      "EntityId": EnquiryDetails.enqid,
      "EntityName": "enquiry",
      "ProviderName": "default"
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

    return VoidCallEndPointModel.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

class VoipCall extends StatefulWidget {
  const VoipCall({Key? key}) : super(key: key);

  @override
  State<VoipCall> createState() => _VoipCallState();
}

class _VoipCallState extends State<VoipCall> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Container(
        color: Colors.white,
        child: FutureBuilder<VoidCallEndPointModel>(
          future:
              getLeadvoipCall(), // here get_datacall()  can be call directly
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(" show data on screen " + snapshot.data.toString());

              return Text(snapshot.data!.message.toString());
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

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

class VoipCallEnquiry extends StatefulWidget {
  const VoipCallEnquiry({Key? key}) : super(key: key);

  @override
  State<VoipCallEnquiry> createState() => _VoipCallEnquiryState();
}

class _VoipCallEnquiryState extends State<VoipCallEnquiry> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Container(
        color: Colors.white,
        child: FutureBuilder<VoidCallEndPointModel>(
          future:
              getEnquiryvoipCall(), // here get_datacall()  can be call directly
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(" show data on screen " + snapshot.data.toString());

              return Text(snapshot.data!.message.toString());
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

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
