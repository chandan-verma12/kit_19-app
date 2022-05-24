import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../model/collaborator_list_response.dart';
import '../../model/follow_up_details_response.dart';
import '../../model/follow_up_list_response.dart';
import '../../model/follow_up_products_response.dart';
import '../../model/search_contacts.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_theme.dart';
import '../../base_class.dart';
import '../../model/user_data.dart';
import '../../network/api_call.dart';
import '../../network/api_constants.dart';
import '../../network/api_response.dart';
import '../../network/method.dart';
import '../../utils/strings.dart';

class AddFollowUp extends StatefulWidget {
  static String tag = 'add_followup';

  @override
  State<StatefulWidget> createState() {
    return _AddFollowUp();
  }
}

class _AddFollowUp extends BaseClass<AddFollowUp> implements ApiResponse {
  Lead? lead;
  UserContact? selectedLead;
  List<UserContact> userContacts = [];
  List<FollowUp> followups = [];
  List<Collaborator> colleagues = [];
  List<Product> products = [];
  List<String> productIds = [];
  Collaborator? selectedOwner;
  late FollowUp followUp;
  bool isSearchingLeads = false,
      isValidFollowup = true,
      loadingFollowUps = true,
      isValidRemark = true,
      isReAssign = false,
      showmarkComplete = false,
      isValidLead = true,
      isValidTitle = true,
      isValidLocation = true,
      isValidDate = true;
  late TextEditingController _searchLeadController,
      _etRemark,
      _etOwner,
      _etFromDate,
      _etProducts,
      _etAmount;
  StateSetter? _stateSetter;
  String lastInputValue = "",
      followUpDate = "Next Status Date/Time",
      smsScheduleTime = "SMS Schedule Date & Time",
      emailScheduleTime = "Email Schedule Date & Time";
  late DateTime startDateTime, customNotifySms, customNotifyEmail;

