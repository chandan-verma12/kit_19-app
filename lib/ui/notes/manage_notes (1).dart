import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'get_lead_note_list.dart';

class ManageNotes extends StatefulWidget {
  ManageNotes({Key? key}) : super(key: key);

  @override
  State<ManageNotes> createState() => _ManageNotesState();
}

class _ManageNotesState extends State<ManageNotes> {
  List<NotesList>? apiList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //  if(apiList != null)
          getList()
        ],
      ),
    );
  }

  Widget getList() {
    return Expanded(
        child: ListView.builder(
            itemCount: 10, //apiList!.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Text("index ${index}"),
                    ),
                  )
                ],
              );
            }));
  }

  Future<void> getApiData() async {
    String url = 'https://services.kit19.com/UserCRM/GetLeadNoteList';

    var result = await http.post(Uri.parse(url));
    print(result.body);
    apiList = jsonDecode(result.body)
        .map((item) => NotesList.fromJson((item).toList().cast<NotesList>()));
  }
}
