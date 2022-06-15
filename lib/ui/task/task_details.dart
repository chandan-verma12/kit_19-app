import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kit_19/ui/appointment/add_appoinments.dart';
import '../../model/out_come_list.dart';
import '../../model/task_details_response.dart';
import '../../network/api_response.dart';
import '../../utils/app_constants.dart';
import '../../utils/strings.dart';
import '../../base_class.dart';
import '../../model/home_calendar_data.dart';
import '../../model/user_data.dart';
import '../../network/api_call.dart';
import '../../network/api_constants.dart';
import '../../network/method.dart';
import '../../utils/app_theme.dart';
import '../../utils/two_button_dialog.dart';
import 'add_task.dart';

class TaskDetailsView extends StatefulWidget {
  static String tag = 'task_details';

  @override
  State<StatefulWidget> createState() {
    return _TaskDetailsView();
  }
}

class _TaskDetailsView extends BaseClass<TaskDetailsView>
    implements ApiResponse {
  Tasks? task;
  TaskDetails? details;
  late TextEditingController _etRemark;
  late Outcomes soutComes;
  File? attachedFile;
  List<Attachments> attachments = [];
  @override
  void initState() {
    super.initState();
    _etRemark = TextEditingController();
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      callDetailsApi();
    });
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
                  itemBuilder: (context) => getPopUpMenus(task))
            ],
            title: Text('Task', style: styleMediumColor(AppTheme.white)),
            backgroundColor: AppTheme.colorPrimary,
            elevation: 0.0),
        body: details != null
            ? Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(children: [
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    if (!equalsIgnoreCase(details!.status,
                                        AppConstants.COMPLETED)) {
                                      if (details!.isEditable!) {
                                        showMarkCompleteDialog();
                                      } else {
                                        showPriviledgeDialog();
                                      }
                                    }
                                  },
                                  icon: Icon(
                                      equalsIgnoreCase(details!.status,
                                              AppConstants.COMPLETED)
                                          ? Icons.check_box_outlined
                                          : Icons.check_box_outline_blank,
                                      size: 24)),
                              getHorizontalGap(width: 10),
                              Column(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(3),
                                            color: getOutComeColor(
                                                details!.outcome!.intent),
                                            child: Text(
                                                getDateTime(
                                                    details!.endDate,
                                                    DateFormats
                                                        .dd_MMM_yyyy_HH_mm_ss,
                                                    outPutFormat:
                                                        DateFormats.MMM_yyyy),
                                                style: styleLightColor(
                                                    AppTheme.white,
                                                    fontSize: 9))),
                                        Text(
                                            getDateTime(
                                                details!.endDate,
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
                                            color: getOutComeColor(
                                                details!.outcome!.intent),
                                            width: 2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(7.0))),
                                  ),
                                  Text(
                                      getDateTime(details!.endDate,
                                          DateFormats.dd_MMM_yyyy_HH_mm_ss,
                                          outPutFormat: DateFormats.hh_mm_a),
                                      style: styleMediumColor(AppTheme.black,
                                          fontSize: 9))
                                ],
                              ),
                            ]),
                            Flexible(
                                child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(details!.title!,
                                              overflow: TextOverflow.ellipsis,
                                              style: styleMedium()),
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  getTaskTypeIcon(
                                                      details?.type?.icon),
                                                  fit: BoxFit.cover,
                                                  height: 24,
                                                  width: 24,
                                                ),
                                                getHorizontalGap(width: 5),
                                                Flexible(
                                                    child: Text(
                                                        details!.type!.name!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: styleRegularColor(
                                                            AppTheme
                                                                .colorDarkGrey)))
                                              ])
                                        ]))),
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
                      getVerticalGap(height: 10),
                      Text(
                        details!.description!,
                        textAlign: TextAlign.start,
                      ),
                      getVerticalGap(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.owner,
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
                                                    details!.owner!.image)))),
                                    getHorizontalGap(width: 10),
                                    Text(details!.owner!.firstName!,
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
                      details!.collaborators!.isNotEmpty
                          ? Text('Collaborator',
                              style: styleRegular(fontSize: 11))
                          : Container(),
                      getVerticalGap(height: 10),
                      for (int i = 0; i < details!.collaborators!.length; i++)
                        Column(children: [
                          Row(children: [
                            Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppTheme.colorGrey),
                                    shape: BoxShape.circle),
                                child: ClipOval(
                                    child: SizedBox.fromSize(
                                        size: const Size.fromRadius(20),
                                        child: loadImage(details!
                                            .collaborators![i].image)))),
                            getHorizontalGap(width: 10),
                            Text(details!.collaborators![i].displayName!,
                                style: styleMedium(fontSize: 12))
                          ]),
                          getVerticalGap(height: 10)
                        ]),
                      getVerticalGap(height: 15),
                      for (int i = 0; i < attachments.length; i++)
                        Column(children: [
                          InkWell(
                              onTap: () {
                                launchURL(attachments[i].fileUrl!);
                              },
                              child: Row(children: [
                                const Icon(Icons.attach_file),
                                getHorizontalGap(width: 10),
                                Flexible(
                                    child: Text("${attachments[i].fileName}",
                                        overflow: TextOverflow.ellipsis)),
                                getHorizontalGap(width: 10),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      showRemoveAttachmentDialog(i);
                                    },
                                    icon: const Image(
                                      image: AssetImage(
                                        'assets/icons/mnu_delete.png',
                                      ),
                                      height: 18,
                                      width: 18,
                                    ))
                              ]))
                        ]),
                      getVerticalGap(),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.all(6),
                        child: Text(details!.status!.toUpperCase()),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: getStatusColor(details?.status),
                                width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7.0))),
                      ),
                      getVerticalGap(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Remarks'),
                              Text(details!.remarks!)
                            ]),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: getStatusColor(details?.status),
                                width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7.0))),
                      )
                    ])))
            : getProgressView());
  }

  onMenuSelected(BuildContext context, int item) {
    switch (item) {
      case AppConstants.MNU_ADD:
        gotoAddTask();
        break;
      case AppConstants.MNU_EDIT:
        gotoEditTask(details);
        break;
      case AppConstants.MNU_ATTACH:
        showImagePickerOptions();
        break;
      case AppConstants.MNU_DELETE:
        showDeleteDialog();
        break;
    }
  }

  void showDeleteDialog() {
    changeSystemUiColor(
        statusBarColor: Colors.transparent,
        navBarColor: Colors.black.withOpacity(0.6));
    var dialog = TwoButtonDialog(
        title: 'Delete Confirmation',
        message: 'Are you sure you want to delete this Appointment?',
        positiveBtnText: Strings.yes,
        negativeBtnText: Strings.no,
        onPostivePressed: () {
          changeSystemUiColor(
              statusBarColor: AppTheme.colorPrimary,
              brightness: Brightness.light);
          deleteTaskAppointment();
        },
        onNegativePressed: () {
          changeSystemUiColor(
              statusBarColor: AppTheme.colorPrimary,
              brightness: Brightness.light);
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

  void deleteTaskAppointment() {
    showProgress();
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {"UserId": UserDetails.userId, "Id": task?.id}
    };
    ApiCall.makeApiCall(ApiRequest.DELETE_TASK_APPOINTMENT, params, Method.POST,
        ApiConstants.DELETE_TASK_APPOINTMENT, this);
  }

  void callDetailsApi() {
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {'UserId': UserDetails.userId, 'Id': int.tryParse(task!.id!)}
    };
    ApiCall.makeApiCall(ApiRequest.TASK_DETAILS, params, Method.POST,
        ApiConstants.TASK_DETAILS, this);
  }

  @override
  void onError(String errorResponse, int responseCode, int requestCode) {
    debugPrint(
        "Msg: ${errorResponse} Response Code ${responseCode} Request Code ${requestCode}");
    if (isProgress) hideProgress();
    showError(errorResponse);
  }

  @override
  void onTokenExpired(String errorMsg, int responseCode, int requestCode) {
    if (isProgress) hideProgress();
    showInvalidTokenDialog(errorMsg);
  }

  @override
  void onResponse(String response, int responseCode, int requestCode) {
    debugPrint(
        "Data: ${response} Response Code ${responseCode} Request Code ${requestCode}");
    if (isProgress) hideProgress();
    var jsonData = json.decode(response);
    switch (requestCode) {
      case ApiRequest.TASK_DETAILS:
        attachments.clear();
        attachments.addAll(
            TaskDetailsResponse.fromJson(jsonData).details!.attachments!);
        setState(() {
          details = TaskDetailsResponse.fromJson(jsonData).details;
        });
        break;
      case ApiRequest.MARK_AS_COMPLETE:
        showToast('Mark as completed successfully');
        Navigator.pop(context, true);
        break;

      case ApiRequest.DELETE_TASK_APPOINTMENT:
        showToast('Task deleted successfully');
        Navigator.pop(context, true);
        break;
      case ApiRequest.UPLOAD_FILE:
        showToast('Attachment uploaded successfully');
        setState(() {
          details = null;
        });
        callDetailsApi();
        break;
    }
  }

  void showMarkCompleteDialog() async {
    List<Outcomes> outcomes = details!.outcomes!;
    outcomes.insert(
        0, Outcomes(id: 0, name: 'Select Outcome', intent: '', remark: ''));
    soutComes = outcomes[0];
    _etRemark.clear();
    changeSystemUiColor(statusBarColor: Colors.transparent);
    soutComes = await showModalBottomSheet(
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
                                Navigator.pop(context, outcomes[0]);
                              },
                              icon: const Icon(Icons.close,
                                  color: AppTheme.black))
                        ],
                      ),
                      getVerticalGap(height: 10),
                      DropdownButton<Outcomes>(
                          isExpanded: true,
                          value: soutComes,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          iconSize: 24,
                          elevation: 16,
                          style: styleMediumColor(AppTheme.black),
                          underline: Container(
                            height: 1.0,
                            color: Colors.grey,
                          ),
                          onChanged: (Outcomes? c) {
                            setState(() {
                              soutComes = c!;
                            });
                          },
                          items: outcomes.map((Outcomes user) {
                            return DropdownMenuItem<Outcomes>(
                                value: user, child: Text(user.name!));
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
                            if (soutComes.id != 0 &&
                                _etRemark.text.trim().isNotEmpty) {
                              soutComes.remark = _etRemark.text.trim();
                              Navigator.pop(context, soutComes);
                            } else {
                              showToast('Select Outcome & Enter Remarks');
                            }
                          })
                    ])));
          });
        });
    if (soutComes.id != 0) {
      markAsCompleted(soutComes);
    }
  }

  void markAsCompleted(Outcomes soutComes) {
    showProgress();
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {
        'Id': task?.id,
        'OutcomeId': soutComes.id,
        'Remarks': soutComes.remark
      }
    };
    ApiCall.makeApiCall(ApiRequest.MARK_AS_COMPLETE, params, Method.POST,
        ApiConstants.MARK_AS_COMPLETE, this);
  }

  void gotoAddTask() async {
    final result = await Navigator.pushNamed(context, AddTask.tag,
        arguments: details?.lead);
    if (result != null) {
      if (result as bool) {
        Navigator.pop(context, true);
      }
    }
  }

  void gotoEditTask(TaskDetails? details) async {
    final result =
        await Navigator.pushNamed(context, AddTask.tag, arguments: details);
    if (result != null) {
      if (result as bool) {
        Navigator.pop(context, true);
      }
    }
  }

  String getTaskTypeIcon(String? iconType) {
    var icon = "assets/icons/document.png";
    switch (iconType) {
      case 'linkedin':
        icon = "assets/icons/linkedin.png";
        break;
      case 'facebook':
        icon = "assets/icons/facebook.png";
        break;
      case 'dsms':
        icon = "assets/icons/sms-icon.png";
        break;
      case 'demail':
        icon = "assets/icons/email.png";
        break;
      case 'voice':
        icon = "assets/icons/voice.png";
        break;
      case 'dnotes':
        icon = "assets/icons/notes.png";
        break;
      case 'document':
        icon = "assets/icons/document.png";
        break;
      case 'followup':
        icon = "assets/icons/followup.png";
        break;
      case 'twitter':
        icon = "assets/icons/twitter.png";
        break;
      case 'whatsapp':
        icon = "assets/icons/whats_app.png";
        break;
    }
    return icon;
  }

  void pickOtherFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      attachedFile = File(result.files.single.path!);
      Navigator.pop(context);
      print(attachedFile?.path);
      print(attachedFile?.path.split("/").last);
      uploadAttachedFile();
    }
  }

  void uploadAttachedFile() {
    showProgress();
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'taskAttachment': {
        "CreatedBy": UserDetails.userId,
        "ParentId": UserDetails.parentID,
        "TaskId": task?.id,
        "Remarks": 'File remarks here'
      }
    };
    ApiCall.makeApiCall(ApiRequest.UPLOAD_FILE, params, Method.UPLOAD,
        ApiConstants.UPLOAD_FILE, this,
        file: attachedFile);
  }

  void deleteAttachedFile() {
    showProgress();
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      "Details": {"Id": 0}
    };
    ApiCall.makeApiCall(ApiRequest.DELETE_FILE, params, Method.POST,
        ApiConstants.DELETE_FILE, this);
  }

  void showRemoveAttachmentDialog(int pos) {
    changeSystemUiColor(
        statusBarColor: Colors.transparent,
        navBarColor: Colors.black.withOpacity(0.6));
    var dialog = TwoButtonDialog(
        title: 'Delete Confirmation',
        message: 'Are you sure you want to delete this?',
        positiveBtnText: Strings.yes,
        negativeBtnText: Strings.no,
        onPostivePressed: () {
          changeSystemUiColor(
              statusBarColor: AppTheme.colorPrimary,
              brightness: Brightness.light);
          removeAttachments(pos);
        },
        onNegativePressed: () {
          changeSystemUiColor(
              statusBarColor: AppTheme.colorPrimary,
              brightness: Brightness.light);
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

  //pickMedia(0, ImageSource.gallery);
  void pickMedia(int mediaType, ImageSource mediaSource) async {
    XFile? result;
    if (mediaType == AppConstants.IMAGE) {
      result = await ImagePicker().pickImage(source: mediaSource);
    }
    if (mediaType == AppConstants.VIDEO) {
      result = await ImagePicker().pickVideo(source: mediaSource);
    }
    if (result != null) {
      attachedFile = File(result.path);
      Navigator.pop(context);
      print(attachedFile?.path);
      print(attachedFile?.path.split("/").last);
      uploadAttachedFile();
    }
  }

  void removeAttachments(int i) {
    setState(() {
      attachments.removeAt(i);
    });
  }

  void showImagePickerOptions() async {
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
                      SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(left: 0),
                                  primary: AppTheme.colorRipple,
                                  backgroundColor: Colors.transparent),
                              onPressed: () {
                                pickOtherFiles();
                              },
                              child: Row(children: [
                                const Icon(Icons.image_outlined),
                                getHorizontalGap(width: 10),
                                Text('Gallery',
                                    style: styleRegularColor(
                                        AppTheme.colorDarkGrey,
                                        fontSize: 14))
                              ]))),
                      SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(left: 0),
                                  primary: AppTheme.colorRipple,
                                  backgroundColor: Colors.transparent),
                              onPressed: () {
                                pickMedia(
                                    AppConstants.IMAGE, ImageSource.camera);
                              },
                              child: Row(children: [
                                const Icon(Icons.camera_alt_outlined),
                                getHorizontalGap(width: 10),
                                Text('Camera',
                                    style: styleRegularColor(
                                        AppTheme.colorDarkGrey,
                                        fontSize: 14))
                              ]))),
                    ])));
          });
        });
    if (r != null) {
      if (r as bool) {
        setState(() {});
      }
    }
  }
}
