// ignore_for_file: unused_local_variable, avoid_print, sized_box_for_whitespace
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../model/user_data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadDocuments extends StatefulWidget {
  UploadDocuments({Key? key}) : super(key: key);

  @override
  State<UploadDocuments> createState() => _UploadDocumentsStates();
}

class _UploadDocumentsStates extends State<UploadDocuments> {
  int sizeInMb = 9;

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      'bmp',
      'csv',
      'doc',
      'docx',
      'gif',
      'jpeg',
      'jpg',
      'pdf',
      'png',
      'ppt',
      'pptx',
      'txt',
      'xls',
      'xlsx'
    ]);
    if (result != null) {
      PlatformFile? file = result.files.first;
      print(file.size);
      int size = file.size;
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Add Documents'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          DottedBorder(
            strokeWidth: 2,
            dashPattern: [10, 10],
            child: Container(
              child: GestureDetector(
                onTap: () {
                  pickFile();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_upload_outlined,
                      color: Colors.black,
                      size: 104,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'Click here to Browse your \n files to Upload',
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Max File Size 10MB',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          DottedBorder(
            strokeWidth: 1,
            dashPattern: const [10, 10],
            child: Container(
              height: 150,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Supported File Type',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        '.pdf, .bmp, .png, .docx, .docx, .gif, .jpeg, .jpg, .pdf, /n .png, .ppt, .pptx, .txt, .xlx, .xlsx'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          if (sizeInMb < 10) {
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Max upload file size is 10MB!'),
            );
          } else {
            _upload(FilePickerResult);
          }
        },
        child: const Text('SAVE'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return const Color.fromARGB(255, 9, 146, 14);
          }),
        ),
      ),
    );
  }

  Future _upload(file) async {
    var url = 'https://services.kit19.com/UserCRM/UploadLeadDocument';
    final body = {
      "Status": "",
      "Message": "",
      "Token": UserDetails.token,
      "fileUpload": {
        "ParentId": UserDetails.parentID,
        "CreatedBy": UserDetails.userId,
        "LeadId": "327780",
      }
    };

    String fileName = file.path.split('/').last;

    print(fileName);

    Dio dio = Dio();

    dio.post(url, data: body).then((response) {
      var jsonResponse = jsonDecode(response.toString());
      var testData = jsonResponse['histogram_counts'].cast<double>();
      var averageGrindSize = jsonResponse['average_particle_size'];
    }).catchError((error) => print(error));
  }
}
