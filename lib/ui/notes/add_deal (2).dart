import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:kit_19/model/user_data.dart';
import 'package:kit_19/ui/leads/lead_common_data.dart';

import '../../utils/app_theme.dart';
import 'deal_list_pipeline_model.dart';
import 'deal_list_stage_model.dart';

class AddDeal extends StatefulWidget {
  AddDeal({Key? key}) : super(key: key);

  @override
  State<AddDeal> createState() => _AddDealState();
}

class _AddDealState extends State<AddDeal> {
  TextEditingController dealValue = TextEditingController();
  TextEditingController probability = TextEditingController();

  bool showDate = false;
  String _selectedPipeline = '';
  String _selectedStage = '';
  String _selectedSaleOwner = '';

  void addDealData(
    String dealValue,
    String dealPipeline,
    String dealStage,
    String probability,
    String salesOwner,
    String closerDate,
  ) async {
    var body = {
      "Status": "",
      "Message": "",
      "Token": UserDetails.token,
      "Details": {
        "LeadId": LeadDetailsCommon.leadidcommon,
        "PipelineId": 15,
        "PipelineStage": 102,
        "Amount": 2000,
        "ClosureDate": "27-May-2022",
        "DealOwner": 32222,
        "Probability": 100.0,
        "UserId": UserDetails.userId
      }
    };

    Response response = await http.post(
        Uri.parse('https://services.kit19.com/UserCRM/SaveDealData'),
        body: jsonEncode(body),
        headers: {"Content-type": "application/json"});
    log(response.toString());

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      print('save successfully');
    } else {
      log("Failed");
    }
  }

  Future<DealListPipeline> itemPipelineList() async {
    var url = "https://services.kit19.com/UserCRM/GetDealPipeline";
    // pass headers parameters if any
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Status": "",
        "Message": "",
        "Token": UserDetails.token,
        "Details": 32222
      }),
    );
    var data = jsonDecode(response.body.toString());
    // print("notes id ${data!.details![index].NoteId}");
    if (response.statusCode == 200) {
      print('url hit successful' + response.body);
// return AddDeal.fromJson(jsonDecode(response.body));
      return DealListPipeline.fromJson(jsonDecode(response.body));
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
  }

  Future<DealListStage> itemStageList() async {
    var url = "https://services.kit19.com/UserCRM/GetDealPipelineStage";
    // pass headers parameters if any
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Status": "",
        "Message": "",
        "Token": UserDetails.token,
        "Details": 15
      }),
    );
    var data = jsonDecode(response.body.toString());
    // print("notes id ${data!.details![index].NoteId}");
    if (response.statusCode == 200) {
      print('url hit successful' + response.body);
// return AddDeal.fromJson(jsonDecode(response.body));
      return DealListStage.fromJson(jsonDecode(response.body));
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colorPrimary,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Add Deals'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: dealValue,
                  decoration: InputDecoration(
                    // labelText: 'Deal Value ',//labelStyle: TextStyle(color: Colors.black, ),
                    // border: OutlineInputBorder(),
                    hintText: 'Enter deal value',
                  ),
                ),

                SizedBox(
                  height: 40,
                ),

//pipeline button
                RaisedButton(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_selectedPipeline.isEmpty)
                        const Text(
                          'select deal pipeline',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w200),
                        )
                      else
                        Text('$_selectedPipeline'),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                  onPressed: () => pipelineShowModal(context),
                ),

                SizedBox(
                  height: 40,
                ),

