import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kit_19/model/from_mail_id_model.dart';
import 'package:kit_19/model/template_data_model.dart';
import 'package:kit_19/ui/enquiries/widgets/send_sms.dart';
import 'package:http/http.dart' as http;

import '../../../model/mailandsms_template_list_model.dart';
import '../../../model/user_data.dart';
import '../../../utils/app_theme.dart';
import '../lead_common_data.dart';

String frommail = 'Select From mail';
String replyto = 'Select Reply to';
String template = 'Select Template';

class LeadSendMail extends StatefulWidget {
  const LeadSendMail({Key? key}) : super(key: key);

  @override
  State<LeadSendMail> createState() => _LeadSendMailState();
}

class _LeadSendMailState extends State<LeadSendMail> {
  bool value = true;

  String? choice;

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
            if (id == 0) ...[
              const BottomModalFromMailidList(),
            ] else if (id == 1) ...[
              const BottomModalReplyMailidList(),
            ] else if (id == 2) ...[
              const BottomModalmailTemplateList(),
            ]
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
        title: const Text('Send Email'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                          child: Image.asset(
                              "assets/icons/user_place_holder.png")),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    LeadDetailsCommon.name,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              if (LeadDetailsCommon.email1 == 'null') ...[
                const Text(''),
              ] else ...[
                Row(
                  children: [
                    const CheckBoxCustom(),
                    Text(
                      LeadDetailsCommon.email1,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
              if (LeadDetailsCommon.email2 == 'null') ...[
                const Text(''),
              ] else ...[
                Row(
                  children: [
                    const CheckBoxCustom(),
                    Text(
                      LeadDetailsCommon.email2,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
              if (LeadDetailsCommon.email3 == 'null') ...[
                const Text(''),
              ] else ...[
                Row(
                  children: [
                    const CheckBoxCustom(),
                    Text(
                      LeadDetailsCommon.email3,
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
                  _modalsheet('Select from Mail id', 0);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    border: const Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          frommail,
                          style: const TextStyle(fontSize: 14),
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
                  _modalsheet('Select Reply to', 1);
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
                          replyto,
                          style: const TextStyle(fontSize: 14),
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
              choice == ''
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: "Select Template",
                              groupValue: choice,
                              onChanged: (value) {
                                setState(() {
                                  choice = value.toString();
                                });
                              },
                            ),
                            const Text('Select template'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: "Compose Email",
                              groupValue: choice,
                              onChanged: (value) {
                                setState(() {
                                  choice = value.toString();
                                });
                              },
                            ),
                            const Text('Compose Email'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
              choice == 'Compose Email'
                  ? const TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    )
                  : Column(children: [
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _modalsheet('Please Select Template Name', 2);
                          setState(() {});
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  template,
                                  style: const TextStyle(fontSize: 14),
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
                      // ModalSheetHeading.templateid == 0
                      //     ? Container()
                      //     : Container(
                      //         width: MediaQuery.of(context).size.width,
                      //         decoration: const BoxDecoration(
                      //           border: const Border(
                      //             bottom: const BorderSide(
                      //                 width: 1.0, color: Colors.black),
                      //           ),
                      //         ),
                      //         child: const Expanded(
                      //           child: const TemplateDataApi(),
                      //         ),
                      //       ),
                      const SizedBox(
                        height: 20,
                      ),
                    ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppTheme.colorPrimary,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                content: const Text("Mail Sent"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Ok")),
                  ),
                ],
              ),
            );
          },
          child: Container(
            height: 50,
            child: const Center(
              child: Text(
                'Send Mail',
                style: const TextStyle(
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

class CustHeading extends StatefulWidget {
  const CustHeading({
    Key? key,
    required this.heading,
  }) : super(key: key);

  final String heading;

  @override
  State<CustHeading> createState() => _CustHeadingState();
}

class _CustHeadingState extends State<CustHeading> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.heading,
      style: const TextStyle(fontSize: 14),
    );
  }
}

class RadoiButtonCust extends StatefulWidget {
  const RadoiButtonCust({Key? key}) : super(key: key);

  @override
  State<RadoiButtonCust> createState() => _RadoiButtonCustState();
}

class _RadoiButtonCustState extends State<RadoiButtonCust> {
  String? choice; //no radio button will be selected
  //String gender = "male"; //if you want to set default value
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ListTile(
          title: const Text("Select Template"),
          leading: Radio(
              value: "Select Template",
              groupValue: choice,
              onChanged: (value) {
                setState(() {
                  choice = value.toString();
                });
              }),
        ),
        ListTile(
          title: const Text("Compose Email"),
          leading: Radio(
              value: "Compose Email",
              groupValue: choice,
              onChanged: (value) {
                setState(() {
                  choice = value.toString();
                });
              }),
        ),
      ],
    );
  }
}

Future<TemplateModel> getmailtemplatelist() async {
  var url = "https://services.kit19.com/UserCRM/GetEnquiryMailTemplate";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"ParentID": UserDetails.parentID, "isSMS": 0, "isMail": 1}
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

class BottomModalmailTemplateList extends StatefulWidget {
  const BottomModalmailTemplateList({Key? key}) : super(key: key);

  @override
  State<BottomModalmailTemplateList> createState() =>
      _BottomModalmailTemplateListState();
}

class _BottomModalmailTemplateListState
    extends State<BottomModalmailTemplateList> {
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
                        getmailtemplatelist(), // here get_datacall()  can be call directly
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
                                      template = snapshot
                                          .data!.details![i].mailTemplateName
                                          .toString();
                                      ModalSheetHeading.templateid = snapshot
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

Future<FromMailIdSendMailModel> getFromMailidlist() async {
  var url = "https://services.kit19.com/Common/GetFromMailIdByUserId";

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
    String data = response.body;

    return FromMailIdSendMailModel.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

class BottomModalFromMailidList extends StatefulWidget {
  const BottomModalFromMailidList({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomModalFromMailidList> createState() =>
      _BottomModalFromMailidListState();
}

class _BottomModalFromMailidListState extends State<BottomModalFromMailidList> {
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
                  child: FutureBuilder<FromMailIdSendMailModel>(
                    // initiallly get_prodModellist is empty so you will see a progreessbar on screen
                    // OR
                    // you can directly call the get_datacall() function here to automatically get
                    // data from sever and show on UI
                    future:
                        getFromMailidlist(), // here get_datacall()  can be call directly
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
                                      frommail = snapshot.data!.details![i].text
                                          .toString();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    snapshot.data!.details![i].text.toString(),
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

class BottomModalReplyMailidList extends StatefulWidget {
  const BottomModalReplyMailidList({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomModalReplyMailidList> createState() =>
      _BottomModalReplyMailidListState();
}

class _BottomModalReplyMailidListState
    extends State<BottomModalReplyMailidList> {
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
                  child: FutureBuilder<FromMailIdSendMailModel>(
                    future:
                        getFromMailidlist(), // here get_datacall()  can be call directly
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
                                      replyto = snapshot.data!.details![i].text
                                          .toString();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    snapshot.data!.details![i].text.toString(),
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

class ModalSheetHeading {
  static int templateid = 0;
  static String frommailheading = 'Select From mail';
  static String replytoheading = 'Select Reply to';
  static String templateheading = 'Select Template';
}

Future<TemplateData> getmailtemplatedata() async {
  var url = "https://services.kit19.com/Common/GetMessageTextByTemplateId";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"TemplateId": ModalSheetHeading.templateid}
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

    return TemplateData.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

class TemplateDataApi extends StatefulWidget {
  const TemplateDataApi({Key? key}) : super(key: key);

  @override
  State<TemplateDataApi> createState() => _TemplateDataApiState();
}

class _TemplateDataApiState extends State<TemplateDataApi> {
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
                  child: FutureBuilder<TemplateData>(
                    // initiallly get_prodModellist is empty so you will see a progreessbar on screen
                    // OR
                    // you can directly call the get_datacall() function here to automatically get
                    // data from sever and show on UI
                    future:
                        getmailtemplatedata(), // here get_datacall()  can be call directly
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(
                            " show data on screen " + snapshot.data.toString());
                        var len = snapshot.data!.details!.length;

                        return SingleChildScrollView(
                            child: Text(snapshot.data!.details.toString()));
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
