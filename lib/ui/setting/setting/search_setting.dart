import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'lead_setting_model.dart';

class SearchSetting extends StatefulWidget {
  const SearchSetting({Key? key}) : super(key: key);

  @override
  State<SearchSetting> createState() => _SearchSettinState();
}

class _SearchSettinState extends State<SearchSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 26, 120, 29),
        title: const Text('Search Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              FutureBuilder<LeadSettingModel>(
                future: getSearchCall(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(" show data on screen " + snapshot.data.toString());
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Default Search',
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 124, 124),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        Text(
                          'Default Search',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'All Leads',
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 124, 124),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Sort',
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 124, 124),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Primary Sort',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'First Name, Asc',
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 124, 124),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Secondary Sort',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Email, Asc',
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 124, 124),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 124, 124),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        Text(
                          'Search by',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        Text(
                          'Full Name, Company, Email, Lead Source',
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 124, 124),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 21,
                        ),
                        Text(
                          'Display Fields',
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 124, 124),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        Text(
                          'Display Fields',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'Full Name, Email',
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 124, 124),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.green));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<LeadSettingModel> getSearchCall() async {
  var url =
      "https://services.kit19.com/EnquiryLeadSetting/SaveEnquiryLeadSetting";
  final body = {
    "Status": "",
    "Message": "",
    "Token": 637938229757172656,
    "Details": {
      "id": 1,
      "default_search": "All Enquiry",
      "primary_sort": "First Name asc",
      "secondary_sort": "Email asc",
      "search_fields": "Full Name, Company, Email, Enquiry Source",
      "platform_name": ".",
      "display_fields": "Full Name, Email",
      "entity_type": "enquiry",
      "user_id": 32222,
      "synced_at": "2022-07-11 10:00:57 PM.",
      "order_by": "asc"
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

    return LeadSettingModel.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}
