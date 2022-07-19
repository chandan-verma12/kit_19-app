import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kit_19/model/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:kit_19/ui/leads/lead_common_data.dart';

import 'delete_notes (1).dart';
import 'get_lead_note_list.dart';

int notid = 0;

class Notes_List extends StatefulWidget {
  const Notes_List({Key? key}) : super(key: key);

  @override
  State<Notes_List> createState() => _Notes_ListState();
}

class _Notes_ListState extends State<Notes_List> {
  Future<DeleteNotes> deleteAlbum(String nid) async {
    print("delete called");
    print("the data is nid $notid");
    final http.Response response = await http.delete(
        Uri.parse('https://services.kit19.com/UserCRM/DeleteNotes/$nid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "Status": "",
          "Message": "",
          "Token": 637928010464896287,
          "Details": {"noteid": notid, "UserId": "32222"}
        }));
    log(jsonDecode(response.body));
    if (response.statusCode == 200) {
      postApiData();
      return DeleteNotes();
    } else {
      throw Exception('Failed to delete album.');
    }
  }

  Future<NotesList> postApiData() async {
    var url = "https://services.kit19.com/UserCRM/GetLeadNoteList";
    // pass headers parameters if any
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        //       "Status": "",
        // "Message": "",
        // "Token": UserDetails.token,
        // "Details": {
        //     "LeadId": LeadDetailsCommon.leadidcommon,
        //     "ParentID": UserDetails.parentID
        // }
        "Status": "",
        "Message": "",
        "Token": UserDetails.token, //637928010464896287
        "Details": {
          "LeadId": LeadDetailsCommon.leadidcommon,
          "ParentID": //UserDetails.parentID
              UserDetails.parentID
        }
      }),
    );
    var data = jsonDecode(response.body.toString());
    // print("notes id ${data!.details![index].NoteId}");
    if (response.statusCode == 200) {
      print('url hit successful' + response.body);
      String data = response.body;

      return NotesList.fromJson(jsonDecode(response.body));
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // log(notesList.isEmpty.toString());
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.all(4),
                child: FutureBuilder<NotesList>(
                  future:
                      postApiData(), // here get_datacall()  can be call directly
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.details!.length,
                              itemBuilder: (BuildContext context, int index) {
                                // log();
                                log("data is ${snapshot.data!.details![index].noteId}");
                                // print("data delete ${snapshot.data!.details![index].noteID.toString()}");

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      elevation: 2,
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24, horizontal: 5),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    '\n' +
                                                        snapshot
                                                            .data!
                                                            .details![index]
                                                            .notes
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      notid = snapshot
                                                          .data!
                                                          .details![index]
                                                          .noteId!
                                                          .toInt();
                                                    });
                                                    setState(() {});
                                                  },
                                                  child: DropdownButton(
                                                      icon: Icon(
                                                        Icons.more_vert,
                                                        color: Theme.of(context)
                                                            .primaryIconTheme
                                                            .color,
                                                      ),
                                                      items: [
                                                        DropdownMenuItem(
                                                          child: Container(
                                                            height: 400,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                //Row(
                                                                //children: <
                                                                //  Widget>[
                                                                // IconButton(
                                                                //     onPressed:
                                                                //         () {},
                                                                //     icon:
                                                                //         Icon(
                                                                //       Icons
                                                                //           .file_download_outlined,
                                                                //       color:
                                                                //           Colors.black,
                                                                //     )),
                                                                // Text(
                                                                //   'Download',
                                                                //   style: TextStyle(
                                                                //       fontSize:
                                                                //           11),
                                                                // )
                                                                //  ],
                                                                // ),
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          notid = snapshot
                                                                              .data!
                                                                              .details![index]
                                                                              .noteId!
                                                                              .toInt();
                                                                        });
                                                                        deleteAlbum(snapshot
                                                                            .data!
                                                                            .details![index]
                                                                            .noteId
                                                                            .toString());
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .delete_forever,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            95,
                                                                            78,
                                                                            78),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            0),
                                                                    Text(
                                                                      'Delete',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          value: 'delete',
                                                        ),
                                                      ],
                                                      onChanged:
                                                          (itemIdentifier) {
                                                        //   if (itemIdentifier == 'logout') {
                                                        //     FirebaseAuth.instance.signOut();
                                                      }
                                                      // },
                                                      ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(snapshot.data!
                                                    .details![index].createdDate
                                                    .toString()),
                                                Text('username : ' +
                                                    snapshot
                                                        .data!
                                                        .details![index]
                                                        .agent!
                                                        .userName
                                                        .toString()),
                                              ],
                                            ),
                                          ],
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

//   Widget reusableFuture(String id){

    
//   FutureBuilder<DeleteNotes>(
//             future: _futureAlbum,
//             builder: (context, snapshot) {
//               // If the connection is done,
//               // check for response data or an error.
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasData) {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       );
//                 } else if (snapshot.hasError) {
//                   return Text('${snapshot.error}');
//                 }
// }

//               // By default, show a loading spinner.
//               return Text('loading');
//             },
//           ),
        

//   }

