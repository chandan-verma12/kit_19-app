import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kit_19/ui/notes/update_notification_status_model.dart';
import '../../model/user_data.dart';
import '../../utils/app_theme.dart';
import 'notification_item_model.dart';

class SelectNotification extends StatefulWidget {
  @override
  State<SelectNotification> createState() => _SelectNotificationState();
}

class _SelectNotificationState extends State<SelectNotification> {
  var _count = 0;
  final allChecked = CheckBoxModal(title: 'select all');
  final checkBoxList = [
    CheckBoxModal(title: ' select 1'),
    CheckBoxModal(title: 'select 2 '),
  ];

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
        "Details": {
          "UserId": UserDetails.userId,
          "FilterText": "",
          "Start": 0,
          "Limit": 10
        }
      }),
    );
    var data = jsonDecode(response.body.toString());
    // print("notes id ${data!.details![index].NoteId}");
    if (response.statusCode == 200) {
      print('url hit successful' + response.body);
      String data = response.body;

      var dataList = NotificationItem.fromJson(jsonDecode(response.body));
      return dataList;
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
  }

  Future<UpdateNotificationStatus> updatenotificationData() async {
    var url =
        "https://services.kit19.com/APPNotification/UpdateAPPNotificationStatus";
    // pass headers parameters if any
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Status": "",
        "Message": "",
        "Token": UserDetails.token,
        "Details": {
          "UserId": 32222,
          "BatchNotification_Id": "1,2",
          "StatusType": "Read"
        }
      }),
    );
    var data = jsonDecode(response.body.toString());
    // print("notes id ${data!.details![index].NoteId}");
    if (response.statusCode == 200) {
      print('url hit successful' + response.body);
      String data = response.body;

      var dataList =
          UpdateNotificationStatus.fromJson(jsonDecode(response.body));
      return dataList;
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
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
        title: const Text('Notification'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: FutureBuilder<NotificationItem>(
                future:
                    notificationData(), // here get_datacall()  can be call directly
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var len = snapshot.data!.details!.data!.length;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(
                                      "assets/icons/cancel-icon.png",
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    '$_count',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => onAllClicked(allChecked),
                                    icon: Checkbox(
                                      value: allChecked.value,
                                      onChanged: (value) => setState(() {
                                        onAllClicked(allChecked);
                                        countItem();
                                        //  _count++;
                                      }),
                                    ),
                                  ),
                                  Text(
                                    'Select All',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      RaisedButton(
                                          onPressed: () {
                                            setState(() {
                                              allChecked;
                                              checkBoxList;
                                              onAllClicked;
                                              onItemClicked;
                                            });
                                            log(allChecked.toString());
                                          },
                                          child: Text(
                                            'Mark all as Read',
                                            style:
                                                TextStyle(color: Colors.green),
                                          )),
                                      // IconButton(onPressed: (){},
                                      //  icon: Icon(Icons.delete), color: Colors.red,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        for (var i = 0; i < len; i++) ...[
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          ...checkBoxList
                              .map(
                                (item) => ListTile(
                                  onTap: () => onItemClicked(item),
                                  title: Text(snapshot
                                      .data!.details!.data![i].title
                                      .toString()),
                                  leading: Checkbox(
                                    value: item.value,
                                    onChanged: (value) => setState(() {
                                      onItemClicked(item);
                                      //  countItem();
                                      _count++;
                                    }),
                                  ),

                                  //   CircleAvatar(backgroundImage: Image.network(snapshot.data!.details!.data![index].imageUrl.toString()).image),
                                  trailing: Text(snapshot
                                      .data!.details!.data![i].createdOn
                                      .toString()
                                      .split('T')
                                      .first),
                                  subtitle: Text(snapshot
                                      .data!.details!.data![i].messageText
                                      .toString()),
                                  // Checkbox(
                                  //     value: item.value,
                                  //     onChanged: (value) => onItemClicked(item),
                                  //   ),
                                ),
                              )
                              .toList()
                        ]
                      ],
                    );
                    //               return
                    //                    ListView.builder(
                    //                       itemCount: snapshot.data!.details!.data!.length,
                    //                       itemBuilder: (BuildContext context, int index) {
                    //                         return Column(
                    //                           children: [

                    //                             Divider(),
                    //                        ...checkBoxList.map((item) =>
                    //                               ListTile(
                    //                                 // onLongPress: () => Checkbox(
                    //                                 //   value: item.value,
                    //                                 //   onChanged: (value) => onItemClicked(item),
                    //                                 // ),
                    //                                 onTap: () => onItemClicked(item),
                    //                                   title:  Text(snapshot.data!.details!.data![index].title.toString())
                    // ,
                    //                                 leading:
                    //                                 Checkbox(
                    //                                   value: item.value,
                    //                                   onChanged: (value) => onItemClicked(item),
                    //                                 ) ,
                    //                              //   CircleAvatar(backgroundImage: Image.network(snapshot.data!.details!.data![index].imageUrl.toString()).image),
                    //                                trailing: Text(snapshot.data!.details!.data![index].createdOn.toString().split('T').first),
                    //                               subtitle: Text(snapshot.data!.details!.data![index].messageText.toString()),
                    //                               // Checkbox(
                    //                               //     value: item.value,
                    //                               //     onChanged: (value) => onItemClicked(item),
                    //                               //   ),

                    //                               ),
                    //                               ).toList()

                    //                           ],
                    //                         );

                    //                       });
                  }
                  //       // By default, show a loading spinner
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  onAllClicked(CheckBoxModal ckbItem) {
    final newValue = !ckbItem.value;
    setState(() {
      ckbItem.value = newValue;
      checkBoxList.forEach((element) {
        element.value = newValue;
      });
    });
  }

  onItemClicked(CheckBoxModal ckbItem) {
    final newValue = !ckbItem.value;
    var count = 0;
    setState(() {
      ckbItem.value = newValue;
      if (!newValue) {
        allChecked.value = false;
      } else {
        final allListChecked = checkBoxList.every((element) => element.value);
        allChecked.value = allListChecked;
        //  _count = count++;

      }
    });
  }

  int countItem() {
    var _count = 0;
    setState(() {
      _count != 0 ? _count-- : _count++;
    });
    return _count;
  }
}

