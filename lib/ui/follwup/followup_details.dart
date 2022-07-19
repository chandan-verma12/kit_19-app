import 'dart:convert';
import 'package:flutter/material.dart';
import '../../model/follow_up_details_response.dart';
import '../../ui/follwup/add_followup.dart';
import '../../base_class.dart';
import '../../model/home_calendar_data.dart';
import '../../model/user_data.dart';
import '../../network/api_call.dart';
import '../../network/api_constants.dart';
import '../../network/api_response.dart';
import '../../network/method.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_theme.dart';
import '../../utils/strings.dart';

class FollowupDetails extends StatefulWidget {
  static String tag = 'followup_details';

  @override
  State<StatefulWidget> createState() {
    return _FollowupDetails();
  }
}

class _FollowupDetails extends BaseClass<FollowupDetails>
    implements ApiResponse {
  Tasks? task;
  bool isLoading = true;
  FollowUpDtls? details;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      callDetailsApi();
    });
  }

  void callDetailsApi() {
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {'UserId': UserDetails.userId, 'Id': int.tryParse(task!.id!)}
    };
    ApiCall.makeApiCall(ApiRequest.GET_FOLLOWUP_DETAILS, params, Method.POST,
        ApiConstants.GET_FOLLOWUP_DETAILS, this);
  }

  @override
  Widget build(BuildContext context) {
    task = ModalRoute.of(context)!.settings.arguments as Tasks;
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(color: AppTheme.white),
            centerTitle: false,
            actions: [
              PopupMenuButton<int>(
                  color: AppTheme.colorGreyLight,
                  padding: EdgeInsets.zero,
                  onSelected: (item) => onMenuSelected(context, item),
                  itemBuilder: (context) => [
                        PopupMenuItem<int>(
                          height: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
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
                              Text('Add',
                                  style: styleLightColor(AppTheme.black))
                            ],
                          ),
                          value: AppConstants.MNU_ADD,
                        )
                      ])
            ],
            title: Text('Followup', style: styleMediumColor(AppTheme.white)),
            backgroundColor: AppTheme.colorPrimary,
            elevation: 0.0),
        body: isLoading
            ? getProgressView()
            : Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(children: [
                              Column(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(3),
                                            color: getOutComeColor(null),
                                            child: Text(
                                                getDateTime(
                                                    details!.followupDate,
                                                    DateFormats
                                                        .dd_MMM_yyyy_HH_mm_ss,
                                                    outPutFormat:
                                                        DateFormats.MMM_yyyy),
                                                style: styleLightColor(
                                                    AppTheme.white,
                                                    fontSize: 9))),
                                        Text(
                                            getDateTime(
                                                details!.followupDate,
                                                DateFormats
                                                    .dd_MMM_yyyy_HH_mm_ss,
                                                outPutFormat: DateFormats.dd),
                                            style: styleBoldColor(
                                                AppTheme.black,
                                                fontSize: 18))
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: AppTheme.colorGreyLight,
                                        border: Border.all(
                                            color: getOutComeColor(null),
                                            width: 2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(7.0))),
                                  ),
                                  Text(
                                      getDateTime(details!.followupDate,
                                          DateFormats.dd_MMM_yyyy_HH_mm_ss,
                                          outPutFormat: DateFormats.hh_mm_a),
                                      style: styleMediumColor(AppTheme.black,
                                          fontSize: 9))
                                ],
                              ),
                            ]),
                            getHorizontalGap(width: 10),
                            Expanded(
                                child: Text(details!.status!,
                                    style: styleMedium(fontSize: 16))),
                            SizedBox(
                                width: 55,
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppTheme.colorPrimary,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: SizedBox.fromSize(
                                                size: const Size.fromRadius(
                                                    24), // Image radius
                                                child: loadImage(
                                                    details!.lead!.image)))),
                                    Text(details!.lead!.name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: styleMedium(fontSize: 11))
                                  ],
                                ))
                          ]),
                      getVerticalGap(),
                      Text(details!.remarks!),
                      getVerticalGap(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Assigned To',
                                      style: styleRegular(fontSize: 11)),
                                  getVerticalGap(height: 5),
                                  Row(children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppTheme.colorGrey),
                                            shape: BoxShape.circle),
                                        child: ClipOval(
                                            child: SizedBox.fromSize(
                                                size: const Size.fromRadius(24),
                                                child: loadImage(details!
                                                    .assignTo!.image)))),
                                    getHorizontalGap(width: 10),
                                    Text(details!.assignTo!.firstName!,
                                        style: styleMedium(fontSize: 12))
                                  ])
                                ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.creator,
                                      style: styleRegular(fontSize: 11)),
                                  getVerticalGap(height: 5),
                                  Row(children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppTheme.colorGrey),
                                            shape: BoxShape.circle),
                                        child: ClipOval(
                                            child: SizedBox.fromSize(
                                                size: const Size.fromRadius(24),
                                                child: loadImage(
                                                    details!.creator!.image)))),
                                    getHorizontalGap(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(details!.creator!.firstName!,
                                            style: styleMedium(fontSize: 12)),
                                        Text(
                                            getDateTime(
                                                details!.createdOn!,
                                                DateFormats
                                                    .dd_MMM_yyyy_HH_mm_ss,
                                                outPutFormat: DateFormats
                                                    .dd_MMM_yyyy_hh_mm_a),
                                            style: styleRegular(fontSize: 9))
                                      ],
                                    )
                                  ])
                                ])
                          ]),
                      getVerticalGap(),
                      Row(children: [
                        Text("Re-Assigned   ", style: styleMedium()),
                        Text("${details!.isReassign! ? 'YES' : 'NO'}")
                      ]),
                      getVerticalGap(),
                      Row(children: [
                        Text("Amount Paid   ", style: styleMedium()),
                        Text("${details!.amount.toString()}")
                      ]),
                      getVerticalGap(),
                      Row(children: [
                        Text("Products   ", style: styleMedium()),
                        Text("${getProductNames()}")
                      ]),
                    ]))));
  }

  @override
  void onError(String errorResponse, int responseCode, int requestCode) {
    debugPrint(
        "Msg: ${errorResponse} Response Code ${responseCode} Request Code ${requestCode}");
    if (isProgress) hideProgress();
    showErrorDialog(Strings.error, errorResponse);
  }

  @override
  void onResponse(String response, int responseCode, int requestCode) {
    debugPrint(
        "Data: ${response} Response Code ${responseCode} Request Code ${requestCode}");
    if (isProgress) hideProgress();
    var jsonData = json.decode(response);
    switch (requestCode) {
      case ApiRequest.GET_FOLLOWUP_DETAILS:
        details = FollowUpDetailsResponse.fromJson(jsonData).details!;
        setState(() {
          isLoading = false;
        });
        break;
    }
  }

  @override
  void onTokenExpired(String errorMsg, int responseCode, int requestCode) {
    if (isProgress) hideProgress();
    showInvalidTokenDialog(errorMsg);
  }

  onMenuSelected(BuildContext context, int item) async {
    final result = await Navigator.pushNamed(context, AddFollowUp.tag,
        arguments: details?.lead);
    if (result != null) {
      if (result as bool) {
        Navigator.pop(context, true);
      }
    }
  }

  getProductNames() {
    List<String> names = [];
    if (details?.products != null) {
      for (int i = 0; i < details!.products!.length; i++) {
        names.add(details!.products![i].name!);
      }
    }
    return names.join(', ');
  }
}
