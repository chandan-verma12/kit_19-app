import 'package:flutter/material.dart';
import 'package:kit_19/ui/leads/lead_details/lead_details.dart';
import 'package:kit_19/ui/leads/lead_details/lead_details_body.dart';

import '../../../utils/app_theme.dart';

class TabBarLeadDetails extends StatelessWidget {
  TabBarLeadDetails({Key? key, required this.id}) : super(key: key);

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
          body: TabBarView(
            children: [
              BasicDetailsPage(id: id),
              FullDetailsPage(id: id),
              ActivityDetailsPage(id: id),
            ],
          ),
          floatingActionButton: LeadFullDetailsFAButton(),
          bottomNavigationBar: LeadFullDetailsBottomNavBar(),
        ),
      ),
    );
  }
}
