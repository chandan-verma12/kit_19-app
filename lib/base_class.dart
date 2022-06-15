import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'model/home_calendar_data.dart';
import 'ui/login_signup/login.dart';
import 'utils/app_constants.dart';
import 'utils/app_prefs.dart';
import 'utils/app_theme.dart';
import 'utils/string_extention.dart';
import 'utils/one_button_dialog.dart';
import 'utils/strings.dart';

abstract class BaseClass<T extends StatefulWidget> extends State<T> {
  BaseClass() {}

  bool isProgress = false;
  final underLineBorder = const UnderlineInputBorder(
    borderSide: BorderSide(color: AppTheme.colorDarkGrey),
  );

  Widget getErrorIcon(bool isValid) {
    return Icon(Icons.error_outline,
        color: isValid ? Colors.transparent : AppTheme.colorRed);
  }

  void showError(String errorResponse) {
    try {
      var jsonData = json.decode(errorResponse);
      showErrorDialog(Strings.error, jsonData['Message']);
    } catch (e) {
      showErrorDialog(Strings.error, errorResponse);
    }
  }

  Widget loadImage(String? url) {
    if (url != null) {
      return FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          placeholder: "assets/icons/user.png",
          fadeInDuration: const Duration(milliseconds: 500),
          fadeInCurve: Curves.easeInExpo,
          fadeOutCurve: Curves.easeOutExpo,
          image: url,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset("assets/icons/user.png");
          });
    } else {
      return Image.asset("assets/icons/user.png");
    }
  }

  getPopUpMenus(Tasks? task) {
    List<PopupMenuEntry<int>> menus = [];
    menus.add(PopupMenuItem<int>(
      height: 0,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          const Image(
            image: AssetImage(
              'assets/icons/mnu_add.png',
            ),
            height: 18,
            width: 18,
          ),
          getHorizontalGap(width: 10),
          Text('Add', style: styleLightColor(AppTheme.black))
        ],
      ),
      value: AppConstants.MNU_ADD,
    ));
    if (task!.isEditable!) {
      menus.add(PopupMenuItem<int>(
        height: 0,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            const Image(
              image: AssetImage(
                'assets/icons/mnu_edit.png',
              ),
              height: 18,
              color: AppTheme.black,
              width: 18,
            ),
            getHorizontalGap(width: 10),
            Text('Edit', style: styleLightColor(AppTheme.black))
          ],
        ),
        value: AppConstants.MNU_EDIT,
      ));
      menus.add(PopupMenuItem<int>(
        height: 0,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            const Image(
              image: AssetImage(
                'assets/icons/mnu_attach.png',
              ),
              height: 18,
              width: 18,
            ),
            getHorizontalGap(width: 10),
            Text('Attach', style: styleLightColor(AppTheme.black))
          ],
        ),
        value: AppConstants.MNU_ATTACH,
      ));
    }
    if (task.isRemoval!) {
      menus.add(PopupMenuItem<int>(
        height: 10,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            const Image(
              image: AssetImage(
                'assets/icons/mnu_delete.png',
              ),
              height: 18,
              width: 18,
            ),
            getHorizontalGap(width: 10),
            Text('Delete', style: styleLightColor(AppTheme.black))
          ],
        ),
        value: AppConstants.MNU_DELETE,
      ));
    }
    return menus;
  }

  void changeSystemUiColor(
      {Color statusBarColor = Colors.white,
      Color navBarColor = Colors.white,
      brightness = Brightness.dark}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: navBarColor, // navigation bar color
      statusBarColor: statusBarColor, // status bar color
      statusBarIconBrightness: brightness, // status bar icon color
      systemNavigationBarIconBrightness:
          Brightness.dark, // color of navigation controls
    ));
  }

  void launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  getOutComeColor(String? intent) {
    Color c = AppTheme.colorNutral;
    if (intent != null) {
      switch (intent) {
        case AppConstants.NEUTRAL:
          c = AppTheme.colorNutral;
          break;
        case AppConstants.POSITIVE:
          c = AppTheme.colorPositive;
          break;
        case AppConstants.NEGATIVE:
          c = AppTheme.colorNegative;
          break;
      }
    }
    return c;
  }

  //completed
  getStatusColor(String? status) {
    Color c = AppTheme.colorNutral;
    if (status != null) {
      switch (status.toLowerCase()) {
        case 'open':
          c = AppTheme.colorNutral;
          break;
        case 'completed':
          c = AppTheme.colorPositive;
          break;
        default:
          c = AppTheme.colorNegative;
          break;
      }
    }
    return c;
  }

  void showPriviledgeDialog() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        )),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon:
                                const Icon(Icons.close, color: AppTheme.black)),
                      ),
                      Image.asset('assets/icons/no_priviledge.png', width: 96),
                      getVerticalGap(height: 5),
                      Text(
                        Strings.noPriviledge,
                        style: styleBold(),
                        textAlign: TextAlign.center,
                      )
                    ])));
          });
        });
  }

  bool equalsIgnoreCase(String? a, String? b) =>
      (a == null && b == null) ||
      (a != null && b != null && a.toLowerCase() == b.toLowerCase());

  int generateOtp() {
    var rng = Random();
    return rng.nextInt(900000) + 100000;
  }

  getBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: color,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(100.0),
    );
  }

  Widget getVerticalGap({double height = 20}) {
    return SizedBox(height: height);
  }

  Widget getHorizontalGap({double width = 20}) {
    return SizedBox(width: width);
  }

  Widget getHorizontalLine({double height = 1, Color color = Colors.grey}) {
    return Container(
      height: height,
      color: color,
    );
  }

  TextStyle styleBold({double fontSize = 13}) {
    return TextStyle(fontFamily: 'PB', fontSize: fontSize);
  }

  TextStyle styleMedium({double fontSize = 13}) {
    return TextStyle(fontFamily: 'PM', fontSize: fontSize);
  }

  TextStyle styleLight({double fontSize = 13}) {
    return TextStyle(fontFamily: 'PL', fontSize: fontSize);
  }

  TextStyle styleRegular({double fontSize = 13}) {
    return TextStyle(fontFamily: 'PR', fontSize: fontSize);
  }

  TextStyle styleBoldColor(Color color, {double fontSize = 13}) {
    return TextStyle(fontFamily: 'PB', fontSize: fontSize, color: color);
  }

  TextStyle styleMediumColor(Color color, {double fontSize = 13}) {
    return TextStyle(fontFamily: 'PM', fontSize: fontSize, color: color);
  }

  TextStyle styleLightColor(Color color,
      {double fontSize = 13, Color backgroundColor = Colors.transparent}) {
    return TextStyle(
        fontFamily: 'PL',
        fontSize: fontSize,
        color: color,
        backgroundColor: backgroundColor);
  }

  TextStyle styleRegularColor(Color color, {double fontSize = 13}) {
    return TextStyle(fontFamily: 'PR', fontSize: fontSize, color: color);
  }

  void hideKeyBoard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  getDateTime(String? dateTime, String inputFormat,
      {String outPutFormat = 'MMMM yy'}) {
    if (dateTime != null && dateTime.isNotEmpty) {
      return DateFormat(outPutFormat)
          .format(DateFormat(inputFormat).parse(dateTime));
    } else {
      return "";
    }
  }

  getFormatedDateTime(DateTime dateTime, {String outPutFormat = 'MMMM yyyy'}) {
    return DateFormat(outPutFormat).format(dateTime);
  }

  DateTime getDateTimeFromString(String dateTimeString, String inputFormat) {
    var dt = DateTime.now();
    dt = DateFormat(inputFormat).parse(dateTimeString);
    return dt;
  }

  getString(String? val, {String? defVal}) {
    var data = "";
    if (val != null) {
      data = val;
    } else {
      if (defVal != null) {
        data = defVal;
      }
    }
    //print(data);
    return data.toCapitalized();
  }

  void showInvalidTokenDialog(String title,
      {bool changeStatusColor = false,
      Color color = AppTheme.colorPrimary,
      BuildContext? bContext}) {
    changeSystemUiColor(statusBarColor: Colors.transparent);
    var dialog = OneButtonDialog(
        title: title,
        message: Strings.invalidTokenMsg,
        positiveBtnText: 'OK',
        onPostivePressed: () {
          AppPref.clearUserPref();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login()),
            (Route<dynamic> route) => false,
          );
        });
    showDialog(
        context: context,
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

  String countryCodeToEmoji(String countryCode) {
    // 0x41 is Letter A
    // 0x1F1E6 is Regional Indicator Symbol Letter A
    // Example :
    // firstLetter U => 20 + 0x1F1E6
    // secondLetter S => 18 + 0x1F1E6
    // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  void showErrorDialog(String title, String msg,
      {bool changeStatusColor = false,
      Color color = AppTheme.colorPrimary,
      BuildContext? bContext}) {
    changeSystemUiColor(statusBarColor: Colors.transparent);
    var dialog = OneButtonDialog(
        title: title,
        message: msg,
        positiveBtnText: 'OK',
        onPostivePressed: () {
          if (changeStatusColor) {
            changeSystemUiColor(
                statusBarColor: color,
                brightness: Brightness.light,
                navBarColor: Colors.white);
          }
          if (bContext != null) {
            Navigator.pop(bContext);
          }
        });
    showDialog(
        context: context,
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

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black.withAlpha(160),
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 17.0);
  }

  void hideProgress(
      {bool changestatusBarColor = true,
      Color statusBarColor = AppTheme.colorPrimary}) {
    isProgress = false;
    if (changestatusBarColor) {
      changeSystemUiColor(
          statusBarColor: statusBarColor, brightness: Brightness.light);
    }
    Navigator.pop(context);
  }

  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  getProgressView() {
    return Center(
        child: Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      child: const SpinKitFadingCircle(
        color: AppTheme.white,
        size: 34,
      ),
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: AppTheme.colorPrimary),
    ));
  }

  void showProgress() {
    isProgress = true;
    changeSystemUiColor(
        statusBarColor: Colors.transparent,
        navBarColor: AppTheme.white.withOpacity(0.9));
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
          child: Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        child: const SpinKitFadingCircle(
          color: AppTheme.white,
          size: 34,
        ),
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: AppTheme.colorPrimary),
      )),
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: true,
      barrierColor: AppTheme.white.withOpacity(0.9),
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: alert);
      },
    );
  }

  PreferredSizeWidget getAppBar(
    String title, {
    Color iconColor = AppTheme.black,
    Color bgColor = AppTheme.white,
  }) {
    return AppBar(
        iconTheme: IconThemeData(color: iconColor),
        centerTitle: false,
        title: Text(title,
            style: styleRegularColor(
              iconColor,
            )),
        backgroundColor: bgColor,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(Icons.arrow_back_ios),
        ),
        elevation: 0.0);
  }

  /*

  PreferredSizeWidget getAppBar(String title, BuildContext context,
      {int cartCount = 0,
      bool actionClickable = true,
      bool isForProfile = false,
      bool showCart = true}) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppTheme.black),
      actionsIconTheme: const IconThemeData(color: AppTheme.colorPrimary),
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          title,
          style: styleBoldColor(AppTheme.black, fontSize: 20),
        ),
      ),
      backgroundColor: AppTheme.appBgColor,
      elevation: 0.0,
      actions: [
        showCart
            ? isForProfile
                ? IconButton(
                    padding: const EdgeInsets.only(right: 10),
                    onPressed: () {
                      Navigator.pushNamed(context, ProfileEdit.tag);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: AppTheme.colorPrimary,
                    ))
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: IconButton(
                        onPressed: () {
                          if (actionClickable) {
                            Navigator.pushNamed(context, MyCart.tag);
                          }
                        },
                        iconSize: 26,
                        icon: Stack(
                          children: [
                            const Center(
                              child: ImageIcon(
                                AssetImage("assets/icons/ic_bag.png"),
                              ),
                            ),
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 11),
                              child: Text(
                                "$cartCount",
                                style: styleBoldColor(AppTheme.white,
                                    fontSize: 10),
                              ),
                            ))
                          ],
                        )))
            : Container()
      ],
    );
  }

  void hideKeyBoard() {
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

  getString(String? val, {String? defVal}) {
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

  void setUserData(LoginResponse v) {
    UserDetails.id = v.userData!.id!;
    UserDetails.token = v.token!;
    UserDetails.fullName = v.userData!.fullName!;
    UserDetails.mobile = v.userData!.mobileNumber!;
    UserDetails.emailAddress = v.userData!.eMail!;
    UserDetails.address = v.userData!.address!;
  }

  void showErrorDialog(String title, String msg) {
    var dialog = OneButtonDialog(
        title: title,
        message: msg,
        positiveBtnText: 'OK',
        onPostivePressed: () {});
    showDialog(
        context: context,
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

  void changeSystemUiColor(
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

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppTheme.colorPrimary,
        textColor: Colors.white,
        fontSize: 17.0);
  }

  void hideProgress() {
    Navigator.pop(context);
  }

  void showProgress() {
    //set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
          child: Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        child: const SpinKitFadingCircle(
          color: AppTheme.white,
          size: 34,
        ),
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: AppTheme.colorPrimary),
      )),
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: true,
      barrierColor: AppTheme.appBgColor.withOpacity(0.9),
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: alert);
      },
    ); 
  }*/
}
