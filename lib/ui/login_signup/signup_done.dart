import 'dart:convert';
import 'package:flutter/material.dart';
import '../../network/api_response.dart';
import '../../model/country_list.dart';
import '../../model/country_time_zone.dart';
import '../../network/api_call.dart';
import '../../network/api_constants.dart';
import '../../network/method.dart';
import '../../utils/app_theme.dart';
import '../../utils/one_button_dialog.dart';
import '../../utils/strings.dart';
import '../../base_class.dart';
import 'login.dart';

class SignupDone extends StatefulWidget {
  static String tag = 'signup_done';

  @override
  State<StatefulWidget> createState() {
    return _SignupDone();
  }
}

class _SignupDone extends BaseClass<SignupDone> implements ApiResponse {
  late Map<String, dynamic> params;
  late TextEditingController _etCountry, _etTimeZone;
  List<CountryItem> countries = [];
  List<TimeZone> zones = [];
  bool isValidCountry = true, isValidTimeZone = true;

  @override
  void initState() {
    super.initState();
    _etCountry = TextEditingController();
    _etTimeZone = TextEditingController();
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(milliseconds: 100), () {
        getCountryList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    changeSystemUiColor(statusBarColor: Colors.transparent);

    params = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final fName = params['Details']['FName'].toString();
    final lName = params['Details']['LName'].toString();
    print(fName + " " + lName);

    final btPickCountry = TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            primary: AppTheme.colorRipple,
            backgroundColor: Colors.transparent),
        onPressed: () {
          changeSystemUiColor(statusBarColor: Colors.transparent);
          _showCountryList(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.arrow_drop_down_rounded),
            Image(
              image: AssetImage(
                'assets/icons/country.png',
              ),
              height: 28,
              width: 28,
              color: AppTheme.colorDarkGrey,
            )
          ],
        ));

    final btPickTimeZone = TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            primary: AppTheme.colorRipple,
            backgroundColor: Colors.transparent),
        onPressed: () {
          changeSystemUiColor(statusBarColor: Colors.transparent);
          _showTimeZoneList(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.arrow_drop_down_rounded),
            Image(
              image: AssetImage(
                'assets/icons/country-time.png',
              ),
              height: 28,
              width: 28,
              color: AppTheme.colorDarkGrey,
            )
          ],
        ));

    final etCountry = TextField(
      readOnly: true,
      controller: _etCountry,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          fillColor: AppTheme.white,
          filled: true,
          focusedBorder: getBorder(
              isValidCountry ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          enabledBorder: getBorder(
              isValidCountry ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          suffixIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: btPickCountry),
          hintText: Strings.country,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15)),
    );

    final etCountryTime = TextField(
      readOnly: true,
      controller: _etTimeZone,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          fillColor: AppTheme.white,
          filled: true,
          focusedBorder: getBorder(
              isValidTimeZone ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          enabledBorder: getBorder(
              isValidTimeZone ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          suffixIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: btPickTimeZone),
          hintText: Strings.countryTime,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15)),
    );

    final btGo = OutlinedButton(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Text(
            Strings.go,
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
          registerUser();
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      Text(Strings.welcome + "$fName $lName !",
                          style: styleBold(fontSize: 18)),
                      getVerticalGap(height: 10),
                      Text(Strings.youAreHere,
                          style: styleMedium(fontSize: 16)),
                      getVerticalGap(height: 50),
                      etCountry,
                      getVerticalGap(),
                      etCountryTime,
                      getVerticalGap(height: 50),
                      btGo
                    ]))
          ],
        ));
  }

  void _showCountryList(BuildContext context) async {
    CountryItem? c = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.white,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.2,
        maxChildSize: 0.50,
        expand: false,
        builder: (_, controller) => Column(
          children: [
            Icon(
              Icons.remove,
              color: Colors.grey[600],
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: countries.length,
                itemBuilder: (_, index) {
                  return TextButton(
                      style: TextButton.styleFrom(
                          primary: AppTheme.colorRipple,
                          backgroundColor: AppTheme.white),
                      onPressed: () {
                        Navigator.pop(context, countries[index]);
                      },
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(countries[index].text!,
                                  style: styleRegularColor(AppTheme.black)))));
                },
              ),
            ),
          ],
        ),
      ),
    );
    if (c != null) {
      setState(() {
        _etCountry.text = c.text!;
        _etTimeZone.clear();
        isValidCountry = true;
      });
      getCountryTimeZone(c.code!, isShow: true);
    }
  }

  void _showTimeZoneList(BuildContext context) async {
    TimeZone? c = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.white,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.2,
        maxChildSize: 0.50,
        expand: false,
        builder: (_, controller) => Column(
          children: [
            Icon(
              Icons.remove,
              color: Colors.grey[600],
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: zones.length,
                itemBuilder: (_, index) {
                  return TextButton(
                      style: TextButton.styleFrom(
                          primary: AppTheme.colorRipple,
                          backgroundColor: AppTheme.white),
                      onPressed: () {
                        Navigator.pop(context, zones[index]);
                      },
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(zones[index].text!,
                                  style: styleRegularColor(AppTheme.black)))));
                },
              ),
            ),
          ],
        ),
      ),
    );
    if (c != null) {
      setState(() {
        _etTimeZone.text = c.code!;
        isValidTimeZone = true;
      });
    }
  }

  void registerUser() {
    if (validateInput()) {
      showProgress();
      params['Details']['Country'] = _etCountry.text.trim();
      params['Details']['Timezone'] = _etTimeZone.text.trim();
      ApiCall.makeApiCall(
          ApiRequest.SIGN_UP, params, Method.POST, ApiConstants.SIGN_UP, this);
    }
  }

  void getCountryTimeZone(String countryId, {bool isShow = true}) {
    if (isShow) showProgress();
    final Map<String, dynamic> data = {
      'Status': '',
      'Message': '',
      'Details': countryId
    };
    ApiCall.makeApiCall(ApiRequest.COUNTRY_TIME_ZONE, data, Method.POST,
        ApiConstants.COUNTRY_TIME_ZONE, this);
  }

  void getCountryList({bool isShow = true}) {
    if (isShow) showProgress();
    final Map<String, dynamic> data = {
      'Status': '',
      'Message': '',
      'Details': params['Details']['CountryCode']
    };
    ApiCall.makeApiCall(ApiRequest.COUNTRY_LIST, data, Method.POST,
        ApiConstants.COUNTRY_LIST, this);
  }

  bool validateInput() {
    bool valid = true;
    if (_etCountry.text.isEmpty) {
      valid = false;
      setState(() {
        isValidCountry = false;
      });
    }
    if (_etTimeZone.text.isEmpty) {
      valid = false;
      setState(() {
        isValidTimeZone = false;
      });
    }
    return valid;
  }

  void showRegistrationSuccessDialog(String title, String msg) {
    changeSystemUiColor(statusBarColor: Colors.transparent);
    var dialog = OneButtonDialog(
        title: title,
        message: msg,
        positiveBtnText: 'OK',
        onPostivePressed: () {
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
    var jsonData = json.decode(response);
    switch (requestCode) {
      case ApiRequest.SIGN_UP:
        hideProgress(changestatusBarColor: false);
        if (jsonData["Details"]["Status"] == 1) {
          showRegistrationSuccessDialog(
              Strings.success, jsonData["Details"]["MSG"]);
        } else {
          showErrorDialog(Strings.error, jsonData["Details"]["MSG"]);
        }
        break;
      case ApiRequest.COUNTRY_LIST:
        countries.clear();
        countries.addAll(CountryList.fromJson(jsonData).countries!);
        if (countries.length > 1) {
          hideProgress(changestatusBarColor: false);
          _showCountryList(context);
        } else {
          final c = countries[0];
          setState(() {
            _etCountry.text = c.text!;
            isValidCountry = true;
          });
          getCountryTimeZone(c.code!, isShow: false);
        }
        break;
      case ApiRequest.COUNTRY_TIME_ZONE:
        zones.clear();
        zones.addAll(CountryTimeZone.fromJson(jsonData).zones!);
        if (zones.length > 1) {
          hideProgress(changestatusBarColor: false);
          _showTimeZoneList(context);
        } else {
          hideProgress(changestatusBarColor: false);
          final c = zones[0];
          setState(() {
            _etTimeZone.text = c.code!;
            isValidTimeZone = true;
          });
        }
        break;
    }
  }

  @override
  void onTokenExpired(String errorResponse, int responseCode, int requestCode) {
    // TODO: implement onTokenExpired
  }
}
