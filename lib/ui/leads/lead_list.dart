// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kit_19/main.dart';

import 'package:kit_19/model/LeadModel.dart';
import 'package:http/http.dart' as http;
import 'package:kit_19/model/user_data.dart';
import 'package:kit_19/ui/leads/lead_common_data.dart';
import 'package:kit_19/ui/leads/lead_tab_bar.dart';
import 'package:kit_19/ui/leads/widgets/lead_send_mail.dart';
import 'package:kit_19/ui/leads/widgets/lead_send_sms.dart';
import 'package:kit_19/ui/leads/widgets/lead_send_voice.dart';
import 'package:kit_19/ui/leads/widgets/lead_send_whatsapp.dart';

import '../../model/lead_data.dart';
import '../../utils/app_theme.dart';

import 'components/custom_drop_down.dart';

class LeadListAPi extends StatefulWidget {
  const LeadListAPi({Key? key}) : super(key: key);

  _LeadListApi createState() => _LeadListApi();
}

class _LeadListApi extends State<LeadListAPi> {
  Future<LeadListModel> get_prodModellist = _getDatacall();
  int index = 0;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Builder(
            builder: (context) => Container(
              padding: const EdgeInsets.all(15.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: FutureBuilder<LeadListModel>(
                      future:
                          get_prodModellist, 
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var len = snapshot.data!.details!.data!.length;

                          print(" show data on screen " +
                              snapshot.data!.details!.data![0].leadNo
                                  .toString());
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BottomsheetWidget(),
                                  // Icon(Icons.map),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              for (var i = 0; i < len; i++) ...[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      LeadDetailsCommon.leadidcommon = snapshot
                                          .data!.details!.data![i].id!
                                          .toInt();
                                      LeadDetailsCommon.email1 = snapshot
                                          .data!.details!.data![i].csvEmailId
                                          .toString();
                                      LeadDetailsCommon.mobile1 = snapshot
                                          .data!.details!.data![i].csvMobileNo
                                          .toString();
                                    });
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => TabBarLeadDetails(
                                          id: snapshot
                                              .data!.details!.data![i].id!
                                              .toInt(),
                                        ),
                                      ),
                                    );
                                    setState(() {});
                                  },
                                  child: LeadListPage(
                                    name: snapshot
                                        .data!.details!.data![i].personName
                                        .toString(),
                                    dueDate: snapshot
                                        .data!.details!.data![i].htmlStatus
                                        .toString(),
                                    username: snapshot
                                        .data!.details!.data![i].agentlogin
                                        .toString(),
                                    phno: snapshot
                                        .data!.details!.data![i].csvMobileNo
                                        .toString(),
                                    email: snapshot
                                        .data!.details!.data![i].csvEmailId
                                        .toString(),
                                    datetime: snapshot
                                        .data!.details!.data![i].createdDate
                                        .toString(),
                                    leadno: snapshot
                                        .data!.details!.data![i].leadNo
                                        .toString(),
                                    propic: snapshot
                                        .data!.details!.data![i].image
                                        .toString(),
                                    remarks: snapshot
                                        .data!.details!.data![i].remarks
                                        .toString(),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                              ],
                            ],
                          );
                        } else if (snapshot.data?.message == "Invalid Token") {
                          AlertDialog(
                            title: Text("Token Expired"),
                            content: Text('Kindly Login again'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => LoginPage()));
                                  },
                                  child: Text('Go to Login Page')),
                            ],
                          );
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
        ),
      ),
    );
  }
}

Future<LeadListModel> _getDatacall() {
  print(" get data using http");
  // call servicewrapper function
  servicewrapper wrapper = servicewrapper();
  return wrapper.getProdCall();
}

