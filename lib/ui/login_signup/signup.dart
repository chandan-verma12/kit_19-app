import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../network/api_response.dart';
import '../../ui/login_signup/signup_done.dart';
import '../../utils/flutter_pin_code_fields.dart';
import '../../model/country.dart';
import '../../network/api_call.dart';
import '../../network/api_constants.dart';
import '../../network/method.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_theme.dart';
import '../../utils/arguments.dart';
import '../../utils/country_codes.dart';
import '../../utils/strings.dart';
import '../../base_class.dart';
import '../web_view_page.dart';

class Signup extends StatefulWidget {
  static String tag = 'signup';

  @override
  State<StatefulWidget> createState() {
    return _Signup();
  }
}

class _Signup extends BaseClass<Signup> implements ApiResponse {
  var agreeOrNot = false,
      resendOtp = false,
      isOtpSend = false,
      isValidFName = true,
      isValidLName = true,
      isValidMobile = true,
      isValidUName = true,
      isValidCName = true;
  late TextEditingController _etEmail,
      _etFName,
      _etLName,
      _etMobile,
      _etUserName,
      _etCompanyName;
  late List<Country> _countryList;
  late List<Country> _tempCountryList;
  final TextEditingController textController = TextEditingController();
  var countryCode = "+91",
      resendSecs = 0,
      countryFlag = "",
      enteredOtp = "",
      uniqueOtp = 0;
  Timer? timer;

  @override
  void dispose() {
    if (timer != null) timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    countryFlag = countryCodeToEmoji("IN");
    initWidgets();
    _countryList =
        countryCodes.map((country) => Country.fromJson(country)).toList();
    _tempCountryList =
        countryCodes.map((country) => Country.fromJson(country)).toList();
  }

  void initWidgets() {
    _etEmail = TextEditingController();
    _etFName = TextEditingController();
    _etFName.addListener(() {
      setState(() {
        isValidFName = true;
      });
    });
    _etLName = TextEditingController();
    _etLName.addListener(() {
      setState(() {
        isValidLName = true;
      });
    });
    _etMobile = TextEditingController();
    _etMobile.addListener(() {
      setState(() {
        isOtpSend = false;
        isValidMobile = true;
      });
    });
    _etMobile.addListener(() {
      setState(() {
        isValidMobile = true;
      });
    });
    _etUserName = TextEditingController();
    _etUserName.addListener(() {
      setState(() {
        isValidUName = true;
      });
    });
    _etCompanyName = TextEditingController();
    _etCompanyName.addListener(() {
      setState(() {
        isValidCName = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    changeSystemUiColor(statusBarColor: Colors.transparent);

    final emailId = ModalRoute.of(context)!.settings.arguments as String;
    _etEmail.text = emailId;

    final etEmailAddress = TextField(
      controller: _etEmail,
      readOnly: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          fillColor: AppTheme.white,
          filled: true,
          focusedBorder: getBorder(AppTheme.colorDarkGrey),
          border: getBorder(AppTheme.colorDarkGrey),
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

    final etUserName = TextField(
      controller: _etUserName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          fillColor: AppTheme.white,
          filled: true,
          focusedBorder: getBorder(
              isValidUName ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          enabledBorder: getBorder(
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 15)),
    );

    final etFirstName = TextField(
      controller: _etFName,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          fillColor: AppTheme.white,
          filled: true,
          enabledBorder: getBorder(
              isValidFName ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          focusedBorder: getBorder(
              isValidFName ? AppTheme.colorDarkGrey : AppTheme.colorRed),
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
          hintText: Strings.firstName,
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

    final etLastName = TextField(
      controller: _etLName,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          fillColor: AppTheme.white,
          filled: true,
          enabledBorder: getBorder(
              isValidLName ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          focusedBorder: getBorder(
              isValidLName ? AppTheme.colorDarkGrey : AppTheme.colorRed),
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
          hintText: Strings.lastName,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15)),
    );

    final etCompanyName = TextField(
      controller: _etCompanyName,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          fillColor: AppTheme.white,
          filled: true,
          focusedBorder: getBorder(
              isValidCName ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          enabledBorder: getBorder(
              isValidCName ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          suffixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Image(
              image: AssetImage(
                'assets/icons/companyName.png',
              ),
              height: 20,
              width: 20,
              color: AppTheme.colorDarkGrey,
            ),
          ),
          hintText: Strings.companyName,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15)),
    );

    final btTermPrivacy = Row(
      children: [
        Checkbox(
            value: agreeOrNot,
            checkColor: AppTheme.white,
            activeColor: AppTheme.colorPrimary,
            onChanged: (bool? v) {
              setState(() {
                agreeOrNot = v!;
              });
            }),
        Text(Strings.iAgreeTo),
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
              Navigator.pop(context);
            },
            child: Text(
              Strings.loginNow,
              style: styleMediumColor(AppTheme.colorPrimary),
            ))
      ],
    );

    final btSignupNow = OutlinedButton(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            Strings.signUpNow,
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
          getOtp();
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

    final signupNowAndCancel = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [btSignupNow, btCancel]);

    final signupView = Column(children: [
      btTermPrivacy,
      getVerticalGap(),
      signupNowAndCancel,
      getVerticalGap(height: 30),
      btHaveAccount
    ]);

    final otpFields = PinCodeFields(
      length: 6,
      fieldBorderStyle: FieldBorderStyle.Square,
      responsive: true,
      fieldHeight: 45.0,
      fieldWidth: 45.0,
      borderWidth: 1.0,
      activeBorderColor: AppTheme.colorPrimary,
      activeBackgroundColor: AppTheme.white,
      borderRadius: BorderRadius.circular(5.0),
      keyboardType: TextInputType.number,
      autoHideKeyboard: true,
      obscureText: false,
      fieldBackgroundColor: AppTheme.white,
      borderColor: AppTheme.colorDarkGrey,
      textStyle: const TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
      ),
      onComplete: (output) {
        debugPrint(output);
        enteredOtp = output;
      },
      onChange: (v) {
        debugPrint(v);
        enteredOtp = v;
      },
    );

    final btResendCode = Row(
      children: [
        Text(Strings.didntReceive),
        TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                primary: AppTheme.colorRipple,
                backgroundColor: AppTheme.appBgColor),
            onPressed: () {
              if (resendOtp) {
                print('Resend OTP');
                getOtp();
              }
            },
            child: Text(
              Strings.resendCode,
              style: styleMediumColor(AppTheme.colorPrimary),
            )),
        const Spacer(),
        resendSecs > 1
            ? Text(
                "$resendSecs sec Left",
                style: styleRegular(fontSize: 12),
              )
            : Container(),
      ],
    );

    final btVerifyNow = OutlinedButton(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            Strings.verifyNow,
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
          validateOtp();
        });

