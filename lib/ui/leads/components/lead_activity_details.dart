import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:kit_19/model/user_data.dart';

import '../../../utils/app_theme.dart';
import 'get_activity_list_by_lead.dart';

class LeadActivityDetails extends StatefulWidget {
  LeadActivityDetails({Key? key}) : super(key: key);

  @override
  State<LeadActivityDetails> createState() => _LeadActivityDetailsState();
}

class _LeadActivityDetailsState extends State<LeadActivityDetails> {
  Future<GetActivityListByLead> itemPipelineList() async {
    var url = "https://services.kit19.com/UserCRM/GetActivityListByLeadId";
    // pass headers parameters if any
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Status": "",
        "Message": "",
        "Token": UserDetails.token,
        "Details": {"LeadId": 230884}
      }),
    );
    var data = jsonDecode(response.body.toString());
    // print("notes id ${data!.details![index].NoteId}");
    if (response.statusCode == 200) {
      print('url hit successful' + response.body);
// return AddDeal.fromJson(jsonDecode(response.body));
      return GetActivityListByLead.fromJson(jsonDecode(response.body));
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
  }

  int _currentIndex = 0;
  List _screens = [
    LeadActivityDetails(),
    LeadActivityDetails(),
    LeadActivityDetails(),
    LeadActivityDetails(),

    //  SearchPage(),
    // CategoryPage()
    // AccountPage()
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lead"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
              )),
        ],
        backgroundColor: Color.fromARGB(246, 5, 244, 84),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 14),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text(
                        'Basic Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w100),
                      ),
                      Text(
                        'Full Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w100),
                      ),
                      Text(
                        'Activity Details',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(246, 5, 244, 84),
                            fontWeight: FontWeight.w100),
                      ),
                    ]),
                Container(
                  padding: EdgeInsets.only(top: 4, left: 3, right: 3),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Deal History',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w100)),
                          Icon(Icons.keyboard_arrow_up),
                        ],
                      ),
                    ),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  height: 200,
                  alignment: Alignment.center,
                  child: FutureBuilder<GetActivityListByLead>(
                      future: itemPipelineList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(" show data on screen " +
                              snapshot.data.toString());
                          var len = snapshot.data!.details!.table!.length;

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0; i < len; i++) ...[
                                Text(snapshot
                                    .data!.details!.table![i].pipelineID
                                    .toString())
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
                      }

                      // return ListView.builder(
                      //     itemCount: snapshot.data!.details!.table!.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Card(
                      //         child: Column(
                      //           crossAxisAlignment:
                      //               CrossAxisAlignment.stretch,
                      //           children: [
                      //             Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text(
                      //                     snapshot.data!.details!
                      //                         .table![index].pipeLineName
                      //                         .toString(),
                      //                     style: TextStyle(
                      //                       fontSize: 17,
                      //                       fontWeight: FontWeight.bold,
                      //                     )),
                      //                 Container(
                      //                   child:
                      //                       CircularProgressIndicator(), //center text, you can set Icon as well
                      //                 )
                      //               ],
                      //             ),
                      //             Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Padding(
                      //                   padding: const EdgeInsets.all(5.0),
                      //                   child: Row(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.spaceAround,
                      //                     children: [
                      //                       CircleAvatar(
                      //                         backgroundColor: Colors.blue,
                      //                         radius: 12,
                      //                       ),
                      //                       Text(snapshot.data!.details!
                      //                           .table![index].amount
                      //                           .toString()),
                      //                       Text(snapshot
                      //                           .data!
                      //                           .details!
                      //                           .table![index]
                      //                           .profileImgFileName
                      //                           .toString()),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Text(snapshot.data!.details!
                      //                     .table![index].leadPipeLineMappingId
                      //                     .toString())
                      //               ],
                      //             ),
                      //             Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text('Estimated Closure date : ' +
                      //                     snapshot.data!.timsStamp
                      //                         .toString()
                      //                         .split(' ')
                      //                         .first),
                      //                 Text(snapshot.data!.details!
                      //                     .table![index].estimatedClosureDate
                      //                     .toString())
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     });

                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _updateIndex,
        selectedItemColor: Colors.amber,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.mail_lock_outlined),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.security_outlined),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.mic),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.phone),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.whatsapp_outlined),
          ),
        ],
        backgroundColor: Color.fromARGB(196, 2, 250, 6),
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
