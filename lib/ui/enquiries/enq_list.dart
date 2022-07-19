import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;
import 'package:kit_19/model/enq_list_model.dart';
import 'package:kit_19/model/enquiry_details.dart';
import 'package:kit_19/model/user_data.dart';
import 'package:kit_19/ui/enquiries/components/custom_drop_down.dart';
import 'package:kit_19/ui/enquiries/enq_full_details.dart';
import 'package:kit_19/ui/enquiries/enq_list_widget.dart';

import '../../utils/app_theme.dart';

class EnquiryListAPi extends StatefulWidget {
  _EnquiryListApi createState() => _EnquiryListApi();
}

class _EnquiryListApi extends State<EnquiryListAPi> {
  Future<EnquiryListModel> get_prodModellist = _getDatacall();
  int index = 0;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Builder(
            builder: (context) => Container(
              padding: EdgeInsets.all(15.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: FutureBuilder<EnquiryListModel>(
                      future: get_prodModellist,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var len = snapshot.data!.details!.data!.length;

                          print(" show data on screen " +
                              snapshot.data!.details!.data![0].enquiryId
                                  .toString());
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  EnqBottomsheetWidget(),
                                  // Icon(Icons.map),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              for (var i = 0; i < len; i++) ...[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            EnquiryFullDetails(
                                          id: snapshot.data!.details!.data![i]
                                              .enquiryId!
                                              .toInt(),
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      EnquiryDetails.enqid = snapshot
                                          .data!.details!.data![i].enquiryId!
                                          .toInt();
                                    });
                                  },
                                  child: EnquiryList(
                                    name: snapshot
                                        .data!.details!.data![i].personName
                                        .toString(),
                                    phno: snapshot
                                        .data!.details!.data![i].csvMobileNo
                                        .toString(),
                                    email: snapshot
                                        .data!.details!.data![i].csvEmailId
                                        .toString(),
                                    datetime: snapshot
                                        .data!.details!.data![i].createdDate
                                        .toString(),
                                    propic: snapshot
                                        .data!.details!.data![i].image
                                        .toString(),
                                    remarks: snapshot
                                        .data!.details!.data![i].initialRemarks
                                        .toString(),
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                              ],
                            ],
                          );
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                color: AppTheme.colorPrimary),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<EnquiryListModel> _getDatacall() {
  print(" get data using http");
  // call servicewrapper function
  servicewrapper wrapper = servicewrapper();
  return wrapper.getProdCall();
  //get_prodlist
  // To display the data on screen, use the FutureBuilder widget.
  // The FutureBuilder widget comes with Flutter and makes it easy to work with asynchronous data sources
  // The Future you want to work with. In this case, the future returned from the  getProdCall() function.
  //A builder function that tells Flutter what to render, depending on the state of the Future: loading, success, or error.
}

class servicewrapper {
  Future<EnquiryListModel> getProdCall() async {
    var url = "https://services.kit19.com/UserCRM/GetEnquiryList";
    final body = {
      "Status": "",
      "Message": "",
      "Token": UserDetails.token,
      "Details": {
        "UserId": UserDetails.userId,
        "CustomSearchId": 0,
        "PredefinedSearchId": 0,
        "FilterText": "",
        "Start": 0,
        "Limit": 100
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

      return EnquiryListModel.fromJson(json.decode(response.body));
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
  }
}
