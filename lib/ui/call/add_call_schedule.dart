import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kit_19/utils/app_constants.dart';
import 'package:kit_19/utils/app_theme.dart';

import '../../base_class.dart';
import '../../model/call_details_response.dart';
import '../../model/search_contacts.dart';
import '../../model/user_data.dart';
import '../../network/api_call.dart';
import '../../network/api_constants.dart';
import '../../network/api_response.dart';
import '../../network/method.dart';
import '../../utils/strings.dart';

class AddCallSchedule extends StatefulWidget {
  static String tag = 'add_call_schedule';

  @override
  State<StatefulWidget> createState() {
    return _AddCallSchedule();
  }
}

class _AddCallSchedule extends BaseClass<AddCallSchedule>
    implements ApiResponse {
  Person? person;
  StateSetter? _stateSetter;
  bool isSearchingLeads = false,
      isValidLead = true,
      isValidDateTime = true,
      isValidTitle = true;
  List<UserContact> userContacts = [];
  late TextEditingController _searchLeadController, _etTitle;
  UserContact? selectedLead;
  String lastInputValue = "",
      mobileNumber = "Type number to search in lead/enwuiry",
      dateTime = "Select Date & Time";

  @override
  void initState() {
    super.initState();
    _searchLeadController = TextEditingController();
    _etTitle = TextEditingController();
    _etTitle.addListener(() {
      setState(() {
        isValidTitle = true;
      });
    });
    _searchLeadController.addListener(() {
      final inputValue = _searchLeadController.text.trim();
      if (inputValue.isNotEmpty) {
        if (lastInputValue != inputValue) {
          lastInputValue = inputValue;
          _stateSetter!(() {
            isSearchingLeads = true;
          });
          searchLeadContacts(_searchLeadController.text.trim());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      person = ModalRoute.of(context)!.settings.arguments as Person;
    } catch (e) {}

    final etTitle = TextField(
        controller: _etTitle,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Title',
          hintStyle: TextStyle(
              color: isValidTitle ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          suffixIcon: getErrorIcon(isValidTitle),
          enabledBorder: underLineBorder,
          focusedBorder: underLineBorder,
        ));

    final etNumber = InkWell(
      onTap: () {
        hideKeyBoard();
        searchLeads(context);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(mobileNumber,
                  style: TextStyle(
                      color: isValidLead ? AppTheme.black : AppTheme.colorRed)),
            ),
        Padding(padding:const EdgeInsets.only(right: 13),child: Align(
              alignment: Alignment.centerRight,
              child: getErrorIcon(isValidLead)),
            )
          ],
        ),
      ),
    );

    final etDateTime = InkWell(
      onTap: () {
        hideKeyBoard();
        showFromDatePicker();
      },
      child: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(dateTime,
                  style: TextStyle(
                      color: isValidDateTime
                          ? AppTheme.black
                          : AppTheme.colorRed)),
            ),
        Padding(padding:const EdgeInsets.only(right: 13),child: Align(
              alignment: Alignment.centerRight,
              child: getErrorIcon(isValidDateTime)),
            )
          ],
        ),
      ),
    );

    return Scaffold(
        appBar: getAppBar('Call Schedule',
            bgColor: AppTheme.colorPrimary, iconColor: AppTheme.white),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                etTitle,
                getVerticalGap(),
                etNumber,
                getVerticalGap(height: 5),
                getHorizontalLine(),
                getVerticalGap(),
                etDateTime,
                getVerticalGap(height: 5),
                getHorizontalLine()
              ]))),
              OutlinedButton(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      Strings.save,
                      style: const TextStyle(color: AppTheme.white),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      side: const BorderSide(
                          width: 1.0, color: AppTheme.colorPrimary),
                      primary: AppTheme.white,
                      backgroundColor: AppTheme.colorPrimary),
                  onPressed: () {
                    if (validateForm()) {
                      scheduleCall();
                    }
                  })
            ])));
  }

  bool validateForm() {
    bool valid = true;
    if (_etTitle.text.isEmpty) {
      valid = false;
      setState(() {
        isValidTitle = false;
      });
    }
    if (mobileNumber.startsWith("Type") || mobileNumber.isEmpty) {
      valid = false;
      setState(() {
        isValidLead = false;
      });
    }
    if (dateTime.startsWith("Select") || dateTime.isEmpty) {
      valid = false;
      setState(() {
        isValidDateTime = false;
      });
    }
    return valid;
  }

  void searchLeadContacts(String query) {
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {'UserId': UserDetails.userId, 'Term': query, 'Mode': ''}
    };
    ApiCall.makeApiCall(ApiRequest.SEARCH_CONTACT, params, Method.POST,
        ApiConstants.SEARCH_CONTACT, this);
  }

  void showFromDatePicker() {
    DatePicker.showDateTimePicker(context, minTime: DateTime.now(),
        onConfirm: (d) {
      setState(() {
        dateTime = getFormatedDateTime(d,
            outPutFormat: DateFormats.dd_MMM_yyyy_HH_mm_ss);
        isValidDateTime = true;
      });
    });
  }

  searchLeads(context) async {
    changeSystemUiColor(statusBarColor: Colors.transparent);
    selectedLead = await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            _stateSetter = setState;
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
                        child:
                            Stack(alignment: Alignment.centerLeft, children: [
                          TextField(
                              autofocus: true,
                              controller: _searchLeadController,
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
                              )),
                          isSearchingLeads
                              ? Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  alignment: Alignment.centerRight,
                                  child: const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SpinKitFadingCircle(
                                        color: AppTheme.colorPrimary,
                                        size: 20,
                                      )))
                              : Container()
                        ])),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: userContacts.length,
                        itemBuilder: (_, index) {
                          return TextButton(
                              style: TextButton.styleFrom(
                                  primary: AppTheme.colorRipple,
                                  backgroundColor: AppTheme.white),
                              onPressed: () {
                                Navigator.pop(context, userContacts[index]);
                              },
                              child: Row(
                                children: [
                                  getHorizontalGap(width: 10),
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppTheme.colorPrimary,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: SizedBox.fromSize(
                                              size: const Size.fromRadius(
                                                  18), // Image radius
                                              child: Image.network(
                                                  userContacts[index].image!,
                                                  fit: BoxFit.cover)))),
                                  getHorizontalGap(width: 5),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(userContacts[index].name!,
                                            style: styleMediumColor(
                                                AppTheme.black,
                                                fontSize: 11)),
                                        userContacts[index]
                                                .mobileNo1!
                                                .isNotEmpty
                                            ? Text(
                                                userContacts[index].mobileNo1!,
                                                style: styleMediumColor(
                                                    AppTheme.colorDarkGrey,
                                                    fontSize: 9))
                                            : Container(),
                                        userContacts[index].emailId1!.isNotEmpty
                                            ? Text(
                                                userContacts[index].emailId1!,
                                                style: styleMediumColor(
                                                    AppTheme.colorDarkGrey,
                                                    fontSize: 9))
                                            : Container()
                                      ])
                                ],
                              ));
                        },
                      ),
                    )
                  ]);
                });
          });
        });
    if (selectedLead != null) {
      setState(() {
        isValidLead = true;
        mobileNumber = getMobileNumber(selectedLead);
      });
    }
  }

  getMobileNumber(UserContact? contact) {
    if (contact?.mobileNo1 != null) {
      return contact?.mobileNo1;
    } else if (contact?.mobileNo2 != null) {
      return contact?.mobileNo2;
    } else if (contact?.mobileNo3 != null) {
      return contact?.mobileNo3;
    } else {
      return '';
    }
  }

  void scheduleCall() {
    showProgress();
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {
        "Title": _etTitle.text.trim(),
        "MobileNo": mobileNumber,
        "ScheduleDate": dateTime,
        "CreatedBy": UserDetails.userId
      }
    };
    ApiCall.makeApiCall(ApiRequest.SCHEDULE_CALL, params, Method.POST,
        ApiConstants.SCHEDULE_CALL, this);
  }

  @override
  void onError(String errorResponse, int responseCode, int requestCode) {
    debugPrint(
        "Msg: ${errorResponse} Response Code ${responseCode} Request Code ${requestCode}");
    if (isProgress) hideProgress();

    if (requestCode == ApiRequest.SEARCH_CONTACT && _stateSetter != null) {
      _stateSetter!(() {
        isSearchingLeads = false;
      });
    }
    try {
      var jsonData = json.decode(errorResponse);
      showErrorDialog(Strings.error, jsonData['Message']);
    } catch (e) {
      showErrorDialog(Strings.error, errorResponse);
    }
  }

  @override
  void onResponse(String response, int responseCode, int requestCode) {
    debugPrint(
        "Data: ${response} Response Code ${responseCode} Request Code ${requestCode}");
    if (isProgress) hideProgress();
    var jsonData = json.decode(response);
    switch (requestCode) {
      case ApiRequest.SEARCH_CONTACT:
        userContacts.clear();
        _stateSetter!(() {
          userContacts.addAll(SearchContacts.fromJson(jsonData).userContacts!);
          isSearchingLeads = false;
        });
        break;
      case ApiRequest.SCHEDULE_CALL:
        showToast('Call Scheduled Successfully');
        Navigator.pop(context, true);
        break;
    }
  }

  @override
  void onTokenExpired(String errorMsg, int responseCode, int requestCode) {
    if (isProgress) hideProgress();
    if (requestCode == ApiRequest.SEARCH_CONTACT && _stateSetter != null) {
      _stateSetter!(() {
        isSearchingLeads = false;
      });
    }
    showInvalidTokenDialog(errorMsg);
  }
}
