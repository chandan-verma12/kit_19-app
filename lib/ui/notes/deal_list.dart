import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kit_19/ui/leads/lead_common_data.dart';
import '../../model/user_data.dart';
import 'deal_details_list.dart';

class DealList extends StatefulWidget {
  DealList({Key? key}) : super(key: key);

  @override
  State<DealList> createState() => _DealListState();
}

class _DealListState extends State<DealList> {
  Future<DealDetailsList> dealsDetailsList() async {
    var url = "https://services.kit19.com/UserCRM/GetDealPipelineStage";
    // pass headers parameters if any
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Status": "",
        "Message": "",
        "Token": UserDetails.token,
        "Details": {"LeadId": LeadDetailsCommon.leadidcommon}
      }),
    );
    var data = jsonDecode(response.body.toString());
    // print("notes id ${data!.details![index].NoteId}");
    if (response.statusCode == 200) {
      print('url hit successful' + response.body);
// return AddDeal.fromJson(jsonDecode(response.body));
      return DealDetailsList.fromJson(jsonDecode(response.body))
          as DealDetailsList;
    } else {
      print('failed to get data');
      return DealDetailsList.fromJson(jsonDecode(response.body))
          as DealDetailsList;

      throw Exception('Failed to get data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deal History"),
        leading: IconButton(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          icon: Image.asset("assets/icons/drawer_icon.png"),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 40,
              )),
        ],
        backgroundColor: Color.fromARGB(255, 26, 213, 101),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Container(
                    // margin: EdgeInsets.all(4),
                    child: FutureBuilder<DealDetailsList>(
                      future:
                          dealsDetailsList(), // here get_datacall()  can be call directly
                      builder:
                          (context, AsyncSnapshot<DealDetailsList> snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.details!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // log();
                                    log("data is ${snapshot.data.toString()}");
                                    // print("data delete ${snapshot.data!.details![index].noteID.toString()}");

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Card(
                                          elevation: 4,
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 15),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(snapshot
                                                        .data!
                                                        .details![index]
                                                        .pipelineName
                                                        .toString()),
                                                    Text(snapshot
                                                        .data!
                                                        .details![index]
                                                        .stageName
                                                        .toString()),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(snapshot
                                                            .data!.timsStamp
                                                            .toString()),
                                                        Text(snapshot
                                                            .data!
                                                            .details![index]
                                                            .dealOwner
                                                            .toString()),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }));
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
        ),
      ),
    );
  }
}
