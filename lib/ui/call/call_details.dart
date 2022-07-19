import 'dart:convert';
import 'package:flutter/material.dart';
import '../../base_class.dart';
import '../../model/call_details_response.dart';
import '../../model/home_calendar_data.dart';
import '../../model/out_come_list.dart';
import '../../model/user_data.dart';
import '../../network/api_call.dart';
import '../../network/api_constants.dart';
import '../../network/api_response.dart';
import '../../network/method.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_theme.dart';
import '../../utils/strings.dart';
import 'add_call_schedule.dart';

class CallLogDetails extends StatefulWidget {
  static String tag = 'call_details';

  @override
  State<StatefulWidget> createState() {
    return _CallDetails();
  }
}

class _CallDetails extends BaseClass<CallLogDetails> implements ApiResponse {
  Tasks? task;
  CallDetails? details;
  List<OutCome> outComes = [];
  late TextEditingController _etRemark;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _etRemark = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getOutComes();
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
    ApiCall.makeApiCall(ApiRequest.GET_CALL_LOG, params, Method.POST,
        ApiConstants.GET_CALL_LOG, this);
  }

  void getOutComes() {
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {
        'UserId': UserDetails.userId,
        'TaskId': int.tryParse(task!.id!)
      }
    };
    ApiCall.makeApiCall(ApiRequest.GET_OUTCOMES, params, Method.POST,
        ApiConstants.GET_OUTCOMES, this);
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
            title:
                Text(Strings.callLog, style: styleMediumColor(AppTheme.white)),
            backgroundColor: AppTheme.colorPrimary,
            elevation: 0.0),
        body: isLoading
            ? getProgressView()
            : Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                        Container(
                                            margin: const EdgeInsets.only(
                                                top: 9, right: 5),
                                            child: Row(children: [
                                              IconButton(
                                                  padding: EdgeInsets.zero,
                                                  constraints:
                                                      const BoxConstraints(),
                                                  onPressed: () {
                                                    handleClick();
                                                  },
                                                  icon: Icon(
                                                      task?.taskStatus ==
                                                              AppConstants
                                                                  .SCHEDULE
                                                          ? Icons
                                                              .check_box_outline_blank
                                                          : Icons
                                                              .check_box_outlined,
                                                      size: 24)),
                                              getHorizontalGap(width: 10),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(1),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppTheme
                                                              .colorPrimary,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: SizedBox.fromSize(
                                                          size: const Size
                                                                  .fromRadius(
                                                              24), // Image radius
                                                          child: loadImage(
                                                              details!.person!
                                                                  .image))))
                                            ])),
                                        Container(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                                width: 18,
                                                height: 18,
                                                child: Center(
                                                  child: Text(
                                                    details!.person!.type ==
                                                            'lead'
                                                        ? 'L'
                                                        : 'E',
                                                    style: const TextStyle(
                                                        color: AppTheme
                                                            .colorPrimary,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                        color: AppTheme
                                                            .colorPrimary,
                                                        width: 1),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                100)),
                                                    color: AppTheme.white)))
                                      ])),
                                  getHorizontalGap(width: 10),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          Text(details!.person!.name!,
                                              style: styleMedium()),
                                          getHorizontalGap(width: 5),
                                          Image.asset(
                                              'assets/icons/incoming_call.png',
                                              width: 18)
                                        ]),
                                        Text(details!.person!.mobileNo!),
                                        Text("Lead No.: ${details?.id}"),
                                        Text("Outcome: ${details?.outcome}")
                                      ])
                                ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(getDateTime(details?.createdOn,
                                      DateFormats.dd_MMM_yyyy_HH_mm_ss,
                                      outPutFormat: DateFormats.dd_MMM_yyyy)),
                                  Text(getDateTime(details?.createdOn,
                                      DateFormats.dd_MMM_yyyy_HH_mm_ss,
                                      outPutFormat: DateFormats.hh_mm_a))
                                ])
                          ]),
                      getVerticalGap(),
                      const Text('Remarks'),
                      Text(details!.remarks!),
                      getVerticalGap(),
                      details?.recodingUrl != null
                          ? Container(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  const Icon(Icons.play_arrow),
                                  getHorizontalGap(width: 5),
                                  Text('00:00'),
                                  getHorizontalGap(width: 10),
                                  Expanded(
                                      child: Container(
                                          height: 8,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                              color: AppTheme.colorDarkGrey))),
                                  getHorizontalGap(width: 5),
                                  const Icon(Icons.volume_up)
                                ],
                              ),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  color: AppTheme.colorGrey))
                          : Container()
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
      case ApiRequest.GET_CALL_LOG:
        setState(() {
          isLoading = false;
          details = CallDetailsResponse.fromJson(jsonData).details;
        });
        break;
      case ApiRequest.MARK_AS_COMPLETE:
        showToast('Mark as completed successfully');
        Navigator.pop(context, true);
        break;
      case ApiRequest.GET_OUTCOMES:
        final outComeData = OutComeList.fromJson(jsonData);
        outComes.clear();
        outComes
            .add(OutCome(id: 0, code: '', text: 'Select Outcome', remark: ''));
        outComes.addAll(outComeData.outComes!);
        break;
    }
  }

  @override
  void onTokenExpired(String errorMsg, int responseCode, int requestCode) {
    if (isProgress) hideProgress();
    showInvalidTokenDialog(errorMsg);
  }

  onMenuSelected(BuildContext context, int item) async {
    final result = await Navigator.pushNamed(context, AddCallSchedule.tag,
        arguments: details?.person);
    if (result != null) {
      if (result as bool) {
        Navigator.pop(context, true);
      }
    }
  }

  void showMarkCompleteDialog() async {
    var sOutCome = outComes[0];
    _etRemark.clear();
    changeSystemUiColor(statusBarColor: Colors.transparent);
    sOutCome = await showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.markAsCompleted, style: styleBold()),
                          IconButton(
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Navigator.pop(context, outComes[0]);
                              },
                              icon: const Icon(Icons.close,
                                  color: AppTheme.black))
                        ],
                      ),
                      getVerticalGap(height: 10),
                      DropdownButton<OutCome>(
                          isExpanded: true,
                          value: sOutCome,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          iconSize: 24,
                          elevation: 16,
                          style: styleMediumColor(AppTheme.black),
                          underline: Container(
                            height: 1.0,
                            color: Colors.grey,
                          ),
                          onChanged: (OutCome? c) {
                            setState(() {
                              sOutCome = c!;
                            });
                          },
                          items: outComes.map((OutCome user) {
                            return DropdownMenuItem<OutCome>(
                                value: user, child: Text(user.text!));
                          }).toList()),
                      getVerticalGap(height: 5),
                      TextField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: _etRemark,
                          keyboardType: TextInputType.text,
                          style: styleMedium(),
                          decoration: const InputDecoration(
                            hintText: 'Remarks',
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppTheme.colorDarkGrey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppTheme.colorDarkGrey),
                            ),
                          )),
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
                            if (sOutCome.id != 0 &&
                                _etRemark.text.trim().isNotEmpty) {
                              sOutCome.remark = _etRemark.text.trim();
                              Navigator.pop(context, sOutCome);
                            } else {
                              showToast('Select Outcome & Enter Remarks');
                            }
                          })
                    ])));
          });
        });
    if (sOutCome.id != 0) {
      markAsCompleted(sOutCome);
    }
  }

  void markAsCompleted(OutCome outCome) {
    showProgress();
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {
        'Id': int.tryParse(task!.id!),
        'OutcomeId': outCome.id,
        'Remarks': outCome.remark
      }
    };
    ApiCall.makeApiCall(ApiRequest.MARK_AS_COMPLETE, params, Method.POST,
        ApiConstants.MARK_AS_COMPLETE, this);
  }

  void handleClick() {
    if (task!.taskStatus == AppConstants.SCHEDULE) {
      if (task!.isEditable!) {
        showMarkCompleteDialog();
      } else {
        showPriviledgeDialog();
      }
    }
  }
}
