import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kit_19/ui/enquiries/enquiry.dart';

import 'package:kit_19/ui/leads/lead.dart';
import 'package:kit_19/ui/leads/lead_common_data.dart';
import 'package:kit_19/ui/notes/select_notification.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:system_alert_window/system_alert_window.dart';

import 'dart:io';
import '../../base_class.dart';
import '../../model/nav_menu_balance.dart';
import '../../model/user_data.dart';
import '../../network/api_call.dart';
import '../../network/api_constants.dart';
import '../../network/api_response.dart';
import '../../network/method.dart';
import '../../utils/app_prefs.dart';
import '../../utils/app_theme.dart';
import '../../utils/strings.dart';
import '../../utils/two_button_dialog.dart';
import '../add_new_lead/new_lead.dart';
import '../calling/call_screen.dart';
import '../enquiries/new_enquiry.dart';
import '../login_signup/login.dart';
import '../notes/notification_list (1).dart';
import '../search/search_screen.dart';
import 'home.dart';

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

class Dashboard extends StatefulWidget {
  static String tag = 'intro_slider';

  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

class _Dashboard extends BaseClass<Dashboard> implements ApiResponse {
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey();
  var creditBalance = "0.0", smsBalance = "0.0", mailBalance = "0.0";
  SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;
  PhoneStateStatus status = PhoneStateStatus.NOTHING;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(milliseconds: 100), () {
        getBalance();
      });
      if (Platform.isIOS) setStream();

