import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kit_19/model/activity_list_model.dart';
import 'package:kit_19/model/follow_up_details_response.dart';
import 'package:kit_19/model/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:kit_19/ui/follwup/add_followup.dart';
import '../../../model/folloup_list_model.dart';
import '../../../model/lead_data.dart';
import '../../../utils/app_theme.dart';
import 'components/leadfulldtls_show_widget.dart';
import 'lead_details.dart';

class BasicDetailsApi extends StatefulWidget {
  const BasicDetailsApi({
    Key? key,
    required this.name,
    required this.emailid,
    required this.mobileno,
    required this.leadno,
    required this.assignedto,
    required this.lastupdated,
    required this.address,
  }) : super(key: key);

  final String name,
      emailid,
      mobileno,
      leadno,
      assignedto,
      lastupdated,
      address;

  @override
  State<BasicDetailsApi> createState() => _BasicDetailsApiState();
}

class _BasicDetailsApiState extends State<BasicDetailsApi> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      shape: BoxShape.rectangle),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(28), // Image radius
                      child: LeadDetails.image.isEmpty
                          ? Image.asset("assets/icons/user_place_holder.png")
                          : Image.network(LeadDetails.image),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/icons/location.png',
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/email.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(widget.emailid),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/mobile.png',
                  width: 22,
                  height: 22,
                ),
                Text(widget.mobileno),
              ],
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Lead No : '),
              ),
              Text(widget.leadno),
            ],
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Assigned to :'),
              ),
              Text(widget.assignedto),
            ],
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Last Updated: '),
              ),
              Text(widget.lastupdated),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('View All Fields'),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text('Owner'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      shape: BoxShape.circle),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(24), // Image radius
                      child: LeadDetails.image.isEmpty
                          ? Image.asset("assets/icons/user_place_holder.png")
                          : Image.network(LeadDetails.image),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              color: Colors.green.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          shape: BoxShape.circle),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(24), // Image radius
                          child: LeadDetails.image.isEmpty
                              ? Image.asset(
                                  "assets/icons/user_place_holder.png")
                              : Image.network(LeadDetails.image),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 260,
                      height: 60,
                      child: Text(
                        widget.address,
                        maxLines: 3,
                        softWrap: true,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/icons/location.png',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullDetailsPageApi extends StatefulWidget {
  const FullDetailsPageApi(
      {Key? key,
      required this.name,
      required this.mob1,
      required this.mob2,
      required this.mob3,
      required this.email1,
      required this.email2,
      required this.email3,
      required this.comname,
      required this.leadno,
      required this.assigto,
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
      required this.opincode})
      : super(key: key);
  final String name,
      mob1,
      mob2,
      mob3,
      email1,
      email2,
      email3,
      comname,
      leadno,
      assigto,
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
  State<FullDetailsPageApi> createState() => _FullDetailsPageApiState();
}

