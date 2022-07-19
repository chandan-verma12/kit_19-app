import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kit_19/model/user_data.dart';
import 'package:kit_19/ui/notes/select_notification.dart';

import 'notification_item_model.dart';

class NotificationList extends StatefulWidget {
  NotificationList({Key? key}) : super(key: key);

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  Future<NotificationItem> notificationData() async {
    var url =
        "https://services.kit19.com/APPNotification/GetAPPNotificationList";
    // pass headers parameters if any
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Status": "",
        "Message": "",
        "Token": UserDetails.token,
        "Details": {"UserId": 32222, "FilterText": "", "Start": 0, "Limit": 10}
      }),
    );
    var data = jsonDecode(response.body.toString());
    // print("notes id ${data!.details![index].NoteId}");
    if (response.statusCode == 200) {
      print('url hit successful' + response.body);
      String data = response.body;

      return NotificationItem.fromJson(jsonDecode(response.body));
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
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
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.all(4),
                child: FutureBuilder<NotificationItem>(
                  future:
                      notificationData(), // here get_datacall()  can be call directly
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.details!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                // log();
                                log("data is ${snapshot.data.toString()}");
                                // print("data delete ${snapshot.data!.details![index].noteID.toString()}");

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          SelectNotification();
                                        });
                                      },
                                      child: Card(
                                        elevation: 2,
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 15),
                                          child: Column(
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CircleAvatar(
                                                      // backgroundColor: Colors.green,
                                                      backgroundImage:
                                                          Image.network(snapshot
                                                                  .data!
                                                                  .details!
                                                                  .data![index]
                                                                  .imageUrl
                                                                  .toString())
                                                              .image,
                                                      radius: 27,
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Text(
                                                          '\n' +
                                                              snapshot
                                                                  .data!
                                                                  .details!
                                                                  .data![index]
                                                                  .title
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(children: <Widget>[
                                                      Text(snapshot
                                                          .data!
                                                          .details!
                                                          .data![index]
                                                          .createdOn
                                                          .toString()
                                                          .split('T')
                                                          .first
                                                          .toString()),
                                                    ])
                                                  ]),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 54),
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .details!
                                                              .data![index]
                                                              .messageText
                                                              .toString(),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }));
                    }
                    // By default, show a loading spinner
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
