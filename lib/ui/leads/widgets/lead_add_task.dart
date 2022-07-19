import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kit_19/utils/app_constants.dart';
import 'package:kit_19/utils/app_theme.dart';
import 'package:kit_19/utils/strings.dart';

import '../../../base_class.dart';
import '../../../model/collaborator_list_response.dart';
import '../../../model/out_come_list.dart';
import '../../../model/search_contacts.dart';
import '../../../model/task_details_response.dart';
import '../../../model/task_types.dart';
import '../../../model/user_data.dart';
import '../../../network/api_call.dart';
import '../../../network/api_constants.dart';
import '../../../network/api_response.dart';
import '../../../network/method.dart';

class LeadAddTask extends StatefulWidget {
  static String tag = 'add_task';

  @override
  State<StatefulWidget> createState() {
    return _LeadAddTask();
  }
}

class _LeadAddTask extends BaseClass<LeadAddTask> implements ApiResponse {
  Lead? lead;
  TaskDetails? taskDetails;
  late TextEditingController _searchLeadController,
      _etRemark,
      _etTitle,
      _etDescription,
      _etFromDate,
      _etOwner,
      _etCollaborators;
  List<UserContact> userContacts = [];
  List<Collaborator> collaborators = [];
  List<Collaborator> colleagues = [];
  List<OutCome> outComes = [];
  List<TaskType> types = [];
  late OutCome sOutCome;
  late TaskType taskType;
  bool isSearchingLeads = false,
      isValidTask = true,
      loadingTaskType = true,
      isDataSet = false,
      markAsCompleted = false,
      showmarkComplete = false,
      isValidLead = true,
      isValidTitle = true,
      isValidLocation = true,
      isValidCollab = true;
  StateSetter? _stateSetter;
  UserContact? selectedLead;
  Collaborator? selectedOwner;
  String lastInputValue = "",
      smsScheduleTime = "SMS Schedule Date & Time",
      emailScheduleTime = "Email Schedule Date & Time";
  late DateTime startDateTime, customNotifySms, customNotifyEmail;

