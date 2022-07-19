import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kit_19/model/source_list_model.dart';
import 'package:kit_19/utils/app_theme.dart';
import 'package:http/http.dart' as http;

import '../../model/custom_fields_model.dart';
import '../../model/user_data.dart';

String sourceno = '';
String sourcename = 'Select Source';
String mediumno = '';
String mediumname = 'Select Medium';
String campaignno = '';
String campaignname = 'Select Campaign';
bool showall = false;

class NewEnquiry extends StatefulWidget {
  const NewEnquiry({Key? key}) : super(key: key);

  @override
  State<NewEnquiry> createState() => _NewEnquiryState();
}

class _NewEnquiryState extends State<NewEnquiry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colorPrimary,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Add Enquiry'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 160,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      height: 140,
                      width: 150,
                      child: Image.asset(
                        'assets/icons/user.png',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 1,
                    right: 1,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(Icons.edit, color: Colors.black),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: Colors.white,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                50,
                              ),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(2, 4),
                                color: Colors.black.withOpacity(
                                  0.3,
                                ),
                                blurRadius: 3,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(5),
              padding: const EdgeInsets.all(6),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(const Radius.circular(12)),
                child: Container(
                  height: 35,
                  width: 220,
                  child: const Center(
                    child: const Text('Maximum Uploaded File Size 1MB'),
                  ),
                ),
              ),
            ),
            const MyCustomFormEnquiry(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppTheme.colorPrimary,
        height: 90,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showall = !showall;
                });
              },
              child: Container(
                height: 40,
                color: Colors.white60,
                child: const Center(
                  child: Text(
                    'Show All Fields',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    content: const Text("Enquiry Saved SuccessFully"),
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
                    'Save',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomFormEnquiry extends StatefulWidget {
  const MyCustomFormEnquiry({key});

  @override
  MyCustomFormEnquiryState createState() {
    return MyCustomFormEnquiryState();
  }
}

class MyCustomFormEnquiryState extends State<MyCustomFormEnquiry> {
  final _formKey = GlobalKey<FormState>();
  String person_name = '';
  String mobile_no1 = '';
  String mobile_no2 = '';
  String mobile_no3 = '';
  String email_id1 = '';
  String email_id2 = '';
  String email_id3 = '';

  void _modalsheets(String heading) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(25.0))),
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
                const SourceList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _modalsheetm(String heading) {
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
                const MediumList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _modalsheetc(String heading) {
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
                const CampaignList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Full Name',
                labelText: 'Name *',
                hintStyle: TextStyle(fontSize: 12),
                labelStyle: TextStyle(fontSize: 20),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  person_name = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Mobile No.',
                labelText: 'Mobile No. *',
                hintStyle: TextStyle(fontSize: 12),
                labelStyle: TextStyle(fontSize: 20),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  mobile_no1 = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Mobile No.',
                labelText: 'Mobile No. ',
                hintStyle: TextStyle(fontSize: 12),
                labelStyle: TextStyle(fontSize: 20),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  mobile_no2 = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Mobile no.',
                labelText: 'Mobile No. ',
                hintStyle: TextStyle(fontSize: 12),
                labelStyle: TextStyle(fontSize: 20),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  mobile_no3 = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Email ID',
                labelText: 'Email ID *',
                hintStyle: TextStyle(fontSize: 12),
                labelStyle: TextStyle(fontSize: 20),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  email_id1 = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Email ID',
                labelText: 'Email ID ',
                hintStyle: TextStyle(fontSize: 12),
                labelStyle: TextStyle(fontSize: 20),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  email_id2 = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Email ID',
                labelText: 'Email ID ',
                hintStyle: TextStyle(fontSize: 12),
                labelStyle: TextStyle(fontSize: 20),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  email_id3 = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () => _modalsheets(
                'Please Select Source',
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            sourcename,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () => _modalsheetm(
                'Please Select Medium',
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            mediumname,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () => _modalsheetc(
                'Please Select Campaign',
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            campaignname,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh),
            ),
          ),
          showall == false ? const Text('') : const CustomFormFieldsEnquiry(),
        ],
      ),
    );
  }
}

class CustomFormFieldsEnquiry extends StatefulWidget {
  const CustomFormFieldsEnquiry({Key? key}) : super(key: key);

  @override
  State<CustomFormFieldsEnquiry> createState() =>
      _CustomFormFieldsEnquiryState();
}

