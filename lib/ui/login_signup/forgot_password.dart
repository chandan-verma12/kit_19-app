import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../network/api_response.dart';
import '../../utils/app_constants.dart';
import '../../model/country.dart';
import '../../network/api_call.dart';
import '../../network/api_constants.dart';
import '../../network/method.dart';
import '../../utils/app_theme.dart';
import '../../utils/country_codes.dart';
import '../../utils/strings.dart';
import '../../base_class.dart';
import 'enter_signup_email.dart';

class ForgotPassword extends StatefulWidget {
  static String tag = 'forgot_password';

  @override
  State<StatefulWidget> createState() {
    return _ForgotPassword();
  }
}

class _ForgotPassword extends BaseClass<ForgotPassword> implements ApiResponse {
  var isValidEmail = true, isValidMobile = true;
  late TextEditingController _etEmail, _etMobile, textController;
  var countryCode = "+91", countryFlag = "";
  late List<Country> _countryList;
  late List<Country> _tempCountryList;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    countryFlag = countryCodeToEmoji("IN");
    _countryList =
        countryCodes.map((country) => Country.fromJson(country)).toList();
    _tempCountryList =
        countryCodes.map((country) => Country.fromJson(country)).toList();
    _etEmail = TextEditingController();
    _etEmail.addListener(() {
      setState(() {
        isValidEmail = true;
      });
    });

    _etMobile = TextEditingController();
    _etMobile.addListener(() {
      setState(() {
        isValidMobile = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    changeSystemUiColor(statusBarColor: Colors.transparent);

    final etEmailAddress = TextField(
      controller: _etEmail,
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 15)),
    );

    final btCountryCode = TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            primary: AppTheme.colorRipple,
            backgroundColor: AppTheme.appBgColor),
        onPressed: () {
          changeSystemUiColor(statusBarColor: Colors.transparent);
          _showCountryPicker(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(countryFlag, style: styleRegular(fontSize: 18)),
            getHorizontalGap(width: 10),
            Text(countryCode,
                style: styleRegularColor(AppTheme.black, fontSize: 16)),
            getHorizontalGap(width: 10),
            Container(width: 1, height: 25, color: AppTheme.colorDarkGrey)
          ],
        ));

    final etMobile = TextField(
      controller: _etMobile,
      keyboardType: TextInputType.number,
      maxLength: 10,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
          counterText: '',
          fillColor: AppTheme.white,
          filled: true,
          isDense: true,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          focusedBorder: getBorder(
              isValidMobile ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          enabledBorder: getBorder(
              isValidMobile ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          suffixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Image(
              image: AssetImage(
                'assets/icons/mobile-app.png',
              ),
              height: 20,
              width: 20,
              color: AppTheme.colorDarkGrey,
            ),
          ),
          hintText: Strings.mobileNo,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: btCountryCode,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15)),
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
              Navigator.pop(context);
              Navigator.pushNamed(context, EnterSignupEmail.tag);
            },
            child: Text(
              Strings.signUpNow,
              style: styleMediumColor(AppTheme.colorPrimary),
            ))
      ],
    );

    final btGetPassword = OutlinedButton(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            Strings.getPassword,
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
          getPassword();
        });

    final btCancel = OutlinedButton(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            Strings.cancel,
            style: const TextStyle(color: AppTheme.colorPrimary),
          ),
        ),
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            side: const BorderSide(width: 1.0, color: AppTheme.colorPrimary),
            primary: AppTheme.colorRipple,
            backgroundColor: AppTheme.white),
        onPressed: () {
          Navigator.pop(context);
        });

    final getPassAndCancel = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [btGetPassword, btCancel]);

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
                        Strings.forgotPass,
                        style: styleBold(fontSize: 25),
                      ),
                      Text(Strings.forgotPassMsg),
                      getVerticalGap(height: 50),
                      etEmailAddress,
                      getVerticalGap(),
                      etMobile,
                      getVerticalGap(height: 50),
                      getPassAndCancel,
                      getVerticalGap(height: 30),
                      btNoAccount
                    ]))
          ],
        ));
  }

  bool validateInput() {
    bool valid = true;
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(_etEmail.text.trim());
    if (_etEmail.text.isEmpty) {
      valid = false;
      setState(() {
        isValidEmail = false;
      });
    }
    if (_etMobile.text.isEmpty) {
      valid = false;
      setState(() {
        isValidMobile = false;
      });
    }

    if (!valid) {
      showErrorDialog(Strings.error, Strings.enterValidDetails);
    }

    return valid;
  }

  void _showCountryPicker(context) async {
    Country? country = await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
                initialChildSize: 0.65,
                minChildSize: 0.25,
                maxChildSize: 0.80,
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Column(children: [
                    Icon(
                      Icons.remove,
                      color: Colors.grey[600],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        child: TextField(
                            controller: textController,
                            decoration: InputDecoration(
                              hintText: Strings.search,
                              contentPadding: const EdgeInsets.all(8),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                    color: AppTheme.colorPrimary),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                    color: AppTheme.colorPrimary),
                              ),
                              prefixIcon: const Icon(Icons.search,
                                  color: AppTheme.colorPrimary),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _buildSearchList(value);
                              });
                            })),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: _countryList.length,
                        itemBuilder: (_, index) {
                          return TextButton(
                              style: TextButton.styleFrom(
                                  primary: AppTheme.colorRipple,
                                  backgroundColor: AppTheme.white),
                              onPressed: () {
                                Navigator.pop(context, _countryList[index]);
                              },
                              child: Row(
                                children: [
                                  getHorizontalGap(width: 10),
                                  Text(
                                    countryCodeToEmoji(
                                        _countryList[index].iso2Cc!),
                                    style: styleRegular(fontSize: 25),
                                  ),
                                  getHorizontalGap(),
                                  Flexible(
                                      child: Text(
                                    "+${_countryList[index].e164Cc}  ${_countryList[index].name}",
                                    style: styleRegularColor(AppTheme.black,
                                        fontSize: 14),
                                  ))
                                ],
                              ));
                        },
                      ),
                    )
                  ]);
                });
          });
        });
    if (country != null) {
      setState(() {
        countryCode = "+${country.e164Cc}";
        countryFlag = countryCodeToEmoji(country.iso2Cc!);
      });
      _countryList.clear();
      _countryList.addAll(_tempCountryList);
      textController.clear();
    }
  }

  _buildSearchList(String userSearchTerm) {
    _countryList.clear();
    for (int i = 0; i < _tempCountryList.length; i++) {
      if (_tempCountryList[i]
          .name!
          .toLowerCase()
          .contains(userSearchTerm.toLowerCase())) {
        _countryList.add(_tempCountryList[i]);
      }
    }
  }

  void getPassword() {
    hideKeyBoard();
    if (validateInput()) {
      showProgress();
      final Map<String, dynamic> params = {
        'Status': '',
        'Message': '',
        'Details': {
          "CountryCode": countryCode,
          "UsernameOrEmail": _etEmail.text.trim(),
          "MobileNo": _etMobile.text.trim(),
          "Url": AppConstants.PARAM_URL,
        }
      };
      ApiCall.makeApiCall(ApiRequest.FORGOT_PASSWORD, params, Method.POST,
          ApiConstants.FORGOT_PASSWORD, this);
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
    showErrorDialog(Strings.success, jsonData["Details"], bContext: context);
  }

  @override
  void onTokenExpired(String errorResponse, int responseCode, int requestCode) {
    // TODO: implement onTokenExpired
  }
}
