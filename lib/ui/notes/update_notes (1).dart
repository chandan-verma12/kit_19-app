import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kit_19/model/lead_data.dart';
import 'package:kit_19/model/user_data.dart';
import 'package:kit_19/ui/leads/lead_common_data.dart';

class UpdateNotes extends StatefulWidget {
  UpdateNotes({Key? key}) : super(key: key);

  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  var inputFieldController = TextEditingController();

  void UpdateNotesData(String inputFieldController) async {
    var body = {
      "Status": "",
      "Message": "",
      "Token": UserDetails.token,
      "Details": {
        "LeadId": LeadDetailsCommon.leadidcommon,
        "Notes": "This is my first noted parent and userid check",
        "UserId": 32222
      }
    };

    Response response = await post(
        Uri.parse('https://services.kit19.com/UserCRM/InsertUpdateLeadNotes'),
        body: jsonEncode(body),
        headers: {"Content-type": "application/json"});
    log(response.toString());

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data['token']);
      print('added successfully');
    } else {
      log("Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add notes"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        backgroundColor: Color.fromARGB(255, 4, 180, 9),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: inputFieldController,
                  decoration: InputDecoration(
                    hintText: "Type anything",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  maxLines: 10,
                ),
                SizedBox(height: 10),
                Text(
                  "2000 characters left",
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 285,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {
                        UpdateNotesData(inputFieldController.text.toString());
                      },
                      child: Text("Update")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