class _CustomFormFieldsEnquiryState extends State<CustomFormFieldsEnquiry> {
  Future<CustomFeildsModel> get_CustomFieldModellist = getCustomFieldProdCall();
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
                children: <Widget>[
                  Container(
                    child: FutureBuilder<CustomFeildsModel>(
                      future: get_CustomFieldModellist,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var len = snapshot.data!.details!.length;
                          print(" show data on screen " +
                              snapshot.data!.details![0].displayName
                                  .toString());
                          return Column(
                            children: [
                              for (var i = 0; i < len; i++) ...[
                                if (snapshot.data!.details![i].displayName ==
                                    'Enquiry Id') ...{
                                  Container(
                                    height: 0,
                                    width: 0,
                                  ),
                                } else if (snapshot
                                        .data!.details![i].displayName ==
                                    'Person Name') ...{
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        hintText: snapshot
                                            .data!.details![i++].displayName
                                            .toString(),
                                        labelText: snapshot
                                            .data!.details![i++].displayName
                                            .toString(),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                } else if (snapshot
                                        .data!.details![i].displayName ==
                                    'Mobile No')
                                  ...{}
                                else if (snapshot
                                        .data!.details![i].displayName ==
                                    'Mobile No 1') ...{
                                  // const SizedBox.shrink(),
                                } else if (snapshot
                                        .data!.details![i].displayName ==
                                    'Mobile No 2') ...{
                                  // const SizedBox.shrink(),
                                } else if (snapshot
                                        .data!.details![i].displayName ==
                                    'EmailId') ...{
                                  // const SizedBox.shrink(),
                                } else if (snapshot
                                        .data!.details![i].displayName ==
                                    'EmailId 1') ...{
                                  // const SizedBox.shrink(),
                                } else if (snapshot
                                        .data!.details![i].displayName ==
                                    'EmailId 2') ...{
                                  // const SizedBox.shrink(),
                                } else if (snapshot
                                        .data!.details![i].displayName ==
                                    'Source Name') ...{
                                  // const SizedBox.shrink(),
                                } else if (snapshot
                                        .data!.details![i].displayName ==
                                    'Medium Name') ...{
                                  // const SizedBox.shrink(),
                                } else if (snapshot
                                        .data!.details![i].displayName ==
                                    'Campaign Name') ...{
                                  // const SizedBox.shrink(),
                                } else
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        hintText: snapshot
                                            .data!.details![i].displayName
                                            .toString(),
                                        labelText: snapshot
                                            .data!.details![i].displayName
                                            .toString(),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
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
                            child: const SpinKitFadingCircle(
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
      ),
    );
  }
}

Future<CustomFeildsModel> getCustomFieldProdCall() async {
  var url = "https://services.kit19.com/Common/GetFormMetaData";
  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "UserId": UserDetails.userId,
      "Mode": "Enquiry",
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

    return CustomFeildsModel.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

Future<SourceListData> getSourceList() async {
  var url = "https://services.kit19.com/Common/GetUserSourceSettingsByParentId";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"ParentId": UserDetails.parentID}
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

Future<SourceListData> getMediumList() async {
  var url = "https://services.kit19.com/Common/GetUserMediumSettingsByParentId";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"ParentId": UserDetails.parentID}
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

Future<SourceListData> getCampaignList() async {
  var url =
      "https://services.kit19.com/Common/GetUserCampaignSettingsByParentId";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"ParentId": UserDetails.parentID}
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

class SourceList extends StatefulWidget {
  const SourceList({Key? key}) : super(key: key);

  @override
  State<SourceList> createState() => _SourceListState();
}

class _SourceListState extends State<SourceList> {
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
                  child: FutureBuilder<SourceListData>(
                    future:
                        getSourceList(), // here get_datacall()  can be call directly
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
                                      sourceno = snapshot.data!.details![i].code
                                          .toString();
                                      sourcename = snapshot
                                          .data!.details![i].text
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
                          child: const SpinKitFadingCircle(
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

class MediumList extends StatefulWidget {
  const MediumList({Key? key}) : super(key: key);

  @override
  State<MediumList> createState() => _MediumListState();
}

class _MediumListState extends State<MediumList> {
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
                  child: FutureBuilder<SourceListData>(
                    future: getMediumList(),
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
                                      mediumno = snapshot.data!.details![i].code
                                          .toString();
                                      mediumname = snapshot
                                          .data!.details![i].text
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
                          child: const SpinKitFadingCircle(
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

class CampaignList extends StatefulWidget {
  const CampaignList({Key? key}) : super(key: key);

  @override
  State<CampaignList> createState() => _CampaignListState();
}

class _CampaignListState extends State<CampaignList> {
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
                  child: FutureBuilder<SourceListData>(
                    future:
                        getCampaignList(), // here get_datacall()  can be call directly
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
                                      campaignno = snapshot
                                          .data!.details![i].code
                                          .toString();
                                      campaignname = snapshot
                                          .data!.details![i].text
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
