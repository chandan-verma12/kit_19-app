import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppTheme.colorPrimary,
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('Search All Modules'),
          actions: [
            IconButton(
              padding: const EdgeInsets.symmetric(vertical: 15),
              icon: Image.asset(
                'assets/icons/cancel-icon.png',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ]),
    );
  }
}