  @override
  void initState() {
    types.add(TaskType(id: 0, name: 'Task Type'));
    taskType = types[0];
    _etTitle = TextEditingController();
    _etRemark = TextEditingController();
    _etDescription = TextEditingController();
    _etFromDate = TextEditingController();
    _etOwner = TextEditingController();
    _etCollaborators = TextEditingController();
    _searchLeadController = TextEditingController();
    WidgetsFlutterBinding.ensureInitialized();
    startDateTime = DateTime.now().add(const Duration(hours: 25));
    customNotifySms = startDateTime.subtract(const Duration(minutes: 15));
    customNotifyEmail = startDateTime.subtract(const Duration(minutes: 15));
    _etTitle.text = "Task_${DateTime.now().millisecondsSinceEpoch.toString()}";
    _etFromDate.text = getFormatedDateTime(startDateTime,
        outPutFormat: DateFormats.dd_MMM_yyyy_HH_mm_ss);
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
    getTaskTypes();
    getCollaborators();
    getColleagueList();
    getOutComes();
    super.initState();
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
    try {
      taskDetails = ModalRoute.of(context)!.settings.arguments as TaskDetails;
      if (taskDetails != null) {
        if (!isDataSet) setData();
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
                Padding(
                    padding: const EdgeInsets.only(right: 13),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: getErrorIcon(isValidLead)))
              ]),
              getHorizontalLine(height: 1)
            ],
          );

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

    final etDescription = TextField(
        controller: _etDescription,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: 'Description',
          enabledBorder: underLineBorder,
          focusedBorder: underLineBorder,
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
              )),
          hintText: 'Due Date and Time',
          enabledBorder: underLineBorder,
          focusedBorder: underLineBorder,
        ));

    final etOwner = TextField(
        controller: _etOwner,
        readOnly: true,
        onTap: () {
          selectOwner(context);
        },
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

    final etCollaborators = TextField(
        controller: _etCollaborators,
        readOnly: true,
        onTap: () {
          selectCollaborators(context);
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                selectCollaborators(context);
              },
              icon: Icon(Icons.keyboard_arrow_down_rounded,
                  color: isValidCollab
                      ? AppTheme.colorDarkGrey
                      : AppTheme.colorRed)),
          hintText: 'Collaborators',
          hintStyle: TextStyle(
              color:
                  isValidCollab ? AppTheme.colorDarkGrey : AppTheme.colorRed),
          enabledBorder: underLineBorder,
          focusedBorder: underLineBorder,
        ));

    final chkMarkAsCompleted =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        activeColor: AppTheme.colorPrimary,
        controlAffinity: ListTileControlAffinity.leading,
        title: const Text('Mark as Completed'),
        value: markAsCompleted,
        onChanged: (v) {
          setState(() {
            markAsCompleted = v!;
          });
        },
      ),
      AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: markAsCompleted
              ? Container(
                  key: const Key("key"),
                  child: Column(children: [
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
                  ]))
              : Container()),
    ]);

    final btnSave = OutlinedButton(
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
            side: const BorderSide(width: 1.0, color: AppTheme.colorPrimary),
            primary: AppTheme.white,
            backgroundColor: AppTheme.colorPrimary),
        onPressed: () {
          saveTask();
        });

    final drpTaskType = DropdownButton<TaskType>(
        isExpanded: true,
        value: taskType,
        icon: loadingTaskType
            ? const SpinKitFadingCircle(
                color: AppTheme.colorPrimary,
                size: 20,
              )
            : isValidTask
                ? const Padding(
                    padding: EdgeInsets.only(right: 13),
                    child: Icon(Icons.keyboard_arrow_down_rounded))
                : const Padding(
                    padding: EdgeInsets.only(right: 13),
                    child: Icon(Icons.error_outline, color: AppTheme.colorRed)),
        iconSize: 24,
        elevation: 16,
        underline: Container(height: 1, color: Colors.transparent),
        onChanged: (TaskType? c) {
          setState(() {
            taskType = c!;
            if (c.id != 0) {
              isValidTask = true;
            }
          });
        },
        items: types.map((TaskType user) {
          return DropdownMenuItem<TaskType>(
              value: user, child: Text(user.name!));
        }).toList());

    final notifyView =
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
    ]);

    return Scaffold(
        appBar: getAppBar(
            taskDetails != null ? Strings.editTask : Strings.addTask,
            bgColor: AppTheme.colorPrimary,
            iconColor: AppTheme.white),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        searchLead,
                        getVerticalGap(height: 5),
                        etTitle,
                        getVerticalGap(height: 5),
                        etDescription,
                        getVerticalGap(height: 5),
                        drpTaskType,
                        getVerticalGap(height: 3),
                        getHorizontalLine(),
                        getVerticalGap(height: 5),
                        etFromDate,
                        getVerticalGap(height: 5),
                        etOwner,
                        getVerticalGap(height: 5),
                        etCollaborators,
                        getVerticalGap(),
                        showmarkComplete ? chkMarkAsCompleted : notifyView
                      ])),
                ),
                Container(child: btnSave)
              ],
            )));
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
  void onTokenExpired(String errorMsg, int responseCode, int requestCode) {
    if (isProgress) hideProgress();
    if (requestCode == ApiRequest.SEARCH_CONTACT && _stateSetter != null) {
      _stateSetter!(() {
        isSearchingLeads = false;
      });
    }
    showInvalidTokenDialog(errorMsg);
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
      case ApiRequest.GET_COLLABORATORS:
        collaborators.clear();
        collaborators
            .addAll(CollaboratorListResponse.fromJson(jsonData).collaborators!);
        collaborators
            .removeWhere((element) => element.id == UserDetails.userId);
        if (taskDetails != null) {
          if (taskDetails?.collaborators != null) {
            for (int i = 0; i < taskDetails!.collaborators!.length; i++) {
              //colabs.add(taskDetails!.collaborators![i].id.toString());
              for (int j = 0; j < collaborators.length; j++) {
                if (collaborators[j].id == taskDetails!.collaborators![i].id) {
                  collaborators[j].isChecked = true;
                  break;
                }
              }
            }
          }
        }
        break;
      case ApiRequest.GET_COLLEAGUE_LIST:
        colleagues.clear();
        colleagues
            .addAll(CollaboratorListResponse.fromJson(jsonData).collaborators!);
        break;
      case ApiRequest.GET_OUTCOMES:
        final outComeData = OutComeList.fromJson(jsonData);
        outComes.clear();
        outComes
            .add(OutCome(id: 0, code: '', text: 'Select Outcome', remark: ''));
        outComes.addAll(outComeData.outComes!);
        sOutCome = outComes[0];
        break;
      case ApiRequest.SAVE_TASK_APPOINTMENT:
        if (taskDetails != null) {
          showToast('Task Edited Successfully');
        } else {
          showToast('Task Created Successfully');
        }
        Navigator.pop(context, true);
        break;
      case ApiRequest.GET_TASK_TYPES:
        final t = TaskTypeResponse.fromJson(jsonData);
        setState(() {
          types.addAll(t.types!);
          loadingTaskType = false;
        });
        break;
    }
  }

  void searchLeadContacts(String query) {
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {'UserId': UserDetails.userId, 'Term': query, 'Mode': 'Lead'}
    };
    ApiCall.makeApiCall(ApiRequest.SEARCH_CONTACT, params, Method.POST,
        ApiConstants.SEARCH_CONTACT, this);
  }

  void getCollaborators() {
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {'UserId': UserDetails.userId}
    };
    ApiCall.makeApiCall(ApiRequest.GET_COLLABORATORS, params, Method.POST,
        ApiConstants.GET_COLLABORATORS, this);
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

  void getTaskTypes() {
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {'UserId': UserDetails.userId}
    };
    ApiCall.makeApiCall(ApiRequest.GET_TASK_TYPES, params, Method.POST,
        ApiConstants.GET_TASK_TYPES, this);
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

  void showFromDatePicker() {
    DatePicker.showDateTimePicker(context, onConfirm: (d) {
      startDateTime = d;
      setState(() {
        customNotifyEmail = startDateTime.subtract(const Duration(minutes: 15));
        customNotifySms = startDateTime.subtract(const Duration(minutes: 15));
        _etFromDate.text = getFormatedDateTime(d,
            outPutFormat: DateFormats.dd_MMM_yyyy_HH_mm_ss);
        final cSub30 = DateTime.now().subtract(const Duration(minutes: 30));
        if (d.isBefore(cSub30)) {
          showmarkComplete = true;
          markAsCompleted = true;
        } else {
          showmarkComplete = false;
        }
      });
    });
  }

  void selectCollaborators(context) async {
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
                        itemCount: collaborators.length,
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
                                                    collaborators[index]
                                                        .image)))),
                                    getHorizontalGap(width: 5),
                                    Text(collaborators[index].displayName!,
                                        style: styleMediumColor(AppTheme.black,
                                            fontSize: 11))
                                  ]),
                                  collaborators[index].isChecked
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
    _etCollaborators.clear();
    List<String> colabs = [];
    setState(() {
      isValidCollab = true;
      collaborators[index].isChecked = !collaborators[index].isChecked;
      for (int i = 0; i < collaborators.length; i++) {
        if (collaborators[i].isChecked) {
          colabs.add(collaborators[i].id.toString());
        }
      }
      _etCollaborators.text = colabs.join(",");
    });
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
                initialChildSize: 0.50,
                minChildSize: 0.25,
                maxChildSize: 0.70,
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

  void getOutComes() {
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {'UserId': UserDetails.userId}
    };
    ApiCall.makeApiCall(ApiRequest.GET_OUTCOMES, params, Method.POST,
        ApiConstants.GET_OUTCOMES, this);
  }

  void saveTask() {
    hideKeyBoard();
    if (validateForm()) {
      showProgress();
      final Map<String, dynamic> params = {
        'Status': '',
        'Message': '',
        'Token': UserDetails.token,
        'Details': {
          "Id": taskDetails != null ? taskDetails?.id : 0,
          "Title": _etTitle.text.trim(),
          "Description": _etDescription.text.trim(),
          "TaskId": taskType.id,
          "LeadId": selectedLead!.id!,
          "StartDate": "",
          "EndDate": _etFromDate.text.trim(),
          "IsTask": true,
          "IsAppointment": false,
          "IsCompleted": false,
          "AssignedTo":
              selectedOwner != null ? selectedOwner?.id : UserDetails.userId,
          "CreatedBy": UserDetails.userId,
          "CollaboratorUserIds": _etCollaborators.text.trim(),
          "NotifyMe": markAsCompleted ? false : true,
          "IsEmail": true,
          "IsSMS": true,
          "SmsSchedule": getFormatedDateTime(customNotifySms,
              outPutFormat: DateFormats.dd_MMM_yyyy_hh_mm_a),
          "EmailSchedule": getFormatedDateTime(customNotifyEmail,
              outPutFormat: DateFormats.dd_MMM_yyyy_hh_mm_a)
        }
      };

      if (markAsCompleted) {
        params['IsCompleted'] = true;
        params['OutcomesId'] = sOutCome.id;
        params['Remarks'] = _etRemark.text.trim();
      }

      ApiCall.makeApiCall(ApiRequest.SAVE_TASK_APPOINTMENT, params, Method.POST,
          ApiConstants.SAVE_TASK_APPOINTMENT, this);
    }
  }

  bool validateForm() {
    bool valid = true;
    if (selectedLead == null) {
      valid = false;
      setState(() {
        isValidLead = false;
      });
    }
    if (_etTitle.text.isEmpty) {
      valid = false;
      setState(() {
        isValidTitle = false;
      });
    }
/*    if (_etCollaborators.text.isEmpty) {
      valid = false;
      setState(() {
        isValidCollab = false;
      });
    }*/

    if (markAsCompleted) {
      if (sOutCome.id == 0 || _etRemark.text.trim().isEmpty) {
        valid = false;
        showToast('Select Outcome & Enter Remarks');
      }
    }

    if (taskType.id == 0) {
      valid = false;
      setState(() {
        isValidTask = false;
      });
    }
    return valid;
  }

  void setData() {
    selectedLead = UserContact(
        id: taskDetails?.lead?.id,
        name: taskDetails?.lead?.name,
        image: taskDetails?.lead?.image);
    _etTitle.text = taskDetails!.title!;
    _etDescription.text = taskDetails!.description!;
    if (taskDetails != null) {
      if (taskDetails?.collaborators != null) {
        List<String> colabs = [];
        for (int i = 0; i < taskDetails!.collaborators!.length; i++) {
          colabs.add(taskDetails!.collaborators![i].id.toString());
        }
        setState(() {
          _etCollaborators.text = colabs.join(",");
        });
      }
    }
    startDateTime = getDateTimeFromString(
        taskDetails!.startDate!, DateFormats.dd_MMM_yyyy_HH_mm_ss);
    customNotifyEmail = startDateTime.subtract(const Duration(minutes: 15));
    customNotifySms = startDateTime.subtract(const Duration(minutes: 15));
    _etFromDate.text = getFormatedDateTime(startDateTime,
        outPutFormat: DateFormats.dd_MMM_yyyy_HH_mm_ss);
    isDataSet = true;
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
}
