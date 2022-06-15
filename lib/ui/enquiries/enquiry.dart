import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kit_19/ui/add_new_lead/new_lead.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kit_19/ui/enquiries/enq_list.dart';
import 'package:kit_19/ui/leads/lead_details/lead_widgets.dart';
import 'package:kit_19/ui/leads/widgets/lead_body.dart';
import 'package:kit_19/ui/search/search_screen.dart';

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
import '../home/home.dart';
import '../login_signup/login.dart';

class Enquiry extends StatefulWidget {
  static String tag = 'intro_slider';

  @override
  State<StatefulWidget> createState() {
    return _Enquiry();
  }
}

class _Enquiry extends BaseClass<Enquiry> implements ApiResponse {
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey();
  var creditBalance = "0.0", smsBalance = "0.0", mailBalance = "0.0";

  @override
  void initState() {
    super.initState();
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
          title: const Text('Enquiry'),
          backgroundColor: AppTheme.colorPrimary,
          elevation: 0,
          actions: [
            IconButton(
              padding: const EdgeInsets.symmetric(vertical: 15),
              icon: Image.asset("assets/icons/search.png"),
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => SearchScreen()));
              },
            ),
            IconButton(
              padding: const EdgeInsets.symmetric(vertical: 13),
              icon: Image.asset("assets/icons/user-white.png"),
              onPressed: () {},
            )
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
                            onPressed: () {},
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
                              // Navigator.push(
                              //     context,
                              //     CupertinoPageRoute(
                              //         builder: (context) => LeadsScreen()));
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
                            onPressed: () {},
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
                            onPressed: () {},
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(children: [
                                  const Image(
                                    image: AssetImage(
                                      'assets/icons/callLog.png',
                                    ),
                                    height: 28,
                                    width: 28,
                                  ),
                                  getHorizontalGap(),
                                  Text(
                                    Strings.callLog,
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
                            onPressed: () {},
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(children: [
                                  const Image(
                                    image: AssetImage(
                                      'assets/icons/settings2.png',
                                    ),
                                    height: 28,
                                    width: 28,
                                  ),
                                  getHorizontalGap(),
                                  Text(
                                    Strings.settings,
                                    style: styleRegularColor(AppTheme.black),
                                  )
                                ]))),
                        getHorizontalLine(),
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
        floatingActionButton: SpeedDial(
          spaceBetweenChildren: 10,
          icon: Icons.add,
          activeIcon: Icons.cancel_outlined,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          )),
          children: [
            SpeedDialChild(
              child: Icon(Icons.upload),
              label: 'Import from XLS',
            ),
            SpeedDialChild(
              child: Icon(Icons.download),
              label: 'Export',
            ),
            SpeedDialChild(
              child: Icon(Icons.group),
              label: 'New Enquiry',
              onTap: () {
                // Navigator.push(context,
                //     CupertinoPageRoute(builder: (context) => NewLead()));
              },
            ),
          ],
        ),
        body: WillPopScope(child: EnquiryListAPi(), onWillPop: onWillPop));
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
