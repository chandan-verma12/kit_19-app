import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import '../../../model/source_list_model.dart';
import '../../../model/user_data.dart';
import '../../../utils/app_theme.dart';

Future<SourceListData> getenqCustomSearchCall() async {
  var url = "https://services.kit19.com/UserCRM/GetCustomSearchNameList";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"EntityName": "enquiry"}
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

    return SourceListData.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

class EnqCustomSearchDropDown extends StatefulWidget {
  const EnqCustomSearchDropDown({
    Key? key,
  }) : super(key: key);

  @override
  State<EnqCustomSearchDropDown> createState() =>
      _EnqCustomSearchDropDownState();
}

class _EnqCustomSearchDropDownState extends State<EnqCustomSearchDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (context) => FutureBuilder<SourceListData>(
          future:
              getenqCustomSearchCall(), // here get_datacall()  can be call directly
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(" show data on screen " + snapshot.data.toString());
              var len = snapshot.data!.details!.length;

              return Container(
                  height: 30,
                  child: ListView.builder(
                      itemCount: snapshot.data!.details!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(snapshot.data!.details![index].text
                                  .toString()),
                              Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        );
                      }));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return Center(
              child: Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                child: SpinKitFadingCircle(
                  color: AppTheme.white,
                  size: 34,
                ),
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: AppTheme.colorPrimary),
              ),
            );
          },
        ),
      ),
    );
  }
}

class EnqBottomsheetWidget extends StatelessWidget {
  const EnqBottomsheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              // ignore: unnecessary_const
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
          backgroundColor: Colors.white,
          context: context,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                EnqCustomSearchDropDown(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        child: Row(
          children: [
            Text(
              'All Enquiry',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),

              // overflow: TextOverflow.ellipsis,
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
