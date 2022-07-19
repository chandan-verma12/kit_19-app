import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kit_19/ui/add_new_lead/new_lead.dart';
import 'package:kit_19/ui/enquiries/new_enquiry.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:system_alert_window/models/system_window_decoration.dart';
import 'package:system_alert_window/models/system_window_padding.dart';
import 'package:system_alert_window/system_alert_window.dart';

import '../leads/lead_common_data.dart';
import 'call_screen.dart';

void callBack(String tag) {
  WidgetsFlutterBinding.ensureInitialized();
  print(tag);
  switch (tag) {
    case "Close":
      SystemAlertWindow.closeSystemWindow(
          prefMode: SystemWindowPrefMode.OVERLAY);
      break;
    case "Add Enquiry":
      const NewEnquiry();
      break;
    case "Add Lead":
      const NewLead();

      break;
    default:
      print("OnClick event of $tag");
  }
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  PhoneStateStatus status = PhoneStateStatus.NOTHING;
  bool granted = false;
  SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;

  Future<bool> requestPermission() async {
    var status = await Permission.phone.request();

    switch (status) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        return false;
      case PermissionStatus.granted:
        return true;
    }
  }

  bool _isShowingWindow = false;
  bool _isUpdatedWindow = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) setStream();

    SystemAlertWindow.registerOnClickListener(callBack);
  }

  void setStream() {
    PhoneState.phoneStateStream.listen((event) {
      setState(() {
        if (event != null) {
          status = event;
          _showOverlayWindow();
        }
      });
    });
  }

  void _showOverlayWindow() {
    if (!_isShowingWindow) {
      SystemWindowHeader header = SystemWindowHeader(
        title: SystemWindowText(
            text: LeadDetailsCommon.name,
            fontSize: 10,
            textColor: Colors.black45),
        padding: SystemWindowPadding.setSymmetricPadding(12, 12),
        subTitle: SystemWindowText(
            text: selectedmobno.toString(),
            fontSize: 14,
            fontWeight: FontWeight.BOLD,
            textColor: Colors.black87),
        decoration: SystemWindowDecoration(startColor: Colors.grey[100]),
        button: SystemWindowButton(
          text: SystemWindowText(
              text: "Close", fontSize: 12, textColor: Colors.black),
          tag: "Close",
          padding:
              SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
          width: 0,
          height: SystemWindowButton.WRAP_CONTENT,
          decoration: SystemWindowDecoration(
              startColor: Colors.white,
              endColor: Colors.white,
              borderWidth: 0,
              borderRadius: 0.0),
        ),
      );

      SystemWindowFooter footer = SystemWindowFooter(
          buttons: [
            SystemWindowButton(
              text: SystemWindowText(
                  text: "Add Enquiry", fontSize: 12, textColor: Colors.black),
              tag: "Add Enquiry",
              padding:
                  SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
              width: 0,
              height: SystemWindowButton.WRAP_CONTENT,
              decoration: SystemWindowDecoration(
                  startColor: Colors.white,
                  endColor: Colors.white,
                  borderWidth: 0,
                  borderRadius: 0.0),
            ),
            SystemWindowButton(
              text: SystemWindowText(
                  text: "Add Lead", fontSize: 12, textColor: Colors.black),
              tag: "Add Lead",
              width: 0,
              padding:
                  SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
              height: SystemWindowButton.WRAP_CONTENT,
              decoration: SystemWindowDecoration(
                  startColor: Colors.green,
                  endColor: Colors.green,
                  borderWidth: 0,
                  borderRadius: 30.0),
            ),
          ],
          padding: SystemWindowPadding(left: 16, right: 16, bottom: 12),
          decoration: SystemWindowDecoration(startColor: Colors.white),
          buttonsPosition: ButtonPosition.CENTER);
      SystemAlertWindow.showSystemWindow(
          height: 230,
          header: header,
          footer: footer,
          margin: SystemWindowMargin(left: 8, right: 8, top: 200, bottom: 0),
          gravity: SystemWindowGravity.TOP,
          notificationTitle: "Call",
          prefMode: prefMode);
      setState(() {
        _isShowingWindow = true;
      });
    } else {
      setState(() {
        _isShowingWindow = false;
        _isUpdatedWindow = false;
      });
      SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone State"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (Platform.isAndroid)
              MaterialButton(
                child: const Text("Request permission of Phone"),
                onPressed: !granted
                    ? () async {
                        bool temp = await requestPermission();
                        setState(() {
                          granted = temp;
                          if (granted) {
                            setStream();
                          }
                        });
                      }
                    : null,
              ),
            const Text(
              "Status of call",
              style: TextStyle(fontSize: 24),
            ),
            Icon(
              getIcons(),
              color: getColor(),
              size: 80,
            ),
            TextButton(
                onPressed: () {
                  // _showOverlayWindow();
                },
                child: Text('show Overlay'))
          ],
        ),
      ),
    );
  }

  IconData getIcons() {
    switch (status) {
      case PhoneStateStatus.NOTHING:
        return Icons.clear;
      case PhoneStateStatus.CALL_INCOMING:
        return Icons.add_call;
      case PhoneStateStatus.CALL_STARTED:
        return Icons.call;
      case PhoneStateStatus.CALL_ENDED:
        return Icons.call_end;
    }
  }

  Color getColor() {
    switch (status) {
      case PhoneStateStatus.NOTHING:
      case PhoneStateStatus.CALL_ENDED:
        return Colors.red;
      case PhoneStateStatus.CALL_INCOMING:
        return Colors.green;
      case PhoneStateStatus.CALL_STARTED:
        return Colors.orange;
    }
  }
}
