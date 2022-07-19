// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kit_19/model/user_data.dart';
import 'package:kit_19/ui/TaskFile/search_widget.dart';
import '../../model/LeadModel.dart';
import 'merge_lead_to_lead.dart';
import 'models/search_lead_by_id.dart';

class SearchLead extends StatefulWidget {
  const SearchLead({Key? key}) : super(key: key);

  @override
  State<SearchLead> createState() => _SearchLeadState();
}

class _SearchLeadState extends State<SearchLead> {
  var _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 15, 119, 19),
          title: const Text(
            'Merge Lead to Lead',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            buildSearch(),
            FutureBuilder(
              future: getSearchCall(_textController),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // print(" show data on screen " + snapshot.data.toString());
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MergeDetailPage(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'snapshot.data!.Details.data.PersonName.toString()',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                    'snapshot.data!.Details.data.MobileNo.toString()',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12)),
                                Text(
                                    'snapshot.data!.Details.data.EmailID.toString()',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Text('');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: 'query',
        hintText: 'Search Lead by Name & Lead No.',
        onChanged: SearchLeadBy,
      );

  void SearchLeadBy(String query) async {
    var leads = await getSearchCall(_textController);

    setState(() {
      leads = _textController as SearchLeadById;
    });
  }
}

Future<SearchLeadById> getSearchCall(_textController) async {
  var url = "https://services.kit19.com/UserCRM/GetLeadDetailsSearch";
  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "UserId": UserDetails.userId,
      "CustomSearchId": 0,
      "PredefinedSearchId": 0,
      "FilterText": '',
      "SearchFieldType": "default"
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

    return SearchLeadById.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}
