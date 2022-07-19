import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:system_alert_window/system_alert_window.dart';
import '../../model/login_data.dart';
import '../../network/api_call.dart';
import '../../network/api_constants.dart';
import '../../network/api_response.dart';
import '../../network/method.dart';
import '../../ui/web_view_page.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_prefs.dart';
import '../../utils/app_utils.dart';
import '../../utils/arguments.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import '../../ui/home/dashboard.dart';
import '../../ui/login_signup/enter_signup_email.dart';
import '../../ui/login_signup/forgot_password.dart';
import '../../utils/app_theme.dart';
import '../../utils/strings.dart';
import '../../base_class.dart';
import '../../utils/two_button_dialog.dart';

class Login extends StatefulWidget {
  static String tag = 'login';

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends BaseClass<Login> implements ApiResponse {
  var appVersion = '',
      osVersion = '',
      deviceModelName = '',
      isValidUName = true,
      isValidPassword = true,
      fcmToken = '';
  late TextEditingController _etUserName, _etPassword;

  late final FirebaseMessaging _messaging;
  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();
    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FirebaseMessaging.instance.getToken().then((value) {
        fcmToken = value!;
        //print(fcmToken);
      });
      // TODO: handle the received notifications
/*       FirebaseMessaging.onMessage.listen((msg) {
        print(msg.data);
      }); */
    } else {
      print('User declined or has not accepted permission');
    }
  }

  SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
    registerNotification();
    _etUserName = TextEditingController();
    _etUserName.addListener(() {
      setState(() {
        isValidUName = true;
      });
    });
    _etPassword = TextEditingController();
    _etPassword.addListener(() {
      setState(() {
        isValidPassword = true;
      });
    });
  }

  Future<bool> requestPermission1() async {
    var status1 = await Permission.location.request();

    switch (status1) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        return false;
      case PermissionStatus.granted:
        return true;
    }
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

  Future<void> _requestPermissions() async {
    await SystemAlertWindow.requestPermissions(prefMode: prefMode);
  }

  Future<void> getDeviceInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    appVersion = version;

    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      osVersion = "$release (SDK $sdkInt)";
      deviceModelName = "$manufacturer $model";
      //debugPrint('Android $release (SDK $sdkInt), $manufacturer $model');
    }

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      var model = iosInfo.model;
      osVersion = version!;
      deviceModelName = name!;
      //debugPrint('$systemName $version, $name $model');
    }
  }

  @override
  Widget build(BuildContext context) {
    changeSystemUiColor(statusBarColor: Colors.transparent);

    final etUserName = TextField(
      controller: _etUserName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          fillColor: AppTheme.white,
          filled: true,
          enabledBorder: getBorder(
              isValidUName ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          focusedBorder: getBorder(
              isValidUName ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          suffixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Image(
              image: AssetImage(
                'assets/icons/username.png',
              ),
              height: 20,
              width: 20,
              color: AppTheme.colorDarkGrey,
            ),
          ),
          hintText: Strings.userName,
          counterStyle: styleLightColor(Colors.red, fontSize: 10),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15)),
    );

    final etPassword = TextField(
      controller: _etPassword,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
          fillColor: AppTheme.white,
          filled: true,
          enabledBorder: getBorder(
              isValidPassword ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          focusedBorder: getBorder(
              isValidPassword ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          suffixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Image(
              image: AssetImage(
                'assets/icons/password.png',
              ),
              height: 20,
              width: 20,
              color: AppTheme.colorDarkGrey,
            ),
          ),
          hintText: Strings.userPass,
          counterStyle: styleLightColor(Colors.red, fontSize: 10),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15)),
    );

    final btTermPrivacy = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Strings.signInTermMsg),
        TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                primary: AppTheme.colorRipple,
                backgroundColor: AppTheme.appBgColor),
            onPressed: () {
              Navigator.pushNamed(context, WebViewPage.tag, arguments: {
                Arguments.TITLE: Strings.termAndPrivacy,
                Arguments.URL: AppConstants.TERM_PRIVACY_URL
              });
            },
            child: Text(
              Strings.termAndPrivacy,
              style: styleMediumColor(AppTheme.colorPrimary),
            ))
      ],
    );

    final btNoAccount = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Strings.dontHaveAccount),
        TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                primary: AppTheme.colorRipple,
                backgroundColor: AppTheme.appBgColor),
            onPressed: () {
              Navigator.pushNamed(context, EnterSignupEmail.tag);
            },
            child: Text(
              Strings.signUpNow,
              style: styleMediumColor(AppTheme.colorPrimary),
            ))
      ],
    );

    final btForgotPass = TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            primary: AppTheme.colorRipple),
        onPressed: () {
          Navigator.pushNamed(context, ForgotPassword.tag);
        },
        child: Text(
          Strings.forgotPass,
          style: styleMediumColor(AppTheme.black),
        ));

    final btLogin = OutlinedButton(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            Strings.loginNow,
            style: const TextStyle(color: AppTheme.white),
          ),
        ),
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            side: const BorderSide(width: 1.0, color: AppTheme.colorPrimary),
            primary: AppTheme.white,
            backgroundColor: AppTheme.colorPrimary),
        onPressed: () {
          doLogin();
          requestPermission();
          _requestPermissions();
          requestPermission1();
        });

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Image.asset(
              'assets/images/bg.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          'assets/images/logobig512.png',
                          height: 150,
                        ),
                      ),
                      getVerticalGap(),
                      Text(
                        Strings.login,
                        style: styleBold(fontSize: 25),
                      ),
                      Text(Strings.loginMsg),
                      getVerticalGap(height: 50),
                      etUserName,
                      getVerticalGap(),
                      etPassword,
                      getVerticalGap(height: 30),
                      btTermPrivacy,
                      getVerticalGap(height: 20),
                      Center(
                        child: btForgotPass,
                      ),
                      getVerticalGap(height: 50),
                      btLogin,
                      getVerticalGap(height: 30),
                      btNoAccount
                    ]))
          ],
        ));
  }

  void doLogin() {
    hideKeyBoard();
    if (validateInput()) {
      showProgress();
      final Map<String, dynamic> params = {
        'Status': '',
        'Message': '',
        'Details': {
          'LoginName': _etUserName.text.trim(),
          'Password': _etPassword.text.trim(),
          'Url': AppConstants.PARAM_URL,
          'DeviceId': fcmToken,
          'AppVersion': appVersion,
          'OSVersion': osVersion,
          'OSName': Platform.isAndroid ? 'Android' : 'iOS',
          'ModelName': deviceModelName
        }
      };
      ApiCall.makeApiCall(
          ApiRequest.LOGIN, params, Method.POST, ApiConstants.LOGIN, this);
    }
  }

  bool validateInput() {
    bool valid = true;
    if (_etUserName.text.isEmpty) {
      valid = false;
      setState(() {
        isValidUName = false;
      });
    }
    if (_etPassword.text.isEmpty) {
      valid = false;
      setState(() {
        isValidPassword = false;
      });
    }
    if (!valid) {
      showErrorDialog(
          Strings.error, "${Strings.enterUserName} & ${Strings.password}");
    }
    return valid;
  }

  @override
  void onError(String errorResponse, int responseCode, int requestCode) {
    debugPrint(
        "Msg: ${errorResponse} Response Code ${responseCode} Request Code ${requestCode}");
    hideProgress(changestatusBarColor: false);
    showErrorDialog(Strings.error, errorResponse);
  }

  @override
  void onResponse(String response, int responseCode, int requestCode) {
    debugPrint(
        "Data: ${response} Response Code ${responseCode} Request Code ${requestCode}");
    hideProgress(changestatusBarColor: false);
    var jsonData = json.decode(response);
    switch (requestCode) {
      case ApiRequest.LOGIN:
        jsonData["Details"]["User_Name"] = _etUserName.text.trim();
        jsonData["Details"]["fcmToken"] = fcmToken;
        gotoHome(jsonData);
        break;
      case ApiRequest.RE_LOGIN:
        jsonData["Details"]["User_Name"] = _etUserName.text.trim();
        jsonData["Details"]["fcmToken"] = fcmToken;
        gotoHome(jsonData);
        break;
    }
  }

  void showAlreadyLoggedInDialog(String title) {
    changeSystemUiColor(
        statusBarColor: Colors.transparent,
        navBarColor: Colors.black.withOpacity(0.6));
    var dialog = TwoButtonDialog(
        title: title,
        message: Strings.loginToThisDeviceMsg,
        positiveBtnText: Strings.yes,
        negativeBtnText: Strings.no,
        onPostivePressed: () {
          changeSystemUiColor(
              statusBarColor: Colors.transparent, brightness: Brightness.dark);
          callResetLogInApi();
        },
        onNegativePressed: () {
          changeSystemUiColor(
              statusBarColor: Colors.transparent, brightness: Brightness.dark);
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

  void callResetLogInApi() {
    hideKeyBoard();
    if (validateInput()) {
      showProgress();
      final Map<String, dynamic> params = {
        'Status': '',
        'Message': '',
        'Details': {
          'LoginName': _etUserName.text.trim(),
          'Password': _etPassword.text.trim(),
          'Url': AppConstants.PARAM_URL,
          'DeviceId': fcmToken,
          'AppVersion': appVersion,
          'OSVersion': osVersion,
          'OSName': Platform.isAndroid ? 'Android' : 'iOS',
          'ModelName': deviceModelName
        }
      };
      ApiCall.makeApiCall(ApiRequest.RE_LOGIN, params, Method.POST,
          ApiConstants.RE_LOGIN, this);
    }
  }

  void gotoHome(dynamic jsonData) {
    final v = LoginData.fromJson(jsonData);
    if (v.details?.authenticationResponse?.id == 1) {
      AppPref.setUserData(jsonEncode(jsonData));
      AppUtils.setUserData(v);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
        (Route<dynamic> route) => false,
      );
    } else if (v.details?.authenticationResponse?.id == -3) {
      showAlreadyLoggedInDialog(v.details!.authenticationResponse!.text!);
    } else {
      showErrorDialog(Strings.error, v.details!.authenticationResponse!.text!);
    }
  }

  @override
  void onTokenExpired(String errorResponse, int responseCode, int requestCode) {
    // TODO: implement onTokenExpired
  }
}
