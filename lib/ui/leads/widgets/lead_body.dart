// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kit_19/model/LeadModel.dart';
import 'package:http/http.dart' as http;
import 'package:kit_19/model/user_data.dart';
import 'package:kit_19/ui/leads/lead_details/lead_widgets.dart';
import 'package:kit_19/ui/leads/widgets/lead_info.dart';

import 'custom_drop_down.dart';

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
                      // initiallly get_prodModellist is empty so you will see a progreessbar on screen
                      // OR
                      // you can directly call the get_datacall() function here to automatically get
                      // data from sever and show on UI
                      future:
                          get_prodModellist, // here get_datacall()  can be call directly
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
                                children: const [
                                  CustomDropDown(),
                                  Icon(Icons.map),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              for (var i = 0; i < len; i++) ...[
                                GestureDetector(
                                  onTap: () {
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
                                  },
                                  child: LeadInfo(
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
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        // By default, show a loading spinner
                        return const Center(child: CircularProgressIndicator());
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
  //get_prodlist
  // To display the data on screen, use the FutureBuilder widget.
  // The FutureBuilder widget comes with Flutter and makes it easy to work with asynchronous data sources
  // The Future you want to work with. In this case, the future returned from the  getProdCall() function.
  //A builder function that tells Flutter what to render, depending on the state of the Future: loading, success, or error.
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
