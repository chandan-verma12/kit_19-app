import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kit_19/model/LeadModel.dart';
import 'package:kit_19/model/lead_data.dart';
import '../model/login_data.dart';
import '../model/user_data.dart';
import 'app_theme.dart';

class AppUtils {
  static TextStyle styleBold({double fontSize = 13}) {
    return TextStyle(fontFamily: 'PB', fontSize: fontSize);
  }

  static TextStyle styleMedium({double fontSize = 13}) {
    return TextStyle(fontFamily: 'PM', fontSize: fontSize);
  }

  static TextStyle styleLight({double fontSize = 13}) {
    return TextStyle(fontFamily: 'PL', fontSize: fontSize);
  }

  static TextStyle styleRegular({double fontSize = 13}) {
    return TextStyle(fontFamily: 'PR', fontSize: fontSize);
  }

  static TextStyle styleBoldColor(Color color, {double fontSize = 13}) {
    return TextStyle(fontFamily: 'PB', fontSize: fontSize, color: color);
  }

  static TextStyle styleMediumColor(Color color, {double fontSize = 13}) {
    return TextStyle(fontFamily: 'PM', fontSize: fontSize, color: color);
  }

  static TextStyle styleLightColor(Color color, {double fontSize = 13}) {
    return TextStyle(fontFamily: 'PL', fontSize: fontSize, color: color);
  }

  static TextStyle styleRegularColor(Color color, {double fontSize = 13}) {
    return TextStyle(fontFamily: 'PR', fontSize: fontSize, color: color);
  }

  static Widget getVerticalGap({double height = 20}) {
    return SizedBox(height: height);
  }

  static Widget getHorizontalGap({double width = 20}) {
    return SizedBox(width: width);
  }

  static Widget getHorizontalLine(
      {double height = 1, Color color = AppTheme.colorGrey}) {
    return Container(
      height: height,
      color: color,
    );
  }

  static changeSystemUiColor(
      {Color statusBarColor = AppTheme.appBgColor,
      Color navBarColor = AppTheme.appBgColor}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: navBarColor, // navigation bar color
      statusBarColor: statusBarColor, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icon color
      systemNavigationBarIconBrightness:
          Brightness.dark, // color of navigation controls
    ));
  }

  static setUserData(LoginData v) {
    UserDetails.token = v.details!.token!;
    UserDetails.url = v.details!.url!;
    UserDetails.userId = v.details!.userId!;
    UserDetails.eMail = v.details!.eMail!;
    UserDetails.fName = v.details!.fName!;
    UserDetails.lLName = v.details!.lName!;
    UserDetails.mobile = v.details!.mobile!;
    UserDetails.profilePicturePath = v.details!.profilePicturePath!;
    UserDetails.parentID = v.details!.parentId!;
    UserDetails.teamCode = v.details!.teamCode!;
    UserDetails.roleCode = v.details!.roleCode!;
    UserDetails.sipUrl = v.details!.sipUrl!;
    UserDetails.sipUser = v.details!.sipUser!;
    UserDetails.sipPwd = v.details!.sipPwd!;
    UserDetails.fcmToken = v.details!.fcmToken!;
    UserDetails.userName = v.details!.userName!;
  }

  // static setLeadData(LeadListModel u) {
  //   LeadDetails.id = u.details!.data!.id!;
  //   LeadDetails.createdDate = u.details!.data!.createdDate!;
  //   LeadDetails.csvEmailId = u.details!.data!.csvEmailId!;
  //   LeadDetails.csvMobileNo = u.details!.data!.csvMobileNo!;
  //   LeadDetails.currentScore = u.details!.data!.currentScore!;
  //   LeadDetails.htmlStatus = u.details!.data!.htmlStatus!;
  //   LeadDetails.followupDate = u.details!.data!.followupDate!;
  //   LeadDetails.image = u.details!.data!.image!;
  //   LeadDetails.personName = u.details!.data!.personName!;
  //   LeadDetails.leadNo = u.details!.data!.leadNo!;
  //   LeadDetails.profitLoss = u.details!.data!.profitLoss!;
  //   LeadDetails.thresholdColor = u.details!.data!.thresholdColor!;
  //   LeadDetails.latitude = u.details!.data!.latitude!;
  //   LeadDetails.longitude = u.details!.data!.longitude!;
  // }

  static void hideKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  getDateTime(String dateTime) {
    //2021-12-05 05:39:49
    return DateFormat('yyyy-MM-dd | hh:mm:ss a')
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateTime));
  }

  static getString(String? val, {String? defVal}) {
    var data = "";
    if (val != null) {
      data = val;
    } else {
      if (defVal != null) {
        data = defVal;
      }
    }
    return data;
  }
}