class _FullDetailsPageApiState extends State<FullDetailsPageApi> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
                    child: LeadDetails.image.isEmpty
                        ? Image.asset("assets/icons/user_place_holder.png")
                        : Image.network(LeadDetails.image),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(widget.email1),
                    const Text(' '),
                    Text(widget.email2),
                    const Text(' '),
                    Text(widget.email3),
                  ],
                ),
                Row(
                  children: [
                    Text(widget.mob1),
                    const Text(' '),
                    Text(widget.mob2),
                    const Text(' '),
                    Text(widget.mob3),
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
                  'Lead Information',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Company Name',
          fielddata: widget.comname,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Lead No.',
          fielddata: widget.leadno,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Assigned To',
          fielddata: widget.assigto,
        ),
        LeadFullDetailsFieldsShowWidget(
          fieldname: 'Source',
          fielddata: widget.src,
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
          fieldname: 'Created On',
          fielddata: widget.createon,
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
                  'Address Information',
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
              const SizedBox(
                width: 10,
              ),
              const Padding(
                padding: const EdgeInsets.all(10.0),
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

class ActivityDetailsPage extends StatefulWidget {
  final int id;

  const ActivityDetailsPage({Key? key, required this.id}) : super(key: key);
  @override
  State createState() {
    return ActivityDetailsPageState();
  }
}

class ActivityDetailsPageState extends State<ActivityDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.black,
          useInkWell: true,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              ActivityDetailsCardWidget(
                cardname: 'Lead Activities',
                expandedwidget: LeadActivitiesApi(
                  id: widget.id,
                ),
              ),
              ActivityDetailsCardWidget(
                cardname: 'Followup History',
                expandedwidget: FollupHistoryExpandedWidgetapi(
                  id: widget.id,
                ),
              ),
              ActivityDetailsCardWidget(
                cardname: 'Notes',
                expandedwidget: Container(),
              ),
              ActivityDetailsCardWidget(
                cardname: 'Documents',
                expandedwidget: Container(),
              ),
              ActivityDetailsCardWidget(
                cardname: 'Task',
                expandedwidget: Container(),
              ),
              ActivityDetailsCardWidget(
                cardname: 'Appointment',
                expandedwidget: Container(),
              ),
              ActivityDetailsCardWidget(
                cardname: 'Webform',
                expandedwidget: WebformWidgetapi(
                  leadid: widget.id,
                ),
              ),
              ActivityDetailsCardWidget(
                cardname: 'Tax Settings',
                expandedwidget: Container(),
              ),
              ActivityDetailsCardWidget(
                cardname: 'Invoices',
                expandedwidget: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebformWidgetapi extends StatelessWidget {
  const WebformWidgetapi({Key? key, required this.leadid}) : super(key: key);
  final int leadid;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class WebformExpandedSingleWidget extends StatelessWidget {
  const WebformExpandedSingleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ActivityDetailsCardWidget extends StatelessWidget {
  final String cardname;
  final Widget expandedwidget;

  const ActivityDetailsCardWidget(
      {Key? key, required this.cardname, required this.expandedwidget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: ScrollOnExpand(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToExpand: true,
                tapBodyToCollapse: true,
                hasIcon: false,
              ),
              header: Container(
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(cardname,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18)),
                      ),
                      ExpandableIcon(
                        theme: const ExpandableThemeData(
                          expandIcon: Icons.keyboard_arrow_down,
                          collapseIcon: Icons.keyboard_arrow_down,
                          iconColor: Colors.black,
                          iconSize: 30.0,
                          iconPadding: EdgeInsets.only(right: 5),
                          hasIcon: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              collapsed: Container(),
              expanded: expandedwidget,
            ),
          ],
        ),
      ),
    ));
  }
}

class FollupHistoryExpandedWidgetapi extends StatefulWidget {
  const FollupHistoryExpandedWidgetapi({Key? key, required this.id})
      : super(key: key);
  final int id;

  @override
  State<FollupHistoryExpandedWidgetapi> createState() =>
      _FollupHistoryExpandedWidgetapiState();
}

class _FollupHistoryExpandedWidgetapiState
    extends State<FollupHistoryExpandedWidgetapi> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => FollowupDetailspage(
                        leadid: widget.id,
                      )));
        },
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
                      child: FutureBuilder<FollowupListModel>(
                        // initiallly get_prodModellist is empty so you will see a progreessbar on screen
                        // OR
                        // you can directly call the get_datacall() function here to automatically get
                        // data from sever and show on UI
                        future: getFollowupListApiCall(widget
                            .id), // here get_datacall()  can be call directly
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(" show data on screen " +
                                snapshot.data.toString());
                            var len = snapshot.data!.details!.length;

                            return Column(
                              children: [
                                for (var i = 0; i < len; i++) ...[
                                  FollowupHistoryExpandedSingleWidget(
                                    datetime: snapshot
                                        .data!.details![i].nextStatusDate
                                        .toString(),
                                    image: '',
                                    status: snapshot
                                        .data!.details![i].followupStatus
                                        .toString(),
                                  ),
                                ]
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner
                          return const Center(
                              child: CircularProgressIndicator());
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

class FollowupHistoryExpandedSingleWidget extends StatelessWidget {
  const FollowupHistoryExpandedSingleWidget({
    Key? key,
    required this.datetime,
    required this.status,
    required this.image,
  }) : super(key: key);
  final String datetime, status, image;

  @override
  Widget build(BuildContext context) {
    List<String> date = datetime.split(' ');

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    DateTimeWidget(datetime: datetime),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          status,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'lead created',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    shape: BoxShape.rectangle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                      size: const Size.fromRadius(26), // Image radius
                      child: Image.asset("assets/icons/user_place_holder.png")),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({
    Key? key,
    required this.datetime,
  }) : super(key: key);

  final String datetime;

  @override
  Widget build(BuildContext context) {
    List<String> date = datetime.split(' ');
    return Container(
      height: 60,
      width: 60,
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Text(
                  date[1],
                ),
                const Text('-'),
                Text(date[2]),
              ],
            ),
          ),
          Text(
            date[0],
            style: const TextStyle(fontSize: 20),
          ),
          Text(date[3]),
        ],
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    );
  }
}