      SystemAlertWindow.registerOnClickListener(callBack);
    });
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
        padding: SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
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
  }

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

  void showLogoutDialog() {
    Navigator.pop(context);
    changeSystemUiColor(
        statusBarColor: Colors.transparent,
        navBarColor: Colors.black.withOpacity(0.6));
    var dialog = TwoButtonDialog(
        title: Strings.logoutConfirmation,
        message: Strings.logoutMsg,
        positiveBtnText: Strings.yes,
        negativeBtnText: Strings.no,
        onPostivePressed: () {
          changeSystemUiColor(
              statusBarColor: AppTheme.colorPrimary,
              brightness: Brightness.light);
          callLogoutApi();
        },
        onNegativePressed: () {
          changeSystemUiColor(
              statusBarColor: AppTheme.colorPrimary,
              brightness: Brightness.light);
        });
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.6),
        builder: (BuildContext context) {
          //prevent Back button press
          return WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: dialog);
        });
  }

  @override
  Widget build(BuildContext context) {
    changeSystemUiColor(
        statusBarColor: AppTheme.colorPrimary, brightness: Brightness.light);
    return Scaffold(
        key: _scafoldKey,
        appBar: AppBar(
          leading: IconButton(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            icon: Image.asset("assets/icons/drawer_icon.png"),
            onPressed: () {
              _scafoldKey.currentState?.openDrawer();
            },
          ),
          title: Text(Strings.home),
          backgroundColor: AppTheme.colorPrimary,
          elevation: 0,
          actions: [
            // IconButton(
            //   padding: const EdgeInsets.symmetric(vertical: 15),
            //   icon: Image.asset("assets/icons/search.png"),
            //   onPressed: () {
            //     Navigator.push(context,
            //         CupertinoPageRoute(builder: (context) => SearchScreen()));
            //   },
            // ),
            // IconButton(
            //   padding: const EdgeInsets.symmetric(vertical: 13),
            //   icon: Image.asset("assets/icons/user-white.png"),
            //   onPressed: () {},
            // )
          ],
        ),
        backgroundColor: AppTheme.white,
        drawer: SafeArea(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Drawer(
                    backgroundColor: AppTheme.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            decoration: const BoxDecoration(
                              color: AppTheme.colorPrimary,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30)),
                            ),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(
                                            24), // Image radius
                                        child: UserDetails
                                                .profilePicturePath.isEmpty
                                            ? Image.asset(
                                                "assets/icons/user_place_holder.png")
                                            : Image.network(
                                                UserDetails.profilePicturePath),
                                      ),
                                    ),
                                  ),
                                  getHorizontalGap(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${UserDetails.fName} ${UserDetails.lLName}",
                                          style:
                                              styleBoldColor(AppTheme.white)),
                                      Text(UserDetails.userName,
                                          style:
                                              styleRegularColor(AppTheme.white))
                                    ],
                                  ),
                                  Expanded(
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  minimumSize: Size.zero,
                                                  tapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  primary: AppTheme.white,
                                                  backgroundColor:
                                                      AppTheme.colorPrimary),
                                              onPressed: () {},
                                              child: const Image(
                                                image: AssetImage(
                                                  'assets/icons/setting.png',
                                                ),
                                                color: AppTheme.white,
                                                height: 30,
                                                width: 30,
                                              ))))
                                ])),
                        TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                primary: AppTheme.colorPrimary,
                                backgroundColor: AppTheme.white),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Dashboard()));
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(children: [
                                  const Image(
                                    image: AssetImage(
                                      'assets/icons/dashboard.png',
                                    ),
                                    height: 28,
                                    width: 28,
                                  ),
                                  getHorizontalGap(),
                                  Text(
                                    Strings.dashboard,
                                    style: styleRegularColor(AppTheme.black),
                                  )
                                ]))),
                        getHorizontalLine(),
                        TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                primary: AppTheme.colorPrimary,
                                backgroundColor: AppTheme.white),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Enquiry()));
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(children: [
                                  const Image(
                                    image: AssetImage(
                                      'assets/icons/enquiries.png',
                                    ),
                                    height: 28,
                                    width: 28,
                                  ),
                                  getHorizontalGap(),
                                  Text(
                                    Strings.enquiries,
                                    style: styleRegularColor(AppTheme.black),
                                  )
                                ]))),
                        getHorizontalLine(),
                        TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                primary: AppTheme.colorPrimary,
                                backgroundColor: AppTheme.white),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Lead()));
                              requestPermission();
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(children: [
                                  const Image(
                                    image: AssetImage(
                                      'assets/icons/leads.png',
                                    ),
                                    height: 28,
                                    width: 28,
                                  ),
                                  getHorizontalGap(),
                                  Text(
                                    Strings.leads,
                                    style: styleRegularColor(AppTheme.black),
                                  )
                                ]))),
                        getHorizontalLine(),
                        TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                primary: AppTheme.colorPrimary,
                                backgroundColor: AppTheme.white),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          SelectNotification()));
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(children: [
                                  const Image(
                                    image: AssetImage(
                                      'assets/icons/notification-bell.png',
                                    ),
                                    height: 28,
                                    width: 28,
                                  ),
                                  getHorizontalGap(),
                                  Text(
                                    'Notification',
                                    style: styleRegularColor(AppTheme.black),
                                  )
                                ]))),
                        getHorizontalLine(),
                        // TextButton(
                        //     style: TextButton.styleFrom(
                        //         padding: EdgeInsets.zero,
                        //         minimumSize: Size.zero,
                        //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        //         primary: AppTheme.colorPrimary,
                        //         backgroundColor: AppTheme.white),
                        //     onPressed: () {},
                        //     child: Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //             horizontal: 10, vertical: 10),
                        //         child: Row(children: [
                        //           const Image(
                        //             image: AssetImage(
                        //               'assets/icons/callLog.png',
                        //             ),
                        //             height: 28,
                        //             width: 28,
                        //           ),
                        //           getHorizontalGap(),
                        //           Text(
                        //             Strings.callLog,
                        //             style: styleRegularColor(AppTheme.black),
                        //           )
                        //         ]))),
                        // getHorizontalLine(),
                        // TextButton(
                        //     style: TextButton.styleFrom(
                        //         padding: EdgeInsets.zero,
                        //         minimumSize: Size.zero,
                        //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        //         primary: AppTheme.colorPrimary,
                        //         backgroundColor: AppTheme.white),
                        //     onPressed: () {},
                        //     child: Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //             horizontal: 10, vertical: 10),
                        //         child: Row(children: [
                        //           const Image(
                        //             image: AssetImage(
                        //               'assets/icons/settings2.png',
                        //             ),
                        //             height: 28,
                        //             width: 28,
                        //           ),
                        //           getHorizontalGap(),
                        //           Text(
                        //             Strings.settings,
                        //             style: styleRegularColor(AppTheme.black),
                        //           )
                        //         ]))),
                        // getHorizontalLine(),
                        const Spacer(),
                        Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: AppTheme.colorPrimary,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        primary: AppTheme.white,
                                        backgroundColor: AppTheme.colorPrimary),
                                    onPressed: () {},
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            'assets/icons/mail.png',
                                          ),
                                          height: 20,
                                          width: 20,
                                          color: AppTheme.white,
                                        ),
                                        Text(mailBalance,
                                            style: styleRegular(fontSize: 10))
                                      ],
                                    )),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        primary: AppTheme.white,
                                        backgroundColor: AppTheme.colorPrimary),
                                    onPressed: () {},
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            'assets/icons/chat.png',
                                          ),
                                          height: 20,
                                          width: 20,
                                          color: AppTheme.white,
                                        ),
                                        Text(smsBalance,
                                            style: styleRegular(fontSize: 10))
                                      ],
                                    )),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        primary: AppTheme.white,
                                        backgroundColor: AppTheme.colorPrimary),
                                    onPressed: () {},
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            'assets/icons/money.png',
                                          ),
                                          height: 20,
                                          width: 20,
                                          color: AppTheme.white,
                                        ),
                                        Text(creditBalance,
                                            style: styleRegular(fontSize: 10))
                                      ],
                                    )),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        primary: AppTheme.white,
                                        backgroundColor: AppTheme.colorPrimary),
                                    onPressed: () {},
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            'assets/icons/credit.png',
                                          ),
                                          height: 20,
                                          width: 20,
                                          color: AppTheme.white,
                                        ),
                                        Text(Strings.buyCredit,
                                            style: styleRegular(fontSize: 10))
                                      ],
                                    )),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        primary: AppTheme.white,
                                        backgroundColor: AppTheme.colorPrimary),
                                    onPressed: () {},
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            'assets/icons/help.png',
                                          ),
                                          height: 20,
                                          width: 20,
                                          color: AppTheme.white,
                                        ),
                                        Text(Strings.help,
                                            style: styleRegular(fontSize: 10))
                                      ],
                                    )),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        primary: AppTheme.white,
                                        backgroundColor: AppTheme.colorPrimary),
                                    onPressed: () {
                                      showLogoutDialog();
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            'assets/icons/logout.png',
                                          ),
                                          height: 20,
                                          width: 20,
                                          color: AppTheme.white,
                                        ),
                                        Text(Strings.logout,
                                            style: styleRegular(fontSize: 10))
                                      ],
                                    )),
                              ],
                            ))
                      ],
                    )))),
        bottomNavigationBar: Container(
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
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(
                        image: AssetImage(
                          'assets/icons/home.png',
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
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(
                        image: AssetImage(
                          'assets/icons/lead.png',
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
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(
                        image: AssetImage(
                          'assets/icons/appointment_home.png',
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
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(
                        image: AssetImage(
                          'assets/icons/task.png',
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
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(
                        image: AssetImage(
                          'assets/icons/settings.png',
                        ),
                        color: AppTheme.white,
                        height: 30,
                        width: 30,
                      ),
                    ))
              ],
            )),
        body: WillPopScope(child: Home(), onWillPop: onWillPop));
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToast('Press back again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }

  void callLogoutApi() {
    showProgress();
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {
        'LoginId': UserDetails.userName,
        'DeviceId': UserDetails.fcmToken
      }
    };
    ApiCall.makeApiCall(
        ApiRequest.LOGOUT, params, Method.POST, ApiConstants.LOGOUT, this);
  }

  void getBalance() {
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {'UserId': UserDetails.userId}
    };
    ApiCall.makeApiCall(ApiRequest.GET_BALANCE, params, Method.POST,
        ApiConstants.GET_BALANCE, this);
  }

  @override
  void onError(String errorResponse, int responseCode, int requestCode) {
    debugPrint(
        "Msg: ${errorResponse} Response Code ${responseCode} Request Code ${requestCode}");
    switch (requestCode) {
      case ApiRequest.LOGOUT:
        hideProgress();
        //showErrorDialog(Strings.error, errorResponse);
        gotoLoginPage();
        break;
    }
  }

  @override
  void onTokenExpired(String errorResponse, int responseCode, int requestCode) {
    switch (requestCode) {
      case ApiRequest.LOGOUT:
        hideProgress();
        gotoLoginPage();
        break;
    }
  }

  @override
  void onResponse(String response, int responseCode, int requestCode) {
    debugPrint(
        "Data: ${response} Response Code ${responseCode} Request Code ${requestCode}");
    switch (requestCode) {
      case ApiRequest.LOGOUT:
        hideProgress();
        gotoLoginPage();
        break;
      case ApiRequest.GET_BALANCE:
        var jsonData = json.decode(response);
        final balanceData = NavMenuBalance.fromJson(jsonData);
        if (balanceData.status == 1) {
          setState(() {
            creditBalance =
                balanceData.details!.intCreditBalance.toStringAsFixed(2);
            mailBalance =
                balanceData.details!.mailCreditBalance.toStringAsFixed(0);
            smsBalance =
                balanceData.details!.smsCreditBalance!.toStringAsFixed(0);
          });
        }
        break;
    }
  }

  void gotoLoginPage() {
    changeSystemUiColor(
        statusBarColor: Colors.transparent,
        brightness: Brightness.dark,
        navBarColor: Colors.white);
    AppPref.clearUserPref();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (Route<dynamic> route) => false,
    );
  }
}
