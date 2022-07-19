import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kit_19/ui/TaskFile/search_lead.dart';

import '../../utils/app_theme.dart';
import '../add_new_lead/new_lead.dart';
import 'components/fab_and_nav_bar.dart';
import 'lead_details_body.dart';

class TabBarLeadDetails extends StatelessWidget {
  TabBarLeadDetails({Key? key, required this.id}) : super(key: key);

  final int id;

  var myMenuItems = <String>[
    'Add',
    'Merge Lead To Lead',
    // 'Edit',
    // 'Delete',
  ];

  void SelectedItem(BuildContext context, item) {
    switch (item) {
      case 'Add':
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => NewLead()));
        break;
      case 'Merge Lead To Lead':
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => SearchLead()));

        break;
      case 'Edit':
        break;
      case 'Delete':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: Icon(Icons.arrow_back_ios),
            ),
            backgroundColor: AppTheme.colorPrimary,
            bottom: const TabBar(
              indicatorColor: Colors.green,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.green,
              tabs: [
                Tab(
                  child: Text('Basic Details'),
                ),
                Tab(
                  child: Text('Full Details'),
                ),
                Tab(
                  child: Text('Activity Details'),
                ),
              ],
            ),
            title: const Text('Lead'),
            actions: <Widget>[
              PopupMenuButton<String>(
                  onSelected: (item) => SelectedItem(context, item),
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
          body: TabBarView(
            children: [
              BasicDetailsPage(id: id),
              FullDetailsPage(id: id),
              ActivityDetailsPage(id: id),
            ],
          ),
          floatingActionButton: LeadDetailsFAButton(),
          bottomNavigationBar: LeadDetailsBottomNavBar(),
        ),
      ),
    );
  }
}
