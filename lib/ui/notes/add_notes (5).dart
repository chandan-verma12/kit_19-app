import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kit_19/model/user_data.dart';

class AddNotesPage extends StatefulWidget {
  AddNotesPage({Key? key}) : super(key: key);

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  var inputFieldController = TextEditingController();

  void addNotesData(String inputFieldController) async {
    var body = {
      "Status": "",
      "Message": "",
      "Token": UserDetails.token,
      "Details": {
        "LeadId": 327780,
        "Notes": "This is my first noted parent and userid check",
        "UserId": UserDetails.userId
      }
    };

    Response response = await post(
        Uri.parse('https://services.kit19.com/UserCRM/InsertUpdateLeadNotes'),
        body: jsonEncode(body),
        headers: {"Content-type": "application/json"});
    log(response.toString());

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data.toString());
      print('added successfully');
    } else {
      log("Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add notes",
          style: TextStyle(fontSize: 22),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        backgroundColor: Color.fromARGB(255, 4, 180, 9),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 28),
                child: TextFormField(
                  controller: inputFieldController,
                  minLines: 5,
                  decoration: InputDecoration(
                    hintText: "Type anything",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  maxLines: 50,
                  maxLength: 2000,
                ),
              ),
              // SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 16, top: 0),
                child: Text(
                  "2000 characters left",
                  textAlign: TextAlign.right,
                ),
              ),

              SizedBox(
                height: 387,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () {
                      addNotesData(inputFieldController.text.toString());
                      log(inputFieldController.text.toString());
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
