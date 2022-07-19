import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:kit_19/model/user_data.dart';

import 'deal_list_pipeline_model.dart';
import 'deal_list_stage_model.dart';

class ShowStage extends StatefulWidget {
  ShowStage({Key? key}) : super(key: key);

  @override
  State<ShowStage> createState() => _ShowStageState();
}

class _ShowStageState extends State<ShowStage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.all(4),
                  child: FutureBuilder<DealListStage>(
                      future: itemStageList(),
                      // itemPipelineList(), // here get_datacall()  can be call directly
                      builder: (context, snapshot) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.details!.length,
                            itemBuilder: (BuildContext context, int index) {
                              Text(
                                snapshot.data!.details![index].name.toString(),
                                style: TextStyle(color: Colors.blue),
                              );
                              // log();
                              log("data is ${snapshot.data!.details![index].name.toString()}");
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<DealListPipeline> itemPipelineList() async {
    var url = "https://services.kit19.com/UserCRM/GetDealPipeline";
    // pass headers parameters if any
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Status": "",
        "Message": "",
        "Token": UserDetails.token,
        "Details": UserDetails.userId
      }),
    );
    var data = jsonDecode(response.body.toString());
    // print("notes id ${data!.details![index].NoteId}");
    if (response.statusCode == 200) {
      print('url hit successful' + response.body);
// return AddDeal.fromJson(jsonDecode(response.body));
      return DealListPipeline.fromJson(jsonDecode(response.body));
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
  }
}

Future<DealListStage> itemStageList() async {
  var url = "https://services.kit19.com/UserCRM/GetDealPipelineStage";
  // pass headers parameters if any
  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "Status": "",
      "Message": "",
      "Token": UserDetails.token,
      "Details": 15
    }),
  );
  var data = jsonDecode(response.body.toString());
  // print("notes id ${data!.details![index].NoteId}");
  if (response.statusCode == 200) {
    print('url hit successful' + response.body);
// return AddDeal.fromJson(jsonDecode(response.body));
    return DealListStage.fromJson(jsonDecode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}
