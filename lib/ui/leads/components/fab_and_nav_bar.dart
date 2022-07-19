import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kit_19/ui/TaskFile/models/upload_document.dart';
import 'package:kit_19/ui/add_new_lead/new_lead.dart';
import 'package:kit_19/ui/appointment/add_appoinments.dart';
import 'package:kit_19/ui/calling/call_screen.dart';
import 'package:kit_19/ui/calling/updated_popup.dart';
import 'package:kit_19/ui/enquiries/new_enquiry.dart';
import 'package:kit_19/ui/enquiries/widgets/send_mail.dart';
import 'package:kit_19/ui/enquiries/widgets/send_sms.dart';
import 'package:kit_19/ui/enquiries/widgets/send_voice.dart';
import 'package:kit_19/ui/follwup/add_followup.dart';
import 'package:kit_19/ui/leads/widgets/lead_add_task.dart';
import 'package:kit_19/ui/leads/widgets/lead_send_voice.dart';
import 'package:kit_19/ui/leads/widgets/lead_send_whatsapp.dart';
import 'package:kit_19/ui/notes/add_notes%20(5).dart';
import 'package:kit_19/ui/task/add_task.dart';
import 'package:system_alert_window/system_alert_window.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/app_theme.dart';

import '../../TaskFile/upload_document_page.dart';
import '../../notes/add_deal (2).dart';
import '../lead_common_data.dart';
import '../widgets/lead_send_mail.dart';
import '../widgets/lead_send_sms.dart';

class LeadDetailsFAButton extends StatelessWidget {
  const LeadDetailsFAButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              // ignore: unnecessary_const
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
          backgroundColor: Colors.white,
          context: context,
          isScrollControlled: true,
          builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 10),
                  //       child: const Text(
                  //         'Webform',
                  //         style: TextStyle(fontSize: 15, color: Colors.black),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const Divider(
                  //   color: Colors.black,
                  // ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     child: Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Text(
                  //         'Add Invoice',
                  //         style: TextStyle(fontSize: 15, color: Colors.black),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const Divider(
                  //   color: Colors.black,
                  // ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: const Text(
                  //         'Add Quoatation',
                  //         style: TextStyle(fontSize: 15, color: Colors.black),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const Divider(
                  //   color: Colors.black,
                  // ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: const Text(
                  //         'Add Tax Setting',
                  //         style: const TextStyle(
                  //             fontSize: 15, color: Colors.black),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const Divider(
                  //   color: Colors.black,
                  // ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => AddDeal()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Add Deal',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => AddAppointment()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Add Appointment',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => AddTask()));
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Add Task',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => UploadDocuments()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Upload Document',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => AddNotesPage()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Add Note',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => AddFollowUp()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Add Followup',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => SendMail()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Send Mail',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SendVoice()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Send Voice',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SendSmsPage()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Send SMS',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      backgroundColor: AppTheme.colorPrimary,
      child: const Icon(Icons.list),
    );

    // GestureDetector(
    //     onTap: () {
    //       showModalBottomSheet(
    //         shape: const RoundedRectangleBorder(
    //             // ignore: unnecessary_const
    //             borderRadius:
    //                 BorderRadius.vertical(top: Radius.circular(25.0))),
    //         backgroundColor: Colors.white,
    //         context: context,
    //         isScrollControlled: true,
    //         builder: (context) => Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 18),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisSize: MainAxisSize.min,
    //             children: const <Widget>[
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Center(child: Text('Webform')),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Center(child: Text('Add Invoice')),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Center(child: Text('Add Quoatation')),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Center(child: Text('Add Tax setting')),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Center(child: Text('Add Deal')),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Center(child: Text('Add Appointment')),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Center(child: Text('Add Task')),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Center(child: Text('Upload Document')),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Center(child: Text('Add Note')),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Center(child: Text('Add Followup')),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Center(child: Text('Send Mail')),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Center(child: Text('Send voice')),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Center(child: Text('Send SMS')),
    //             ],
    //           ),
    //         ),
    //       );
    //     };

    // SpeedDialChild(
    //   onTap: () {},
    //   labelWidget: Container(
    //     width: 200,
    //     decoration: BoxDecoration(
    //       shape: BoxShape.rectangle,
    //       border: Border.all(color: Colors.black),
    //     ),
    //     child: const Center(child: Text('Webform')),
    //   ),
    // ),
    // SpeedDialChild(
    //   onTap: () {},
    //   labelWidget: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         border: Border.all(color: Colors.black),
    //       ),
    //       width: 200,
    //       child: const Center(child: Text('Add Invoice'))),
    // ),
    // SpeedDialChild(
    //   onTap: () {},
    //   labelWidget: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         border: Border.all(color: Colors.black),
    //       ),
    //       width: 200,
    //       child: const Center(child: Text('Add quotation'))),
    // ),
    // SpeedDialChild(
    //   onTap: () {},
    //   labelWidget: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         border: Border.all(color: Colors.black),
    //       ),
    //       width: 200,
    //       child: const Center(child: Text('Add Tax Settings'))),
    // ),
    // SpeedDialChild(
    //   onTap: () {
    //     Navigator.push(
    //         context, CupertinoPageRoute(builder: (context) => AddDeal()));
    //   },
    //   labelWidget: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         border: Border.all(color: Colors.black),
    //       ),
    //       width: 200,
    //       child: const Center(child: Text('Add Deal'))),
    // ),
    // SpeedDialChild(
    //   onTap: () {
    //     Navigator.push(context,
    //         CupertinoPageRoute(builder: (context) => AddAppointment()));
    //   },
    //   labelWidget: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         border: Border.all(color: Colors.black),
    //       ),
    //       width: 200,
    //       child: const Center(child: Text('Add Appointment'))),
    // ),
    // SpeedDialChild(
    //   onTap: () {
    //     Navigator.push(
    //         context, CupertinoPageRoute(builder: (context) => AddTask()));
    //   },
    //   labelWidget: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         border: Border.all(color: Colors.black),
    //       ),
    //       width: 200,
    //       child: const Center(child: Text('Add Task'))),
    // ),
    // SpeedDialChild(
    //   onTap: () {},
    //   labelWidget: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         border: Border.all(color: Colors.black),
    //       ),
    //       width: 200,
    //       child: const Center(child: Text('Upload Documents'))),
    // ),
    // SpeedDialChild(
    //   onTap: () {
    //     Navigator.push(
    //         context, CupertinoPageRoute(builder: (context) => AddNotes()));
    //   },
    //   labelWidget: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         border: Border.all(color: Colors.black),
    //       ),
    //       width: 200,
    //       child: const Center(child: Text('Add Notes'))),
    // ),
    // SpeedDialChild(
    //   onTap: () {
    //     Navigator.push(context,
    //         CupertinoPageRoute(builder: (context) => AddFollowUp()));
    //   },
    //   labelWidget: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         border: Border.all(color: Colors.black),
    //       ),
    //       width: 200,
    //       child: const Center(child: Text('Add Followup'))),
    // ),
    // SpeedDialChild(
    //   onTap: () {
    //     Navigator.push(
    //         context, CupertinoPageRoute(builder: (context) => SendMail()));
    //   },
    //   labelWidget: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         border: Border.all(color: Colors.black),
    //       ),
    //       width: 200,
    //       child: const Center(child: Text('Mail'))),
    // ),
    // SpeedDialChild(
    //   onTap: () {
    //     Navigator.push(
    //         context, CupertinoPageRoute(builder: (context) => SendVoice()));
    //   },
    //   labelWidget: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         border: Border.all(color: Colors.black),
    //       ),
    //       width: 200,
    //       child: const Center(child: Text('Send voice'))),
    // ),
    // SpeedDialChild(
    //   onTap: () {
    //     Navigator.push(context,
    //         CupertinoPageRoute(builder: (context) => SendSmsPage()));
    //   },
    //   labelWidget: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         border: Border.all(color: Colors.black),
    //       ),
    //       width: 200,
    //       child: const Center(child: Text('SMS'))),
    // ),
    //     ],
    //   ),
    // );
  }
}