Future<FollowupListModel> getFollowupListApiCall(int leadid) async {
  var url = "https://services.kit19.com/UserCRM/GetFolloupHistoryByLeadId";

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

    return FollowupListModel.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

class FollowupDetailspage extends StatefulWidget {
  const FollowupDetailspage({Key? key, required this.leadid}) : super(key: key);

  final int leadid;

  @override
  State<FollowupDetailspage> createState() => _FollowupDetailspageState();
}

class _FollowupDetailspageState extends State<FollowupDetailspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: AppTheme.colorPrimary,
        title: const Text('Followup'),
        actions: [
          PopupMenuButton(
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => AddFollowUp()));
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
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
                      child: FutureBuilder<FollowUpDetailsResponse>(
                        // initiallly get_prodModellist is empty so you will see a progreessbar on screen
                        // OR
                        // you can directly call the get_datacall() function here to automatically get
                        // data from sever and show on UI
                        future: getFollowupDetailsApiCall(widget
                            .leadid), // here get_datacall()  can be call directly
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(" show data on screen " +
                                snapshot.data.toString());

                            return FollowupDetailsApi(
                              status: snapshot.data!.details!.status.toString(),
                              remarks:
                                  snapshot.data!.details!.remarks.toString(),
                              followupdate: snapshot.data!.details!.followupDate
                                  .toString(),
                              amount: snapshot.data!.details!.amount.toString(),
                              createdon:
                                  snapshot.data!.details!.createdOn.toString(),
                              assigneename: snapshot
                                  .data!.details!.assignTo!.firstName
                                  .toString(),
                              reassigned:
                                  snapshot.data!.details!.isReassign.toString(),
                              createname: snapshot
                                  .data!.details!.creator!.firstName
                                  .toString(),
                              createimage: snapshot
                                  .data!.details!.creator!.image
                                  .toString(),
                              assigneeimage: snapshot
                                  .data!.details!.assignTo!.image
                                  .toString(),
                              leadimage: snapshot.data!.details!.lead!.image
                                  .toString(),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner
                          return const Center(
                              child: CircularProgressIndicator());
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
      bottomNavigationBar: const LeadFullDetailsBottomNavBar(),
    );
  }
}

Future<FollowUpDetailsResponse> getFollowupDetailsApiCall(int leadid) async {
  var url = "https://services.kit19.com/UserCRM/GetFollowupDetailById";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"Id": leadid, "UserId": UserDetails.userId}
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

    return FollowUpDetailsResponse.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

class FollowupDetailsApi extends StatelessWidget {
  const FollowupDetailsApi({
    Key? key,
    required this.status,
    required this.remarks,
    required this.followupdate,
    required this.amount,
    required this.createdon,
    required this.assigneename,
    required this.reassigned,
    required this.createname,
    required this.createimage,
    required this.assigneeimage,
    required this.leadimage,
  }) : super(key: key);

  final String status,
      remarks,
      followupdate,
      amount,
      createdon,
      createname,
      createimage,
      leadimage,
      assigneeimage,
      assigneename,
      reassigned;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    // DateTimeWidget(datetime: followupdate),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          status,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Lead Created',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    shape: BoxShape.rectangle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                      size: const Size.fromRadius(26), // Image radius
                      child: Image.asset("assets/icons/user_place_holder.png")),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            remarks,
            softWrap: true,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Owner',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent),
                                  shape: BoxShape.circle),
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        22), // Image radius
                                    child: Image.asset(
                                        "assets/icons/user_place_holder.png")),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  createname,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  createdon,
                                  softWrap: true,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Assignee',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent),
                                  shape: BoxShape.circle),
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        22), // Image radius
                                    child: Image.asset(
                                        "assets/icons/user_place_holder.png")),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  assigneename,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const Text(
                'Re-Assigned',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                reassigned == 'true' ? 'Yes' : 'No',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const Text(
                'Amount Paid',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                amount,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const Text(
                'Products',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 30,
              ),
              const Text(
                '',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LeadActivitiesApi extends StatefulWidget {
  const LeadActivitiesApi({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<LeadActivitiesApi> createState() => _LeadActivitiesApiState();
}

class _LeadActivitiesApiState extends State<LeadActivitiesApi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Builder(
          builder: (context) => Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: FutureBuilder<ActivityListModel>(
                    // initiallly get_prodModellist is empty so you will see a progreessbar on screen
                    // OR
                    // you can directly call the get_datacall() function here to automatically get
                    // data from sever and show on UI
                    future: getActivityListApiCall(
                        widget.id), // here get_datacall()  can be call directly
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(
                            " show data on screen " + snapshot.data.toString());
                        var len = snapshot.data!.details!.length;

                        return Column(
                          children: [
                            for (var i = 0; i < len; i++) ...[
                              LeadActivitesSingleWidget(
                                datetime: snapshot.data!.details![i].eventDate
                                    .toString(),
                                eventdescription: snapshot
                                    .data!.details![i].eventDescription
                                    .toString(),
                                eventname: snapshot.data!.details![i].eventName
                                    .toString(),
                                image: snapshot.data!.details![i].eventIcon
                                    .toString(),
                              ),
                            ]
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      // By default, show a loading spinner
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class LeadActivitesSingleWidget extends StatelessWidget {
  const LeadActivitesSingleWidget(
      {Key? key,
      required this.image,
      required this.eventname,
      required this.eventdescription,
      required this.datetime})
      : super(key: key);

  final String image, eventname, eventdescription, datetime;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    shape: BoxShape.rectangle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                      size: const Size.fromRadius(26), // Image radius
                      child: Container()),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventname,
                    style: const TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    width: 290,
                    child: Text(
                      eventdescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: const TextStyle(fontSize: 13.0),
                    ),
                  ),
                  Text(
                    datetime,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

Future<ActivityListModel> getActivityListApiCall(int leadid) async {
  var url = "https://services.kit19.com/UserCRM/LeadActivityListById";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {
      "LeadId": leadid,
      "ActivityTypes": "",
      "FromDate": "",
      "EndDate": ""
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

    return ActivityListModel.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}
