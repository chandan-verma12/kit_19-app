import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kit_19/model/enq_list_model.dart';
import '../../../model/user_data.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import 'models/delete_document.dart';
import 'models/get_document.dart';

int docId = 0;

class DocumentsList extends StatefulWidget {
  const DocumentsList({Key? key}) : super(key: key);

  get details => null;

  @override
  State<DocumentsList> createState() => _DocumentsListState();
}

class _DocumentsListState extends State<DocumentsList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentsList>(builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.separated(
          itemCount: snapshot.data!.details.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(snapshot.data!.details[4].Agent.image),
              title: Text(snapshot.data!.details[index].documents.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500)),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.calendar_view_day_sharp),
                  Text(snapshot.data!.details[index].uploadedDate.toString()),
                  Text(
                    snapshot.data!.details[index].documentName.toString(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    docId = snapshot.data!.details[index].docUpId;
                  });
                },
                child: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: const [
                          Icon(Icons.remove_red_eye_outlined),
                          SizedBox(width: 10),
                          Text('View'),
                        ],
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: const [
                          Icon(Icons.download),
                          SizedBox(width: 10),
                          Text("Download")
                        ],
                      ),
                      value: 2,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: const [
                          Icon(Icons.delete),
                          SizedBox(width: 10),
                          Text("Delete")
                        ],
                      ),
                      value: 3,
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 1) {
                      // Code to View document
                      openFile(
                          url:
                              'https://services.kit19.com/UserCRM/GetleadUploadDocument',
                          fileName: snapshot.data!.details[index].docUpId);
                    } else if (value == 2) {
                      // Code to Download document
                      openFile(
                          url:
                              'https://services.kit19.com/UserCRM/GetleadUploadDocument',
                          fileName: snapshot.data!.details[index].docUpId);
                    } else if (value == 3) {
                      SimpleDialog(
                        title: const Text(
                            'Do you really want to delete document.'),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              //Delete Document Code
                              Navigator.pop(context);
                              DeleteDocument();
                            },
                            child: const Text('Yes, I\'m Sure'),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, index) {
            return const Divider(
              height: 1,
              thickness: 2,
            );
          },
        );
      } else if (snapshot.hasError) {
        return Text("${snapshot.error}");
      }
      return const Center(
          child: Text(
        'You dont have any uploaded Documents',
        style: TextStyle(fontWeight: FontWeight.w600),
      )); // Not Final
    });
  }
}

Future<GetDocumentList> getFollowupListApiCall(int leadid) async {
  var url = "https://services.kit19.com/UserCRM/GetleadUploadDocument";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "LeadId": leadid,
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
    String data = response.body;

    return GetDocumentList.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

Future<DeleteDocument> getDeleteApiCall(int leadid) async {
  var url = "https://services.kit19.com/UserCRM/DeleteDocument";

  final body = {
    "Status": "",
    "Message": "",
    "Token": 637928010464896287,
    "Details": {"DocUpID": 83, "UserId": 32222}
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
    String data = response.body;

    return DeleteDocument.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

void viewFile(PlatformFile file) {
  OpenFile.open(file.path);
}

Future openFile({required String url, String? fileName}) async {
  await downloadFile(url, fileName!);
}

Future<File?> downloadFile(String url, String name) async {
  final appStorage = await getApplicationDocumentsDirectory();

//  final file = File('${appStorage.path}/$name');

  final response = await Dio().get(url);
}