class LeadDetailsBottomNavBar extends StatefulWidget {
  const LeadDetailsBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<LeadDetailsBottomNavBar> createState() =>
      _LeadDetailsBottomNavBarState();
}

class _LeadDetailsBottomNavBarState extends State<LeadDetailsBottomNavBar> {
  openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Can't open dial pad.");
    }
  }

  String _platformVersion = 'Unknown';
  bool _isShowingWindow = false;
  bool _isUpdatedWindow = false;
  SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;

  @override
  void initState() {
    super.initState();
    _initPlatformState();
    _requestPermissions();
    // SystemAlertWindow.registerOnClickListener(callBack);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initPlatformState() async {
    await SystemAlertWindow.enableLogs(true);
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = (await SystemAlertWindow.platformVersion)!;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _requestPermissions() async {
    await SystemAlertWindow.requestPermissions(prefMode: prefMode);
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
      );

      SystemWindowFooter footer = SystemWindowFooter(
          buttons: [
            SystemWindowButton(
              text: SystemWindowText(
                  text: "Add Enquiry",
                  fontSize: 12,
                  textColor: const Color.fromRGBO(250, 139, 97, 1)),
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
                  text: "Add Lead", fontSize: 12, textColor: Colors.white),
              tag: "Add Lead",
              width: 0,
              padding:
                  SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
              height: SystemWindowButton.WRAP_CONTENT,
              decoration: SystemWindowDecoration(
                  startColor: const Color.fromRGBO(250, 139, 97, 1),
                  endColor: const Color.fromRGBO(247, 28, 88, 1),
                  borderWidth: 0,
                  borderRadius: 30.0),
            )
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
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const LeadSendMail()));
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
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const LeadSendSmsPage()));
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
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const LeadSendVoice()));
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
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Connect with',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    SystemAlertWindow.closeSystemWindow(
                                        prefMode: prefMode);
                                    setState(() {
                                      selectedmobno = '';
                                    });
                                  },
                                  icon: const Icon(Icons.cancel_outlined),
                                ),
                              ],
                            ),
                            const CustomRadioButton(),
                            const MyStatefulWidget(),
                            TextButton(
                                onPressed: () {
                                  print('button is pressed');
                                  if (callpath == 1) {
                                    openDialPad(selectedmobno.toString());
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const AlertDialog(
                                        content: CallPopupUpdated(),
                                        actions: [],
                                      ),
                                    );
                                  } else {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const AlertDialog(
                                        content: CallPopupUpdated(),
                                        actions: [
                                          // VoipCall(),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: const Center(
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
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const SendWhatsapp()));
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