//deal stage
                RaisedButton(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_selectedStage.isEmpty)
                        const Text(
                          'select deal stage',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w200),
                        )
                      else
                        Text('$_selectedStage'),
                      const Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                  onPressed: () => stageShowModal(context),
                ),

                SizedBox(
                  height: 30,
                ),

                //probability
                TextField(
                  controller: probability,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText:
                        'Probability (%) ', //labelStyle: TextStyle(color: Colors.black, ),
                    // border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),

//sales owner
//  RaisedButton(
//   color: Colors.white,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if(_selectedSaleOwner.isEmpty)
//                 const Text('select sales owner', style: TextStyle(
//                   fontSize: 16, color: Colors.black54,
//                  fontWeight: FontWeight.w200),)
//                 else
//               Text('$_selectedSaleOwner'),

//                 const Icon(Icons.keyboard_arrow_down)
//               ],
//             ),
//             onPressed: () => saleOwnerShowModal(context, _saleOwner, _selectedSaleOwner  ),
//           ),

                SizedBox(
                  height: 40,
                ),

                //Estimated closer date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      onPressed: _presentDatePicker,
                      child: Text('select closure date'),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                    Text(
                      DateFormat('dd MMMM yyyy').format(_selectedDate),
                    ), //DateFormat('MMMM yyyy').format(_selectedDate),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 90,
                        bottom: 0,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              addDealData(
                                  dealValue.text.toString(),
                                  _selectedPipeline,
                                  _selectedStage,
                                  probability.text.toString(),
                                  _selectedSaleOwner,
                                  _selectedDate.toIso8601String());
                              print(_selectedStage +
                                  ' ' +
                                  dealValue.text.toString() +
                                  ' ' +
                                  probability.text);
                              log(_selectedPipeline +
                                  ' ' +
                                  _selectedDate.toString());
                            },
                            child: Text("Save")),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pipelineShowModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(8),
            height: 200,
            alignment: Alignment.center,
            child: FutureBuilder<DealListPipeline>(
                future: itemPipelineList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(" show data on screen " + snapshot.data.toString());
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.details!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Text(snapshot.data!.details![index].text
                                      .toString()),
                                  Divider(
                                    // height: 1,
                                    thickness: 1,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _selectedPipeline = snapshot
                                    .data!.details![index].text
                                    .toString();
                              });

                              Navigator.of(context).pop();
                            });
                        // return Divider(height: 16, color: Colors.black, );
                      });
                }),
          );
        });
  }

  void stageShowModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                height: 300,
                alignment: Alignment.center,
                child: FutureBuilder<DealListStage>(
                    future: itemStageList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(
                            " show data on screen " + snapshot.data.toString());
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else {
                        Text('Loading..');
                      }
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.details?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Text(snapshot.data!.details![index].name
                                            .toString()),
                                        Divider(
                                          // height: 1,
                                          thickness: 1,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedStage = snapshot
                                          .data!.details![index].name
                                          .toString();
                                    });
                                    Navigator.of(context).pop();
                                  });
                            }),
                      );
                    }),
              ),
            ],
          );
        });
  }

// void saleOwnerShowModal(context, List array, String _seletedSalesOwner  ){
//     showModalBottomSheet(
//       context: context,
//       builder: (context ){
//         return Container(
//           padding: const EdgeInsets.all(8),
//           height: 500,
//           alignment: Alignment.center,
//        child: FutureBuilder<DealDetailList>(
//             future: dealDetailList(),
//             builder: (context, snapshot ){
//               return ListView.builder(
//                 itemCount: snapshot.data?.details!.length,
//                 itemBuilder: (BuildContext context, int index){
//                return GestureDetector(
//                 child: Text(snapshot.data!.details![index].dealOwner.toString()),
//                 onTap: () {
//                   setState(() {
//                     _selectedPipeline = snapshot.data!.details![index].dealOwner.toString();
//                   });
//                   Navigator.of(context).pop();
//                 }
//               );
//                 });
//             }),
//         );
//       }
//     );
//   }
  DateTime _selectedDate = DateTime.now();
  int _selectedIndex = 0;
  late int indexOfFirstDayMonth;

  @override
  void initState() {
    super.initState();
    indexOfFirstDayMonth = getIndexOfFirstDayInMonth(_selectedDate);
    setState(() {
      _selectedIndex = indexOfFirstDayMonth +
          int.parse(DateFormat('d').format(DateTime.now())) -
          1;
    });
  }

  List<int> listOfDatesInMonth(DateTime currentDate) {
    var selectedMonthFirstDay =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    var nextMonthFirstDay = DateTime(selectedMonthFirstDay.year,
        selectedMonthFirstDay.month + 1, selectedMonthFirstDay.day);
    var totalDays = nextMonthFirstDay.difference(selectedMonthFirstDay).inDays;

    var listOfDates = List<int>.generate(totalDays, (i) => i + 1);
    return (listOfDates);
  }

  int getIndexOfFirstDayInMonth(DateTime currentDate) {
    var selectedMonthFirstDay =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    var day = DateFormat('EEE').format(selectedMonthFirstDay).toUpperCase();

    return daysOfWeek.indexOf(day) - 1;
  }

  final List<String> daysOfWeek = [
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT",
    "SUN",
  ];

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('you are selected date');
  }
}