  @override
  void initState() {
    super.initState();
    followups.add(FollowUp(
        id: 0,
        followupStatus: 'Select Follow Up',
        isCallback: false,
        isConvert: false));
    followUp = followups[0];
    _etFromDate = TextEditingController();
    _etAmount = TextEditingController();
    _etProducts = TextEditingController();
    _etOwner = TextEditingController();
    _searchLeadController = TextEditingController();
    _etRemark = TextEditingController();
    _etRemark.addListener(() {
      setState(() {
        isValidRemark = true;
      });
    });
    WidgetsFlutterBinding.ensureInitialized();
    startDateTime = DateTime.now().add(const Duration(hours: 25));
    customNotifySms = startDateTime.subtract(const Duration(minutes: 15));
    customNotifyEmail = startDateTime.subtract(const Duration(minutes: 15));
    //_etFromDate.text = getFormatedDateTime(startDateTime,outPutFormat: DateFormats.dd_MMM_yyyy_HH_mm_ss);
    _etOwner.text = UserDetails.fName;
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
    getFollowUps();
    getColleagueList();
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    try {
      lead = ModalRoute.of(context)!.settings.arguments as Lead;
      if (lead != null) {
        selectedLead =
            UserContact(id: lead?.id, name: lead?.name, image: lead?.image);
      }
    } catch (e) {}
    final searchLead = selectedLead != null
        ? Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppTheme.colorPrimary, width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox.fromSize(
                          size: const Size.fromRadius(18), // Image radius
                          child: Image.network(selectedLead!.image!,
                              fit: BoxFit.cover)))),
              getHorizontalGap(width: 5),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(selectedLead!.name!,
                    style: styleMediumColor(AppTheme.black, fontSize: 11))
              ])
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: Alignment.centerLeft, children: [
                SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(left: 0),
                            primary: AppTheme.colorRipple,
                            backgroundColor: Colors.transparent),
                        onPressed: () {
                          searchLeads(context);
                        },
                        child: Row(children: [
                          Text(Strings.searchLeadBy,
                              style: styleRegularColor(
                                  isValidLead
                                      ? AppTheme.colorDarkGrey
                                      : AppTheme.colorRed,
                                  fontSize: 14))
                        ]))),
      Padding(padding:const EdgeInsets.only(right: 13),child: Align(
                    alignment: Alignment.centerRight,
                    child: getErrorIcon(isValidLead)))
              ]),
              getHorizontalLine(height: 1)
            ],
          );

    final drpFollowUp = DropdownButton<FollowUp>(
        isExpanded: true,
        value: followUp,
        icon: loadingFollowUps
            ? const SpinKitFadingCircle(
                color: AppTheme.colorPrimary,
                size: 20,
              )
            : isValidFollowup
                ? const Padding(padding: EdgeInsets.only(right: 13),child: Icon(Icons.keyboard_arrow_down_rounded))
                : const Padding(padding: EdgeInsets.only(right: 13),child: Icon(Icons.error_outline, color: AppTheme.colorRed)),
        iconSize: 24,
        elevation: 16,
        underline: Container(height: 1, color: Colors.transparent),
        onChanged: (FollowUp? c) {
          setState(() {
            _etFromDate.clear();
            followUp = c!;
            if (c.id != 0) {
              isValidFollowup = true;
            }
          });
        },
        items: followups.map((FollowUp user) {
          return DropdownMenuItem<FollowUp>(
              value: user, child: Text(user.followupStatus!));
        }).toList());

    final etREmark = TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: _etRemark,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Remarks',
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colorDarkGrey),
          ),
          suffixIcon: getErrorIcon(isValidRemark),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colorDarkGrey),
          ),
        ));

    final etAmount = TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: _etAmount,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          hintText: 'Amount Paid',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colorDarkGrey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colorDarkGrey),
          ),
        ));

    final etFromDate = TextField(
        controller: _etFromDate,
        readOnly: true,
        onTap: () {
          showFromDatePicker();
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                showFromDatePicker();
              },
              icon: Image.asset(
                'assets/icons/calender_grey.png',
                width: 24,
                color: isValidDate ? AppTheme.colorDarkGrey : AppTheme.colorRed,
              )),
          hintText: followUpDate,
          enabledBorder: underLineBorder,
          focusedBorder: underLineBorder,
        ));

    final etProducts = TextField(
        controller: _etProducts,
        onTap: () {
          selectProducts(context);
        },
        readOnly: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                selectProducts(context);
              },
              icon: const Icon(Icons.keyboard_arrow_down_rounded)),
          hintText: 'Select Products',
          enabledBorder: underLineBorder,
          focusedBorder: underLineBorder,
        ));

    final etOwner = TextField(
        controller: _etOwner,
        onTap: () {
          selectOwner(context);
        },
        readOnly: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                selectOwner(context);
              },
              icon: const Icon(Icons.keyboard_arrow_down_rounded)),
          hintText: 'Owner',
          enabledBorder: underLineBorder,
          focusedBorder: underLineBorder,
        ));

    final notifyView =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      getVerticalGap(height: 30),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                showNotiFyMeDialog();
              },
              icon: const Icon(
                Icons.alarm,
                color: AppTheme.colorPrimary,
              )),
          getHorizontalGap(width: 15),
          const Icon(
            Icons.sms_outlined,
            color: AppTheme.colorPrimary,
          ),
          getHorizontalGap(width: 5),
          Text(
              getFormatedDateTime(customNotifySms,
                  outPutFormat: DateFormats.dd_MMM_yyyy_hh_mm_a),
              style: styleRegular(fontSize: 11))
        ]),
        Row(children: [
          const Icon(
            Icons.email_outlined,
            color: AppTheme.colorPrimary,
          ),
          getHorizontalGap(width: 5),
          Text(
              getFormatedDateTime(customNotifyEmail,
                  outPutFormat: DateFormats.dd_MMM_yyyy_hh_mm_a),
              style: styleRegular(fontSize: 11))
        ])
      ]),
      getVerticalGap(),
      Text('Follow Type',
          style: styleRegularColor(AppTheme.black, fontSize: 15)),
      CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        activeColor: AppTheme.colorPrimary,
        controlAffinity: ListTileControlAffinity.leading,
        title: const Text('Re-Assign'),
        value: isReAssign,
        onChanged: (v) {
          setState(() {
            isReAssign = v!;
          });
        },
      )
    ]);

    return Scaffold(
        appBar: getAppBar('Add Followup',
            bgColor: AppTheme.colorPrimary, iconColor: AppTheme.white),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                searchLead,
                getVerticalGap(height: 5),
                drpFollowUp,
                getHorizontalLine(height: 1),
                getVerticalGap(height: 5),
                getDynamicView(etOwner, etFromDate, etAmount, etProducts,
                    etREmark, notifyView)
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
                      saveFollowUp();
                    }
                  })
            ])));
  }

  bool validateForm() {
    bool valid = true;
    if (selectedLead == null) {
      valid = false;
      setState(() {
        isValidLead = false;
      });
    }

    if (_etRemark.text.trim().isEmpty) {
      valid = false;
      setState(() {
        isValidRemark = false;
      });
    }
    if ((followUp.isConvert! || followUp.isCallback!) &&
        _etFromDate.text.trim().isEmpty) {
      valid = false;
      setState(() {
        isValidDate = false;
      });
    }
    if (followUp.id == 0) {
      valid = false;
      setState(() {
        isValidFollowup = false;
      });
    }
    if (followUp.isConvert!) {
      setState(() {
        followUpDate = "Converted Date";
      });
    } else if (followUp.isCallback!) {
      setState(() {
        followUpDate = "Next Status Date/Time";
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

  void getFollowUps() {
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': UserDetails.parentID
    };
    ApiCall.makeApiCall(ApiRequest.GET_FOLLOW_UPS, params, Method.POST,
        ApiConstants.GET_FOLLOW_UPS, this);
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
      });
    }
  }

  void getColleagueList() {
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {'UserId': UserDetails.userId}
    };
    ApiCall.makeApiCall(ApiRequest.GET_COLLEAGUE_LIST, params, Method.POST,
        ApiConstants.GET_COLLEAGUE_LIST, this);
  }

  void getProductList() {
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {'UserId': UserDetails.userId, 'Term': ''}
    };
    ApiCall.makeApiCall(ApiRequest.GET_FOLLOWUP_PRODUCTS, params, Method.POST,
        ApiConstants.GET_FOLLOWUP_PRODUCTS, this);
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
      case ApiRequest.SAVE_FOLLOWUP:
        showToast('Followup Added Successfully');
        Navigator.pop(context, true);
        break;
      case ApiRequest.GET_FOLLOW_UPS:
        setState(() {
          loadingFollowUps = false;
          followups.addAll(FollowUpListResponse.fromJson(jsonData).followups!);
        });
        break;
      case ApiRequest.GET_COLLEAGUE_LIST:
        colleagues.clear();
        colleagues
            .addAll(CollaboratorListResponse.fromJson(jsonData).collaborators!);
        break;
      case ApiRequest.GET_FOLLOWUP_PRODUCTS:
        products.clear();
        products.addAll(FollowUpProductsResponse.fromJson(jsonData).products!);
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

  void selectProducts(context) async {
    changeSystemUiColor(statusBarColor: Colors.transparent);
    await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
                initialChildSize: 0.50,
                minChildSize: 0.25,
                maxChildSize: 0.70,
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Column(children: [
                    Icon(
                      Icons.remove,
                      color: Colors.grey[600],
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: products.length,
                        itemBuilder: (_, index) {
                          return TextButton(
                              style: TextButton.styleFrom(
                                  primary: AppTheme.colorRipple,
                                  backgroundColor: AppTheme.white),
                              onPressed: () {
                                setSelectedIds(setState, index);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    getHorizontalGap(width: 10),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppTheme.colorGrey),
                                            shape: BoxShape.circle),
                                        child: ClipOval(
                                            child: SizedBox.fromSize(
                                                size: const Size.fromRadius(24),
                                                child: loadImage(
                                                    products[index].image)))),
                                    getHorizontalGap(width: 5),
                                    Text(products[index].name!,
                                        style: styleMediumColor(AppTheme.black,
                                            fontSize: 11))
                                  ]),
                                  products[index].isChecked
                                      ? const Icon(Icons.check_rounded)
                                      : Container()
                                ],
                              ));
                        },
                      ),
                    )
                  ]);
                });
          });
        });
  }

  void setSelectedIds(StateSetter setState, int index) {
    _etProducts.clear();
    productIds.clear();
    List<String> colabs = [];
    setState(() {
      products[index].isChecked = !products[index].isChecked;
      for (int i = 0; i < products.length; i++) {
        if (products[i].isChecked) {
          colabs.add(products[i].name.toString());
          productIds.add(products[i].id.toString());
        }
      }
      _etProducts.text = colabs.join(",");
    });
  }

  getDynamicView(TextField etOwner, TextField etFromDate, TextField etAmount,
      TextField etProducts, TextField etREmark, Column notifyView) {
    if (followUp.isConvert!) {
      setState(() {
        followUpDate = "Next Status Date/Time";
      });
      return Column(children: [
        etOwner,
        getVerticalGap(height: 5),
        etFromDate,
        getVerticalGap(height: 5),
        etProducts,
        getVerticalGap(height: 5),
        etAmount,
        getVerticalGap(height: 5),
        etREmark
      ]);
    } else if (followUp.isCallback!) {
      setState(() {
        followUpDate = "Converted Date";
      });
      return Column(children: [
        etOwner,
        getVerticalGap(height: 5),
        etFromDate,
        getVerticalGap(height: 5),
        etProducts,
        getVerticalGap(height: 5),
        etREmark,
        notifyView
      ]);
    } else {
      return Column(children: [getVerticalGap(height: 5), etREmark]);
    }
  }

  void selectOwner(context) async {
    changeSystemUiColor(statusBarColor: Colors.transparent);
    await showModalBottomSheet(
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
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: colleagues.length,
                        itemBuilder: (_, index) {
                          return TextButton(
                              style: TextButton.styleFrom(
                                  primary: AppTheme.colorRipple,
                                  backgroundColor: AppTheme.white),
                              onPressed: () {
                                selectedOwner = colleagues[index];
                                setState(() {
                                  _etOwner.text = selectedOwner!.displayName!;
                                });
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    getHorizontalGap(width: 10),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppTheme.colorGrey),
                                            shape: BoxShape.circle),
                                        child: ClipOval(
                                            child: SizedBox.fromSize(
                                                size: const Size.fromRadius(24),
                                                child: loadImage(
                                                    colleagues[index].image)))),
                                    getHorizontalGap(width: 5),
                                    Text(colleagues[index].displayName!,
                                        style: styleMediumColor(AppTheme.black,
                                            fontSize: 11))
                                  ]),
                                  colleagues[index].isChecked
                                      ? const Icon(Icons.check_rounded)
                                      : Container()
                                ],
                              ));
                        },
                      ),
                    )
                  ]);
                });
          });
        });
  }

  void showFromDatePicker() {
    DatePicker.showDateTimePicker(context, onConfirm: (d) {
      startDateTime = d;
      setState(() {
        isValidDate = true;
        customNotifyEmail = startDateTime.subtract(const Duration(minutes: 15));
        customNotifySms = startDateTime.subtract(const Duration(minutes: 15));
        _etFromDate.text = getFormatedDateTime(d,
            outPutFormat: DateFormats.dd_MMM_yyyy_HH_mm_ss);
      });
    });
  }

  void showNotiFyMeDialog() async {
    changeSystemUiColor(statusBarColor: Colors.transparent);
    final r = await showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        )),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState_) {
            return Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Stack(alignment: Alignment.centerLeft, children: [
                        SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.only(left: 0),
                                    primary: AppTheme.colorRipple,
                                    backgroundColor: Colors.transparent),
                                onPressed: () {
                                  showSmsScheduleDateTimePicker(setState_);
                                },
                                child: Row(children: [
                                  Text(smsScheduleTime,
                                      style: styleRegularColor(
                                          AppTheme.colorDarkGrey,
                                          fontSize: 14))
                                ]))),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              'assets/icons/calender_grey.png',
                              width: 24,
                            ))
                      ]),
                      getHorizontalLine(height: 1),
                      getVerticalGap(),
                      Stack(alignment: Alignment.centerLeft, children: [
                        SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.only(left: 0),
                                    primary: AppTheme.colorRipple,
                                    backgroundColor: Colors.transparent),
                                onPressed: () {
                                  showEmailScheduleDateTimePicker(setState_);
                                },
                                child: Row(children: [
                                  Text(emailScheduleTime,
                                      style: styleRegularColor(
                                          AppTheme.colorDarkGrey,
                                          fontSize: 14))
                                ]))),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              'assets/icons/calender_grey.png',
                              width: 24,
                            ))
                      ]),
                      getHorizontalLine(height: 1),
                      getVerticalGap(),
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
                            Navigator.pop(context, true);
                          })
                    ])));
          });
        });
    if (r != null) {
      if (r as bool) {
        setState(() {});
      }
    }
  }

  void showSmsScheduleDateTimePicker(StateSetter setState_) async {
    DatePicker.showDateTimePicker(context,
        minTime: DateTime.now().add(const Duration(minutes: 15)),
        maxTime: startDateTime.subtract(const Duration(minutes: 15)),
        onConfirm: (d) {
      setState_(() {
        customNotifySms = d;
        smsScheduleTime = getFormatedDateTime(customNotifySms,
            outPutFormat: DateFormats.dd_MMM_yyyy_HH_mm_ss);
      });
    });
  }

  void showEmailScheduleDateTimePicker(StateSetter setState_) async {
    DatePicker.showDateTimePicker(context,
        minTime: DateTime.now().add(const Duration(minutes: 15)),
        maxTime: startDateTime.subtract(const Duration(minutes: 15)),
        onConfirm: (d) {
      setState_(() {
        customNotifyEmail = d;
        emailScheduleTime = getFormatedDateTime(customNotifyEmail,
            outPutFormat: DateFormats.dd_MMM_yyyy_HH_mm_ss);
      });
    });
  }

  void saveFollowUp() {
    showProgress();
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {
        "LeadId": selectedLead?.id,
        "AssignedTo":
            selectedOwner != null ? selectedOwner?.id : UserDetails.userId,
        "FupValue": followUp.fupValue,
        "NextStatusDate": "",
        "Products": "",
        "Remarks": _etRemark.text.trim(),
        "AmountPaid": _etAmount.text.trim().isEmpty ? 0 : _etAmount.text.trim(),
        "CreatedBy": UserDetails.userId,
        "ParentId": UserDetails.parentID,
        "IsReAssign": isReAssign,
        "NotifyBySMS": false,
        "NotifyByEmail": false,
        "SmsScheduelDateTime": "",
        "EmailScheduelDateTime": ""
      }
    };
    if (followUp.isCallback!) {
      params["Details"]["NextStatusDate"] = _etFromDate.text.trim();
      params["Details"]["NotifyBySMS"] = true;
      params["Details"]["NotifyByEmail"] = true;
      params["Details"]["SmsScheduelDateTime"] = getFormatedDateTime(
          customNotifySms,
          outPutFormat: DateFormats.dd_MMM_yyyy_HH_mm_ss);
      params["Details"]["EmailScheduelDateTime"] = getFormatedDateTime(
          customNotifyEmail,
          outPutFormat: DateFormats.dd_MMM_yyyy_HH_mm_ss);
      params["Details"]["Products"] = productIds.join(',');
    }
    if (followUp.isConvert!) {
      params["Details"]["NextStatusDate"] = _etFromDate.text.trim();
      params["Details"]["Products"] = productIds.join(',');
    }
    ApiCall.makeApiCall(ApiRequest.SAVE_FOLLOWUP, params, Method.POST,
        ApiConstants.SAVE_FOLLOWUP, this);
  }
}
