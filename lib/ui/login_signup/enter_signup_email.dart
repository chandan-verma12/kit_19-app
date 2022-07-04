// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../network/api_call.dart';
import '../../network/api_constants.dart';
import '../../network/api_response.dart';
import '../../network/method.dart';
import '../../ui/login_signup/signup.dart';
import '../../utils/app_theme.dart';
import '../../utils/strings.dart';
import '../../base_class.dart';

class EnterSignupEmail extends StatefulWidget {
  static String tag = 'enter_signup_email';

  @override
  State<StatefulWidget> createState() {
    return _EnterSignupEmail();
  }
}

class _EnterSignupEmail extends BaseClass<EnterSignupEmail>
    implements ApiResponse {
  late TextEditingController _etEmailId;
  bool isValidEmail = true;

  @override
  void initState() {
    super.initState();
    _etEmailId = TextEditingController();
    _etEmailId.addListener(() {
      setState(() {
        isValidEmail = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    changeSystemUiColor(statusBarColor: Colors.transparent);

    final etEmailAddress = TextField(
      controller: _etEmailId,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          fillColor: AppTheme.white,
          filled: true,
          enabledBorder: getBorder(
              isValidEmail ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          focusedBorder: getBorder(
              isValidEmail ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          suffixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Image(
              image: AssetImage(
                'assets/icons/email.png',
              ),
              height: 20,
              width: 20,
              color: AppTheme.colorDarkGrey,
            ),
          ),
          hintText: Strings.emailAddress,
          counterStyle: styleLightColor(Colors.red, fontSize: 10),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15)),
    );

    final btHaveAccount = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Strings.alreadyHaveAccount),
        TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                primary: AppTheme.colorRipple,
                backgroundColor: AppTheme.appBgColor),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              Strings.loginNow,
              style: styleMediumColor(AppTheme.colorPrimary),
            ))
      ],
    );

    final btGetStarted = OutlinedButton(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            Strings.getStarted,
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
          checkEmailId();
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
                reverse: true,
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
                        Strings.signUp,
                        style: styleBold(fontSize: 25),
                      ),
                      Text(Strings.signUpMsg1),
                      getVerticalGap(height: 50),
                      etEmailAddress,
                      getVerticalGap(height: 50),
                      btGetStarted,
                      getVerticalGap(height: 30),
                      btHaveAccount
                    ]))
          ],
        ));
  }

  void checkEmailId() {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(_etEmailId.text.trim());
    hideKeyBoard();
    if (_etEmailId.text.trim().isNotEmpty && emailValid) {
      showProgress();
      final Map<String, dynamic> params = {
        'Status': '',
        'Message': '',
        'Details': {'EmailId': _etEmailId.text.trim()}
      };
      ApiCall.makeApiCall(ApiRequest.CHECK_EMAIL, params, Method.POST,
          ApiConstants.CHECK_EMAIL, this);
    } else {
      showErrorDialog(Strings.error, Strings.enterValidEmail);
      setState(() {
        isValidEmail = false;
      });
    }
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
    if (jsonData["Details"]["Id"] == 1) {
      Navigator.pushNamed(context, Signup.tag,
          arguments: _etEmailId.text.trim());
    } else {
      showErrorDialog(Strings.error, jsonData["Details"]["Text"]);
      setState(() {
        isValidEmail = false;
      });
    }
  }

  @override
  void onTokenExpired(String errorResponse, int responseCode, int requestCode) {
    // TODO: implement onTokenExpired
  }
}
