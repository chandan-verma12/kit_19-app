import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kit_19/model/enq_full_details_model.dart';
import 'package:kit_19/ui/leads/lead_details/lead_details.dart';
import 'package:kit_19/ui/leads/lead_details/lead_details_body.dart';

import '../../../utils/app_theme.dart';
import '../../model/user_data.dart';
import '../leads/lead_details/components/leadfulldtls_show_widget.dart';

class EnquiryFullDetails extends StatelessWidget {
  EnquiryFullDetails({Key? key, required this.id}) : super(key: key);

  final int id;

  var myMenuItems = <String>[
    'Add',
    'Edit',
    'Delete',
  ];

  void onSelect(item) {
    switch (item) {
      case 'Home':
        print('Add clicked');
        break;
      case 'Profile':
        print('Edit clicked');
        break;
      case 'Setting':
        print('Delete clicked');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: AppTheme.colorPrimary,
        title: const Text('Enquiry'),
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: onSelect,
              itemBuilder: (BuildContext context) {
                return myMenuItems.map((String choice) {
                  return PopupMenuItem<String>(
                    child: Text(choice),
                    value: choice,
                  );
                }).toList();
              })
        ],
      ),
      body: EnquiryFullDetailsPage(id: id),
      floatingActionButton: LeadFullDetailsFAButton(),
      bottomNavigationBar: LeadFullDetailsBottomNavBar(),
    );
  }
}

class EnquiryFullDetailsPage extends StatefulWidget {
  EnquiryFullDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<EnquiryFullDetailsPage> createState() => _EnquiryFullDetailsPageState();
}

class _EnquiryFullDetailsPageState extends State<EnquiryFullDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Builder(
              builder: (context) => Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: FutureBuilder<EnquiryFullDetailsModel>(
                        // initiallly get_prodModellist is empty so you will see a progreessbar on screen
                        // OR
                        // you can directly call the get_datacall() function here to automatically get
                        // data from sever and show on UI
                        future: getEnqFullDetailsProdCall(widget
                            .id), // here get_datacall()  can be call directly
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(" show data on screen " +
                                snapshot.data.toString());
                            var len = snapshot.data!.details!.length;

                            return EnqFullDetailsPageApi(
                              name: snapshot.data!.details![0].personName
                                  .toString(),
                              mob1: snapshot.data!.details![0].mobileNo1
                                  .toString(),
                              mob2: snapshot.data!.details![0].mobileNo2
                                  .toString(),
                              mob3: snapshot.data!.details![0].mobileNo3
                                  .toString(),
                              email1: snapshot.data!.details![0].emailID1
                                  .toString(),
                              email2: snapshot.data!.details![0].emailID2
                                  .toString(),
                              email3: snapshot.data!.details![0].emailID3
                                  .toString(),
                              comname: snapshot.data!.details![0].companyName
                                  .toString(),
                              leadid:
                                  snapshot.data!.details![0].leadNo.toString(),
                              enquiryid: snapshot.data!.details![0].enquiryID
                                  .toString(),
                              src: snapshot.data!.details![0].sourceName
                                  .toString(),
                              med: snapshot.data!.details![0].mediumName
                                  .toString(),
                              camp: snapshot.data!.details![0].campaignName
                                  .toString(),
                              createon: snapshot.data!.details![0].createdDate
                                  .toString(),
                              crtby: snapshot.data!.details![0].createdBy
                                  .toString(),
                              raddr: snapshot
                                  .data!.details![0].residentialAddress
                                  .toString(),
                              rcity: snapshot.data!.details![0].city.toString(),
                              rsta: snapshot.data!.details![0].state.toString(),
                              rctry:
                                  snapshot.data!.details![0].country.toString(),
                              rpinco:
                                  snapshot.data!.details![0].pincode.toString(),
                              oadd: snapshot.data!.details![0].officeAddress
                                  .toString(),
                              ocit: snapshot.data!.details![0].city.toString(),
                              osta: snapshot.data!.details![0].state.toString(),
                              ocnty:
                                  snapshot.data!.details![0].country.toString(),
                              opincode:
                                  snapshot.data!.details![0].pincode.toString(),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

Future<EnquiryFullDetailsModel> getEnqFullDetailsProdCall(int Enqid) async {
  var url = "https://services.kit19.com/UserCRM/GetEnquiryDetailById";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "EnquiryId": Enqid,
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

    return EnquiryFullDetailsModel.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

class EnqFullDetailsPageApi extends StatefulWidget {
  const EnqFullDetailsPageApi(
      {Key? key,
      required this.name,
      required this.mob1,
      required this.mob2,
      required this.mob3,
      required this.email1,
      required this.email2,
      required this.email3,
      required this.comname,
      required this.leadid,
      required this.src,
      required this.med,
      required this.camp,
      required this.createon,
      required this.crtby,
      required this.raddr,
      required this.rcity,
      required this.rsta,
      required this.rctry,
      required this.rpinco,
      required this.oadd,
      required this.ocit,
      required this.osta,
      required this.ocnty,
      required this.opincode,
      required this.enquiryid})
      : super(key: key);
  final String name,
      mob1,
      mob2,
      mob3,
      email1,
      email2,
      email3,
      comname,
      leadid,
      enquiryid,
      src,
      med,
      camp,
      createon,
      crtby,
      raddr,
      rcity,
      rsta,
      rctry,
      rpinco,
      oadd,
      ocit,
      osta,
      ocnty,
      opincode;

  @override
  State<EnqFullDetailsPageApi> createState() => _EnqFullDetailsPageApiState();
}

class _EnqFullDetailsPageApiState extends State<EnqFullDetailsPageApi> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        shape: BoxShape.rectangle),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                          size: const Size.fromRadius(30), // Image radius
                          child: Image.asset(
                              "assets/icons/user_place_holder.png")),
                    ),
                  ),
                ),
                Text('Enquiry ID'),
                Text(widget.enquiryid),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Column(
                  children: [
                    Text(widget.email1 == 'null' ? ' ' : widget.email1),
                    Text(widget.email2 == 'null' ? ' ' : widget.email2),
                    Text(widget.email3 == 'null' ? ' ' : widget.email3),
                  ],
                ),
                Column(
                  children: [
                    Text(widget.mob1 == 'null' ? ' ' : widget.mob1),
                    Text(widget.mob2 == 'null' ? ' ' : widget.mob2),
                    Text(widget.mob3 == 'null' ? ' ' : widget.mob3),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          color: Colors.green.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Basic',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Lead Id',
          fielddata: widget.leadid,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Created On',
          fielddata: widget.createon,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Source',
          fielddata: widget.src,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Company Name',
          fielddata: widget.comname,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Medium',
          fielddata: widget.med,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Campaign',
          fielddata: widget.camp,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Created By',
          fielddata: widget.crtby,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.green.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Addresses',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Residential Adddress',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Address',
          fielddata: widget.raddr,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'City',
          fielddata: widget.rcity,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'State',
          fielddata: widget.rsta,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Country',
          fielddata: widget.rctry,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Pincode',
          fielddata: widget.rpinco,
        ),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Office Adddress',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Address',
          fielddata: widget.oadd,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'City',
          fielddata: widget.ocit,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'State',
          fielddata: widget.osta,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Country',
          fielddata: widget.ocnty,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Pincode',
          fielddata: widget.opincode,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.green.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: const Text(
                  'Other Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
