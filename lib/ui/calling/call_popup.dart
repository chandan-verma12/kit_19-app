import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';

class CallPopupScreen extends StatefulWidget {
  const CallPopupScreen({Key? key}) : super(key: key);

  @override
  State<CallPopupScreen> createState() => _CallPopupScreenState();
}

class _CallPopupScreenState extends State<CallPopupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colorPrimary,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Call popup'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Incoming Audio Call From',
                  style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    shape: BoxShape.circle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                      size: const Size.fromRadius(80), // Image radius
                      child: Image.asset("assets/icons/user_place_holder.png")),
                ),
              ),
              Column(
                children: [
                  Text(
                    'Name ',
                    style: TextStyle(fontSize: 20, color: Colors.lightBlue),
                  ),
                  Text(
                    'Mobile Number ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Location',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Task',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Log this Call?',
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.call),
                            iconSize: 40,
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.call_end),
                            iconSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CallBoxPopup extends StatefulWidget {
  const CallBoxPopup({Key? key}) : super(key: key);

  @override
  State<CallBoxPopup> createState() => _CallBoxPopupState();
}

class _CallBoxPopupState extends State<CallBoxPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colorPrimary,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Call popup'),
      ),
      body: Center(
        child: Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.cancel),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          shape: BoxShape.circle),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                            size: const Size.fromRadius(30), // Image radius
                            child: Image.asset(
                                "assets/icons/user_place_holder.png")),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Mobile number',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text('Status incoming or outgoing'),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
