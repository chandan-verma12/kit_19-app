import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kit_19/model/custom_fields_model.dart';
import 'package:kit_19/model/user_data.dart';
import 'package:http/http.dart' as http;

import '../../../utils/app_theme.dart';

class CustomFormFields extends StatefulWidget {
  const CustomFormFields({Key? key}) : super(key: key);

  @override
  State<CustomFormFields> createState() => _CustomFormFieldsState();
}

class _CustomFormFieldsState extends State<CustomFormFields> {
  Future<CustomFeildsModel> get_CustomFieldModellist = getCustomFieldProdCall();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(children: [
          Builder(
            builder: (context) => Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: FutureBuilder<CustomFeildsModel>(
                      // initiallly get_prodModellist is empty so you will see a progreessbar on screen
                      // OR
                      // you can directly call the get_datacall() function here to automatically get
                      // data from sever and show on UI
                      future:
                          get_CustomFieldModellist, // here get_datacall()  can be call directly
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var len = snapshot.data!.details!.length;
                          print(" show data on screen " +
                              snapshot.data!.details![0].displayName
                                  .toString());
                          return Column(
                            children: [
                              for (var i = 0; i < len; i++) ...[
                                if (snapshot.data!.details![i].isVisible ==
                                    false) ...[
                                  Container(),
                                ] else ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        hintText: snapshot
                                            .data!.details![i].displayName
                                            .toString(),
                                        labelText: snapshot
                                            .data!.details![i].displayName
                                            .toString(),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
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
        ]),
      ),
    );
  }
}

// Future<CustomFeildsModel> _getCustomFieldDatacall() {
//   print(" get data using http");
//   // call servicewrapper function
//   servicewrapper wrapper = servicewrapper();
//   return wrapper.getCustomFieldProdCall();
//   //get_prodlist
//   // To display the data on screen, use the FutureBuilder widget.
//   // The FutureBuilder widget comes with Flutter and makes it easy to work with asynchronous data sources
//   // The Future you want to work with. In this case, the future returned from the  getProdCall() function.
//   //A builder function that tells Flutter what to render, depending on the state of the Future: loading, success, or error.
// }

Future<CustomFeildsModel> getCustomFieldProdCall() async {
  var url = "https://services.kit19.com/Common/GetFormMetaData";
  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "UserId": UserDetails.userId,
      "Mode": "Lead",
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

    return CustomFeildsModel.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}