class CheckBoxModal {
  String title;
  bool value;
  CheckBoxModal({required this.title, this.value = false});
}

//   ListTile(
//                                         onTap: () => onAllClicked(allChecked),
//                                           title:  Text(allChecked.title),

// leading: Checkbox(
//                                           value: allChecked.value,
//                                           onChanged: (value) => onAllClicked(allChecked),
//                                         ),
//                                         //CircleAvatar(backgroundImage: Image.network(snapshot.data!.details!.data![index].imageUrl.toString()).image),
//                                     //   trailing: Text(snapshot.data!.details!.data![index].createdOn.toString().split('T').first),
//                                     //  subtitle: Text(snapshot.data!.details!.data![index].messageText.toString()),

//                                       ),

//                                       Divider(),

// ...checkBoxList.map((item) =>
//                                       ListTile(
//                                         onTap: () => onAllClicked(item),
//                                           title:  Text(snapshot.data!.details!.data![index].title.toString())
//             ,
//                                         leading: Checkbox(
//                                           value: allChecked.value,
//                                           onChanged: (value) => onAllClicked(item),
//                                         ),
//                                         //CircleAvatar(backgroundImage: Image.network(snapshot.data!.details!.data![index].imageUrl.toString()).image),
//                                        trailing: Text(snapshot.data!.details!.data![index].createdOn.toString().split('T').first),
//                                       subtitle: Text(snapshot.data!.details!.data![index].messageText.toString()),

//                                       ),
//                                       ).toList()