    final verifyView =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      getVerticalGap(),
      Text(Strings.otpMsg, style: styleMedium()),
      getVerticalGap(height: 10),
      otpFields,
      getVerticalGap(height: 10),
      btResendCode,
      getVerticalGap(),
      btVerifyNow
    ]);

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
                      Text(Strings.signUpMsg2),
                      getVerticalGap(height: 30),
                      etEmailAddress,
                      getVerticalGap(),
                      etFirstName,
                      getVerticalGap(),
                      etLastName,
                      getVerticalGap(),
                      etMobile,
                      getVerticalGap(),
                      etUserName,
                      getVerticalGap(),
                      etCompanyName,
                      isOtpSend ? verifyView : signupView
                    ]))
          ],
        ));
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
                  return Column(children: <Widget>[
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
        isOtpSend = false;
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

  void startCountDown() async {
    var sec = 60;
    var duration = const Duration(seconds: 1);
    timer = Timer.periodic(duration, (Timer t) {
      if (!mounted) return;
      setState(() {
        if (sec == 1) {
          timer!.cancel();
          resendOtp = true;
        } else {
          sec--;
          resendOtp = false;
        }
        resendSecs = sec;
      });
    });
  }

  void getOtp() {
    hideKeyBoard();
    if (validateInput()) {
      showProgress();
      uniqueOtp = generateOtp();
      final Map<String, dynamic> params = {
        'Status': '',
        'Message': '',
        'Details': {
          'CountryCode': countryCode,
          'MobileNo': int.tryParse(_etMobile.text.trim()),
          'EmailID': _etEmail.text.trim(),
          'OTP': uniqueOtp
        }
      };
      ApiCall.makeApiCall(ApiRequest.SEND_OTP, params, Method.POST,
          ApiConstants.SEND_OTP, this);
    }
  }

  bool validateInput() {
    bool valid = true;
    if (_etFName.text.isEmpty) {
      valid = false;
      setState(() {
        isValidFName = false;
      });
    }
    if (_etLName.text.isEmpty) {
      valid = false;
      setState(() {
        isValidLName = false;
      });
    }
    if (_etMobile.text.isEmpty) {
      valid = false;
      setState(() {
        isValidMobile = false;
      });
    }
    if (_etCompanyName.text.isEmpty) {
      valid = false;
      setState(() {
        isValidCName = false;
      });
    }
    if (_etUserName.text.isEmpty) {
      valid = false;
      setState(() {
        isValidUName = false;
      });
    }

    if (valid) {
      if (!agreeOrNot) {
        valid = false;
        showErrorDialog(Strings.error, Strings.pleaseAgree);
      }
    } else {
      showErrorDialog(Strings.error, Strings.allFieldsAreMandatory);
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
    showToast(jsonData['Details']);
    if (timer != null) timer?.cancel();
    startCountDown();
    setState(() {
      isOtpSend = true;
    });
  }

  void validateOtp() {
    if (enteredOtp.isEmpty || enteredOtp.length < 6) {
      showErrorDialog(Strings.error, Strings.enter6DigitOtp);
    } else {
      if (enteredOtp == uniqueOtp.toString()) {
        if (validateInput()) {
          final Map<String, dynamic> params = {
            'Status': '',
            'Message': '',
            'Details': {
              'URL': AppConstants.PARAM_URL,
              'UserName': _etUserName.text.trim(),
              'FName': _etFName.text.trim(),
              'LName': _etLName.text.trim(),
              'Email': _etEmail.text.trim(),
              'Mobile': _etMobile.text.trim(),
              'CompanyName': _etCompanyName.text.trim(),
              'CountryCode': countryCode,
              'City': '',
              'State': '',
              'DefaultHtml': '',
              'Officename': '',
              'Source': '',
              'Medium': '',
              'Campaign': '',
              'UniqueID': 0
            }
          };
          if (timer != null) timer?.cancel();
          Navigator.pushNamed(context, SignupDone.tag, arguments: params);
        }
      } else {
        showErrorDialog(Strings.error, Strings.enterValidOtp);
      }
    }
  }

  @override
  void onTokenExpired(String errorResponse, int responseCode, int requestCode) {
    // TODO: implement onTokenExpired
  }
}