class servicewrapper {
  Future<LeadListModel> getProdCall() async {
    var url = "https://services.kit19.com/UserCRM/GetLeadListNew";
    final body = {
      "Status": "",
      "Message": "",
      "Token": UserDetails.token,
      "Details": {
        "UserId": UserDetails.userId,
        "CustomSearchId": 0,
        "PredefinedSearchId": 0,
        "FilterText": "",
        "Start": 0,
        "Limit": 100
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

      return LeadListModel.fromJson(json.decode(response.body));
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
  }
}

class LeadListPage extends StatefulWidget {
  const LeadListPage({
    Key? key,
    required this.name,
    required this.dueDate,
    required this.username,
    required this.phno,
    required this.email,
    required this.datetime,
    required this.leadno,
    required this.propic,
    required this.remarks,
  }) : super(key: key);
  final String name, dueDate, username, phno, email, datetime, leadno, propic;
  final String remarks;

  @override
  State<LeadListPage> createState() => _LeadListPageState();
}

class _LeadListPageState extends State<LeadListPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProfileLeadNo(
          leadno: widget.leadno,
          propic: widget.propic,
        ),
        Expanded(
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(child: _status(widget.dueDate)),
                      // dueDate == "null"
                      //     ? Text(" ")
                      //     : Text(
                      //         dueDate,
                      //         style: TextStyle(
                      //             fontSize: 14, fontWeight: FontWeight.bold),
                      //       ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.username == "null")
                        const Text(" ")
                      else
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/assigned.png',
                              color: Colors.black,
                              width: 20,
                              height: 20,
                            ),
                            Text(
                              widget.username,
                            ),
                          ],
                        ),
                      Text(widget.datetime),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/mobileNo.png',
                        color: Colors.black,
                        width: 20,
                        height: 20,
                      ),
                      Text(widget.phno),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/mail.png',
                            color: Colors.black,
                            width: 20,
                            height: 20,
                          ),
                          Flexible(
                            child: Container(
                                child: Text(
                              widget.email,
                              overflow: TextOverflow.ellipsis,
                            )),
                          ),
                        ],
                      )),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            LeadDetailsCommon.leadidcommon = LeadDetails.id;
                            LeadDetailsCommon.mobile1 = LeadDetails.csvMobileNo;
                            LeadDetailsCommon.email1 = LeadDetails.csvEmailId;
                          });
                        },
                        child: PopupMenuButton(
                          icon: const Icon(Icons.more_horiz),
                          iconSize: 18,
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              height: 1,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Image.asset(
                                      'assets/icons/mail.png',
                                      color: Colors.black,
                                    ),
                                    iconSize: 10.0,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  LeadSendMail()));
                                    },
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                      'assets/icons/sms.png',
                                      color: Colors.black,
                                    ),
                                    iconSize: 10.0,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  LeadSendSmsPage()));
                                    },
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                      'assets/icons/voice.png',
                                      color: Colors.black,
                                    ),
                                    iconSize: 10.0,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  LeadSendVoice()));
                                    },
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                      'assets/icons/whatsapp.png',
                                      color: Colors.black,
                                    ),
                                    iconSize: 10.0,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  SendWhatsapp()));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                        widget.remarks,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileLeadNo extends StatelessWidget {
  const ProfileLeadNo({
    Key? key,
    required this.leadno,
    required this.propic,
  }) : super(key: key);
  final String leadno, propic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          // Container(
          //   width: 70,
          //   height: 70,
          //   decoration: BoxDecoration(shape: BoxShape.circle),
          //   child: Stack(children: [
          //     CircleAvatar(radius: 50, child: Image.network(propic)),
          //   ]),
          // ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    shape: BoxShape.circle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(24), // Image radius
                    child: LeadDetails.image.isEmpty
                        ? Image.asset("assets/icons/user_place_holder.png")
                        : Image.network(propic),
                  ),
                ),
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: _score(LeadDetails.thresholdColor),
              ),
            ],
          ),
          const Text('Lead no.'),
          Text(leadno),
        ],
      ),
    );
  }
}

Widget _status(duedate) {
  if (duedate == "Due Today") {
    return Text(
      duedate,
      style: const TextStyle(
          color: Colors.brown, fontSize: 14, fontWeight: FontWeight.bold),
    );
  } else if (duedate == "Over Due") {
    return Text(
      duedate,
      style: const TextStyle(
          color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
    );
  } else if (duedate == "No Followup") {
    return Text(
      duedate,
      style: const TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
    );
  } else if (duedate == "Scheduled") {
    return Text(
      duedate,
      style: const TextStyle(
          color: Colors.orange, fontSize: 14, fontWeight: FontWeight.bold),
    );
  } else if (duedate == "Converted") {
    return Text(
      duedate,
      style: const TextStyle(
          color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),
    );
  } else if (duedate == "null") {
    return const Text(" ");
  } else {
    return Text(duedate);
  }
}

Widget _score(score) {
  if (LeadDetails.thresholdColor == "Cold") {
    return Container(
      height: 20,
      width: 20,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      child: Text(
        LeadDetails.currentScore.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  } else if (LeadDetails.thresholdColor == "Warm") {
    return Container(
      height: 20,
      width: 20,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
      child: Text(LeadDetails.currentScore.toString()),
    );
  } else if (LeadDetails.thresholdColor == "Hot") {
    return Container(
      height: 20,
      width: 20,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      child: Text(LeadDetails.currentScore.toString()),
    );
  } else if (LeadDetails.thresholdColor == "Default") {
    return Container(
      height: 20,
      width: 20,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
      child: Text(LeadDetails.currentScore.toString()),
    );
  } else {
    return Container(
      height: 20,
      width: 20,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
      child: Center(child: Text(LeadDetails.currentScore.toString())),
    );
  }
}
