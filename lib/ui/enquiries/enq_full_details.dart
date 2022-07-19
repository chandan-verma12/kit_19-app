import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kit_19/model/enq_full_details_model.dart';
import 'package:kit_19/model/enquiry_details.dart';
import 'package:kit_19/ui/calling/call_screen.dart';
import 'package:kit_19/ui/enquiries/widgets/send_whatsapp.dart';
import 'package:kit_19/ui/enquiries/widgets/send_mail.dart';
import 'package:kit_19/ui/enquiries/widgets/send_sms.dart';
import 'package:kit_19/ui/enquiries/widgets/send_voice.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/app_theme.dart';
import '../../model/user_data.dart';
import '../leads/components/leadfulldtls_show_widget.dart';

class EnquiryFullDetails extends StatelessWidget {
  EnquiryFullDetails({Key? key, required this.id}) : super(key: key);

  final int id;

  // var myMenuItems = <String>[
  //   'Edit',
  //   'Add/Merge to Lead',
  //   'Delete',
  // ];

  void onSelect(item) {
    switch (item) {
      case 'Edit':
        print('Add clicked');

        break;
      case 'Add/Merge to Lead':
        print('Edit clicked');
        break;
      case 'Delete':
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
          //   PopupMenuButton<String>(
          //       onSelected: onSelect,
          //       itemBuilder: (BuildContext context) {
          //         return myMenuItems.map((String choice) {
          //           return PopupMenuItem<String>(
          //             child: Text(choice),
          //             value: choice,
          //           );
          //         }).toList();
          //       })
        ],
      ),
      body: EnquiryFullDetailsPage(id: id),
      bottomNavigationBar: EnqFullDetailsBottomNavBar(),
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
                              crtby: UserDetails.fName,
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
  void initState() {
    super.initState();
    EnquiryDetails.email1 = widget.email1;
    EnquiryDetails.email2 = widget.email2;
    EnquiryDetails.email3 = widget.email3;
    EnquiryDetails.mobile1 = widget.mob1;
    EnquiryDetails.mobile2 = widget.mob2;
    EnquiryDetails.mobile3 = widget.mob3;
    EnquiryDetails.name = widget.name;
  }

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
                // Flexible(
                //   child: new Container(
                //     padding: new EdgeInsets.only(right: 5.0),
                //     child: new Text(
                //       widget.name,
                //       overflow: TextOverflow.ellipsis,
                //       style: new TextStyle(
                //         fontSize: 18.0,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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

class EnqFullDetailsBottomNavBar extends StatefulWidget {
  const EnqFullDetailsBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<EnqFullDetailsBottomNavBar> createState() =>
      _EnqFullDetailsBottomNavBarState();
}

class _EnqFullDetailsBottomNavBarState
    extends State<EnqFullDetailsBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    openDialPad(String phoneNumber) async {
      Uri url = Uri(scheme: "tel", path: phoneNumber);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        print("Can't open dial pad.");
      }
    }

    return Container(
        padding: EdgeInsets.only(bottom: Platform.isIOS ? 20 : 0),
        decoration: const BoxDecoration(
          color: AppTheme.colorPrimary,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.white,
                    backgroundColor: AppTheme.colorPrimary),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => SendMail()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage(
                      'assets/icons/mail.png',
                    ),
                    color: AppTheme.white,
                    height: 30,
                    width: 30,
                  ),
                )),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.white,
                    backgroundColor: AppTheme.colorPrimary),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => SendSmsPage()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage(
                      'assets/icons/sms.png',
                    ),
                    color: AppTheme.white,
                    height: 30,
                    width: 30,
                  ),
                )),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.white,
                    backgroundColor: AppTheme.colorPrimary),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => SendVoice()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage(
                      'assets/icons/voice.png',
                    ),
                    color: AppTheme.white,
                    height: 30,
                    width: 30,
                  ),
                )),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.white,
                    backgroundColor: AppTheme.colorPrimary),
                onPressed: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10.0))),
                    backgroundColor: Colors.white,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Connect with',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      selectedmobno = '';
                                    });
                                  },
                                  icon: Icon(Icons.cancel_outlined),
                                ),
                              ],
                            ),
                            CustomEnqRadioButton(),
                            MyStatefulWidget(),
                            TextButton(
                                onPressed: () {
                                  print('button is pressed');
                                  callpath == 1
                                      ? openDialPad(selectedmobno.toString())
                                      : showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            content: const Text(
                                                'You will recieve a Call shortly'),
                                            actions: <Widget>[
                                              VoipCallEnquiry(),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Ok'),
                                                child: const Text('Ok'),
                                              ),
                                            ],
                                          ),
                                        );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      'Call Now',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                  color: Colors.green,
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage(
                      'assets/icons/phone.png',
                    ),
                    color: AppTheme.white,
                    height: 30,
                    width: 30,
                  ),
                )),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.white,
                    backgroundColor: AppTheme.colorPrimary),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     CupertinoPageRoute(
                  //         builder: (context) => SendWhatsappenq()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage(
                      'assets/icons/whatsapp.png',
                    ),
                    color: AppTheme.white,
                    height: 30,
                    width: 30,
                  ),
                ))
          ],
        ));
  }
}
