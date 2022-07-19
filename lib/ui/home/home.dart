import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kit_19/ui/task/task_details.dart';
import '../../ui/appointment/appointment_details.dart';
import '../../ui/call/add_call_schedule.dart';
import '../../ui/call/call_details.dart';
import '../../ui/follwup/add_followup.dart';
import '../../ui/follwup/followup_details.dart';
import '../../ui/task/add_task.dart';
import '../../model/home_calendar_data.dart';
import '../../model/out_come_list.dart';
import '../../model/user_data.dart';
import '../../network/api_call.dart';
import '../../network/api_constants.dart';
import '../../network/api_response.dart';
import '../../network/method.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_theme.dart';
import '../../utils/expanded_view.dart';
import '../../utils/strings.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../base_class.dart';
import '../../utils/app_prefs.dart';
import '../../utils/one_button_dialog.dart';
import '../appointment/add_appoinments.dart';
import '../login_signup/login.dart';

class Home extends StatefulWidget {
  static String tag = 'intro_slider';

  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends BaseClass<Home> implements ApiResponse {
  late DateTime _focusDay, _selectedDay, _firstDay, _lastDay;
  String _currentMonth = '';
  List<DateTime> events = [];
  Map<String, dynamic> dateIndicators = {};
  List<Tasks> _appointments = [],
      _tasks = [],
      _calls = [],
      _folloups = [],
      _appointmentsCompleted = [],
      _tasksCompleted = [],
      _callsCompleted = [],
      _folloupsCompleted = [];
  int _appointmentCount = 0,
      _taskCount = 0,
      _callCount = 0,
      _followupCount = 0,
      _appointmentCountCompleted = 0,
      _taskCountCompleted = 0,
      _callCountCompleted = 0,
      _followupCountCompleted = 0;
  int checkPos = 0, itemType = 0;
  List<OutCome> outComes = [];
  late TextEditingController _etRemark;
  late Tasks _selectedTask;

  @override
  void initState() {
    _etRemark = TextEditingController();
    _focusDay = DateTime.now();
    _selectedDay = DateTime.now();
    events.add(_selectedDay);
    _firstDay = DateTime.utc(_selectedDay.year, 01, 01);
    _lastDay = DateTime.utc(_selectedDay.year, 12, 31);
    _currentMonth = getFormatedDateTime(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      callHomeApi(_selectedDay);
/*       Future.delayed(const Duration(milliseconds: 100), () {
        //callHomeApi(DateTime.utc(2022, 03, 13)); //13 Mar 2022
        callHomeApi(_selectedDay);
      }); */
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final btChangeMonth = TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            primary: AppTheme.colorRipple),
        onPressed: () {
          _showDatePicker(context);
        },
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _currentMonth,
                style: styleMediumColor(AppTheme.black),
              ),
              getHorizontalGap(width: 5),
              const Icon(Icons.calendar_today_outlined,
                  size: 16, color: AppTheme.black)
            ]));

    final btToday = TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            primary: AppTheme.colorRipple),
        onPressed: () {
          updateWeekCalendar(DateTime.now());
        },
        child: Text(
          Strings.today,
          style: styleMediumColor(AppTheme.black),
        ));

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    shape: BoxShape.circle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(24), // Image radius
                    child: UserDetails.profilePicturePath.isEmpty
                        ? Image.asset("assets/icons/user_place_holder.png")
                        : Image.network(UserDetails.profilePicturePath),
                  ),
                ),
              ),
              getVerticalGap(),
              Stack(children: [btToday, Center(child: btChangeMonth)]),
              getVerticalGap(),
              TableCalendar(
                  rowHeight: 64,
                  eventLoader: _getEventsForDay,
                  firstDay: _firstDay,
                  lastDay: _lastDay,
                  focusedDay: _focusDay,
                  currentDay: _selectedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusDay = focusedDay;
                      });
                      callHomeApi(selectedDay);
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusDay = focusedDay;
                    setState(() {
                      _currentMonth = getFormatedDateTime(focusedDay);
                    });
                  },
                  calendarFormat: CalendarFormat.week,
                  calendarBuilders: CalendarBuilders(
                      singleMarkerBuilder: (context, day, value) {
                    return Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                          color: hexToColor(value.toString()),
                          shape: BoxShape.circle),
                    );
                  }, outsideBuilder: (context, day, _) {
                    final text = DateFormat.d().format(day);
                    return Container(
                      height: 34,
                      width: 34,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(top: 9),
                      child: Text(
                        text.toUpperCase(),
                        style: styleMediumColor(AppTheme.black),
                      ),
                    );
                  }, selectedBuilder: (context, day, _) {
                    final text = DateFormat.d().format(day);
                    return Container(
                      height: 34,
                      width: 34,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(top: 9),
                      color: AppTheme.colorPrimary,
                      child: Text(
                        text.toUpperCase(),
                        style: styleMediumColor(AppTheme.white),
                      ),
                    );
                  }, defaultBuilder: (context, day, _) {
                    final text = DateFormat.d().format(day);
                    return Container(
                      height: 34,
                      width: 34,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(top: 9),
                      child: Text(
                        text.toUpperCase(),
                        style: styleMediumColor(AppTheme.black),
                      ),
                    );
                  }, dowBuilder: (context, day) {
                    final text = DateFormat.E().format(day);
                    return Center(
                      child: Text(
                        text.toUpperCase(),
                        style: styleMediumColor(AppTheme.black),
                      ),
                    );
                    /*      if (day.weekday == DateTime.sunday) {
                      final text = DateFormat.E().format(day);

                      return Center(
                        child: Text(
                          text.toUpperCase(),
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } */
                  }),
                  headerVisible: false,
                  calendarStyle: const CalendarStyle(
                      markersAlignment: Alignment.topCenter,
                      markersAnchor: 1,
                      markerSize: 5)),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    getAppointmentView(),
                    getTaskView(),
                    getFollowupView(),
                    getCallLogView()
                  ])))
            ])));
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    final eventDay = getFormatedDateTime(day, outPutFormat: 'dd-MMM-yyyy');
    if (dateIndicators.containsKey(eventDay)) {
      return [dateIndicators[eventDay]];
    }
    return [];
  }

  _showDatePicker(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDay,
      firstDate: DateTime.utc(selectedDate.year - 2, 01, 01),
      lastDate: DateTime.utc(selectedDate.year + 2, 12, 31),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: '',
      initialDatePickerMode: DatePickerMode.day,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppTheme.white,
              onPrimary: Colors.black,
              surface: AppTheme.colorPrimary,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: AppTheme.colorPrimary,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      updateWeekCalendar(picked);
    }
  }

  itemView(int pos, int type) {
    Tasks? task;
    if (type == AppConstants.TYPE_APPOINTMENT) task = _appointments[pos];
    if (type == AppConstants.TYPE_TASK) task = _tasks[pos];
    return InkWell(
        onTap: () {
          if (type == AppConstants.TYPE_APPOINTMENT) {
            gotoAppointmentDetails(task);
          }
          if (type == AppConstants.TYPE_TASK) {
            gotoTaskDetails(task);
          }
        },
        child: Container(
            color: AppTheme.colorGreyLight,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                getOutComes(pos, type);
                              },
                              icon: const Icon(
                                  Icons.check_box_outline_blank_rounded,
                                  size: 24)),
                          getHorizontalGap(width: 10),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(getString(task!.title),
                                  style: styleMediumColor(AppTheme.black)),
                              Text(
                                  getDateTime(task.endDate,
                                      DateFormats.dd_MMM_yyyy_HH_mm_ss,
                                      outPutFormat: DateFormats.hh_mm_a),
                                  style: styleRegularColor(
                                      AppTheme.colorDarkGrey,
                                      fontSize: 10))
                            ],
                          ))
                        ]),
                        getVerticalGap(height: 10),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_box_outline_blank_rounded,
                                  color: AppTheme.colorGreyLight),
                              getHorizontalGap(width: 12),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppTheme.colorPrimary,
                                          width: 0),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      shape: BoxShape.rectangle),
                                  child: Image.network(task.personImage!,
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.cover)),
                              getHorizontalGap(width: 10),
                              Text(getString(task.personName),
                                  style: styleRegular(fontSize: 11)),
                              getHorizontalGap(width: 10),
                              getString(task.outCome).toString().isNotEmpty
                                  ? Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(
                                          color: getOutComeColor(task.intent),
                                          shape: BoxShape.circle))
                                  : Container(),
                              getHorizontalGap(width: 10),
                              Flexible(
                                  child: getString(task.outCome)
                                          .toString()
                                          .isNotEmpty
                                      ? Text(
                                          getString(task.outCome),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : Container())
                            ]),
                      ])),
              getVerticalGap(height: 5),
              getHorizontalLine()
            ])));
  }

  itemViewCompleted(int type) {
    List<Tasks?> tasks = [];
    tasks.clear();
    if (type == AppConstants.TYPE_APPOINTMENT) {
      tasks.addAll(_appointmentsCompleted);
    }
    if (type == AppConstants.TYPE_TASK) {
      tasks.addAll(_tasksCompleted);
    }
    if (type == AppConstants.TYPE_FOLLOWUP) {
      tasks.addAll(_folloupsCompleted);
    }
    List<Widget> data = [];
    for (var i = 0; i < tasks.length; i++) {
      data.add(InkWell(
          onTap: () {
            if (type == AppConstants.TYPE_APPOINTMENT) {
              gotoAppointmentDetails(tasks[i]);
            }
            if (type == AppConstants.TYPE_TASK) {
              gotoTaskDetails(tasks[i]);
            }
            if (type == AppConstants.TYPE_FOLLOWUP) {
              gotoFollowUpDetails(tasks[i]);
            }
          },
          child: Container(
              color: AppTheme.colorGreyLight,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                const Icon(Icons.check_box_outlined, size: 24),
                                getHorizontalGap(width: 10),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(getString(tasks[i]!.title),
                                        style:
                                            styleMediumColor(AppTheme.black)),
                                    Text(
                                        getDateTime(tasks[i]!.endDate,
                                            DateFormats.dd_MMM_yyyy_HH_mm_ss,
                                            outPutFormat: DateFormats.hh_mm_a),
                                        style: styleRegularColor(
                                            AppTheme.colorDarkGrey,
                                            fontSize: 10))
                                  ],
                                ))
                              ]),
                              getVerticalGap(height: 10),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                        Icons.check_box_outline_blank_rounded,
                                        color: AppTheme.colorGreyLight),
                                    getHorizontalGap(width: 12),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppTheme.colorPrimary,
                                                width: 0),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            shape: BoxShape.rectangle),
                                        child: Image.network(
                                            tasks[i]!.personImage!,
                                            height: 24,
                                            width: 24,
                                            fit: BoxFit.cover)),
                                    getHorizontalGap(width: 10),
                                    Text(getString(tasks[i]!.personName),
                                        style: styleRegular(fontSize: 11)),
                                    getHorizontalGap(width: 10),
                                    getString(tasks[i]!.outCome)
                                            .toString()
                                            .isNotEmpty
                                        ? Container(
                                            height: 8,
                                            width: 8,
                                            decoration: BoxDecoration(
                                                color: getOutComeColor(
                                                    tasks[i]!.intent),
                                                shape: BoxShape.circle))
                                        : Container(),
                                    getHorizontalGap(width: 10),
                                    Flexible(
                                        child: getString(tasks[i]!.outCome)
                                                .toString()
                                                .isNotEmpty
                                            ? Text(
                                                getString(tasks[i]!.outCome),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : Container())
                                  ]),
                            ])),
                    getVerticalGap(height: 5),
                    i == tasks.length - 1 ? Container() : getHorizontalLine()
                  ]))));
    }
    return data;
  }

  itemViewFollowUp(int pos) {
    Tasks? task = _folloups[pos];
    return InkWell(
        onTap: () {
          gotoFollowUpDetails(task);
        },
        child: Container(
            color: AppTheme.colorGreyLight,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(getString(task.title),
                                  style: styleMediumColor(AppTheme.black)),
                              Text(
                                  getDateTime(task.endDate,
                                      DateFormats.dd_MMM_yyyy_HH_mm_ss,
                                      outPutFormat: DateFormats.hh_mm_a),
                                  style: styleRegularColor(
                                      AppTheme.colorDarkGrey,
                                      fontSize: 10))
                            ],
                          ))
                        ]),
                        getVerticalGap(height: 10),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppTheme.colorPrimary,
                                          width: 0),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      shape: BoxShape.rectangle),
                                  child: Image.network(task.personImage!,
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.cover)),
                              getHorizontalGap(width: 10),
                              Text(getString(task.personName),
                                  style: styleRegular(fontSize: 11)),
                              getHorizontalGap(width: 10),
                              getString(task.outCome).toString().isNotEmpty
                                  ? Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(
                                          color: getOutComeColor(task.intent),
                                          shape: BoxShape.circle))
                                  : Container(),
                              getHorizontalGap(width: 10),
                              Flexible(
                                  child: getString(task.outCome)
                                          .toString()
                                          .isNotEmpty
                                      ? Text(
                                          getString(task.outCome),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : Container())
                            ]),
                      ])),
              getVerticalGap(height: 5),
              getHorizontalLine()
            ])));
  }

  getCallTypeIcon(String? status) {
    var callIcon = "assets/icons/schedule_call.png";
    if (status != null) {
      switch (status) {
        case AppConstants.SCHEDULE:
          callIcon = "assets/icons/schedule_call.png";
          break;
        case AppConstants.OUT_GOING:
          callIcon = "assets/icons/outgoing_call.png";
          break;
        case AppConstants.MISSED:
          callIcon = "assets/icons/missed_call.png";
          break;
        case AppConstants.INCOMING:
          callIcon = "assets/icons/incoming_call.png";
          break;
      }
    }
    return Image.asset(callIcon, height: 24, width: 24, fit: BoxFit.cover);
  }

  itemCallViewCompleted() {
    List<Tasks?> tasks = _callsCompleted;
    List<Widget> data = [];
    for (var i = 0; i < tasks.length; i++) {
      Tasks task = tasks[i]!;
      data.add(InkWell(
          onTap: () {
            gotoCallDetails(task);
          },
          child: Container(
              color: AppTheme.colorGreyLight,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                getCallTypeIcon(task.taskStatus),
                                getHorizontalGap(width: 10),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(getString(task.title),
                                        style:
                                            styleMediumColor(AppTheme.black)),
                                    Text(
                                        getDateTime(task.endDate,
                                            DateFormats.dd_MMM_yyyy_HH_mm_ss,
                                            outPutFormat: DateFormats.hh_mm_a),
                                        style: styleRegularColor(
                                            AppTheme.colorDarkGrey,
                                            fontSize: 10))
                                  ],
                                ))
                              ]),
                              getVerticalGap(height: 10),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                        Icons.check_box_outline_blank_rounded,
                                        color: AppTheme.colorGreyLight),
                                    getHorizontalGap(width: 12),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppTheme.colorPrimary,
                                                width: 0),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            shape: BoxShape.rectangle),
                                        child: Image.network(task.personImage!,
                                            height: 24,
                                            width: 24,
                                            fit: BoxFit.cover)),
                                    getHorizontalGap(width: 10),
                                    Text(getString(task.personName),
                                        style: styleRegular(fontSize: 11)),
                                    getHorizontalGap(width: 10),
                                    getString(task.outCome)
                                            .toString()
                                            .isNotEmpty
                                        ? Container(
                                            height: 8,
                                            width: 8,
                                            decoration: BoxDecoration(
                                                color: getOutComeColor(
                                                    task.intent),
                                                shape: BoxShape.circle))
                                        : Container(),
                                    getHorizontalGap(width: 10),
                                    Flexible(
                                        child: getString(task.outCome)
                                                .toString()
                                                .isNotEmpty
                                            ? Text(
                                                getString(task.outCome),
                                                style:
                                                    styleRegular(fontSize: 11),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : Container())
                                  ]),
                            ])),
                    getVerticalGap(height: 5),
                    i == tasks.length - 1 ? Container() : getHorizontalLine()
                  ]))));
    }
    return data;
  }

  itemViewCall(int pos) {
    Tasks? task = _calls[pos];
    return InkWell(
        onTap: () {
          gotoCallDetails(task);
        },
        child: Container(
            color: AppTheme.colorGreyLight,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          getCallTypeIcon(task.taskStatus),
                          getHorizontalGap(width: 10),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(getString(task.title),
                                  style: styleMediumColor(AppTheme.black)),
                              Text(
                                  getDateTime(task.endDate,
                                      DateFormats.dd_MMM_yyyy_HH_mm_ss,
                                      outPutFormat: DateFormats.hh_mm_a),
                                  style: styleRegularColor(
                                      AppTheme.colorDarkGrey,
                                      fontSize: 10))
                            ],
                          ))
                        ]),
                        getVerticalGap(height: 10),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_box_outline_blank_rounded,
                                  color: AppTheme.colorGreyLight),
                              getHorizontalGap(width: 12),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppTheme.colorPrimary,
                                          width: 0),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      shape: BoxShape.rectangle),
                                  child: Image.network(task.personImage!,
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.cover)),
                              getHorizontalGap(width: 10),
                              Text(getString(task.personName),
                                  style: styleRegular(fontSize: 11)),
                              getHorizontalGap(width: 10),
                              getString(task.outCome).toString().isNotEmpty
                                  ? Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(
                                          color: getOutComeColor(task.intent),
                                          shape: BoxShape.circle))
                                  : Container(),
                              getHorizontalGap(width: 10),
                              Flexible(
                                  child: getString(task.outCome)
                                          .toString()
                                          .isNotEmpty
                                      ? Text(
                                          getString(task.outCome),
                                          style: styleRegular(fontSize: 11),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : Container())
                            ]),
                      ])),
              getVerticalGap(height: 5),
              getHorizontalLine()
            ])));
  }

  noDataView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icons/smile.png",
          height: 128,
          width: 128,
        ),
        getVerticalGap(),
        Text(Strings.noActivities),
        getVerticalGap(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.colorRipple),
                onPressed: () {},
                child: Text(
                  Strings.enquery,
                  style: styleRegularColor(AppTheme.colorPrimary),
                )),
            getHorizontalGap(),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.colorRipple),
                onPressed: () {},
                child: Text(
                  Strings.lead,
                  style: styleRegularColor(AppTheme.colorPrimary),
                ))
          ],
        ),
        getVerticalGap(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.colorRipple),
                onPressed: () {},
                child: Text(
                  Strings.followup,
                  style: styleRegularColor(AppTheme.colorPrimary),
                )),
            getHorizontalGap(),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.colorRipple),
                onPressed: () {},
                child: Text(
                  Strings.task,
                  style: styleRegularColor(AppTheme.colorPrimary),
                )),
            getHorizontalGap(),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.colorRipple),
                onPressed: () {},
                child: Text(
                  Strings.enquery,
                  style: styleRegularColor(AppTheme.colorPrimary),
                )),
            getHorizontalGap(),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: AppTheme.colorRipple),
                onPressed: () {},
                child: Text(
                  Strings.deal,
                  style: styleRegularColor(AppTheme.colorPrimary),
                ))
          ],
        )
      ],
    );
  }

  getAppointmentView() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      getVerticalGap(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(Strings.appointment_, style: styleMedium()),
        IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.add,
              color: AppTheme.colorPrimary,
            ),
            onPressed: () {
              gotoAddAppointment();
            })
      ]),
      Text(getDueOverdueText(AppConstants.TYPE_APPOINTMENT),
          style: styleRegularColor(AppTheme.colorDarkGrey, fontSize: 10)),
      getVerticalGap(height: 5),
      _appointmentCount == 0
          ? getAllCaughtUpView()
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, position) {
                return itemView(position, AppConstants.TYPE_APPOINTMENT);
              },
              itemCount: _appointmentCount,
            ),
      _appointmentCountCompleted > 0
          ? Column(
              children: [
                Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpandedView(
                      title: Text(
                          "$_appointmentCountCompleted ${AppConstants.COMPLETED}",
                          style: styleMediumColor(AppTheme.colorPrimary)),
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: EdgeInsets.zero,
                      children:
                          itemViewCompleted(AppConstants.TYPE_APPOINTMENT),
                    )),
                getHorizontalLine()
              ],
            )
          : Container()
    ]);
  }

  getTaskView() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      getVerticalGap(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(Strings.task_, style: styleMedium()),
        IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.add,
              color: AppTheme.colorPrimary,
            ),
            onPressed: () {
              gotoAddTask();
            })
      ]),
      Text(getDueOverdueText(AppConstants.TYPE_TASK),
          style: styleRegularColor(AppTheme.colorDarkGrey, fontSize: 10)),
      getVerticalGap(height: 5),
      _taskCount == 0
          ? getAllCaughtUpView()
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, position) {
                return itemView(position, AppConstants.TYPE_TASK);
              },
              itemCount: _taskCount,
            ),
      _taskCountCompleted > 0
          ? Column(
              children: [
                Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpandedView(
                      title: Text(
                          "$_taskCountCompleted ${AppConstants.COMPLETED}",
                          style: styleMediumColor(AppTheme.colorPrimary)),
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: EdgeInsets.zero,
                      children: itemViewCompleted(AppConstants.TYPE_TASK),
                    )),
                getHorizontalLine()
              ],
            )
          : Container()
    ]);
  }

  getFollowupView() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      getVerticalGap(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(Strings.followup_, style: styleMedium()),
        IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.add,
              color: AppTheme.colorPrimary,
            ),
            onPressed: () {
              gotoAddFollowup();
            })
      ]),
      Text(getDueOverdueText(AppConstants.TYPE_FOLLOWUP),
          style: styleRegularColor(AppTheme.colorDarkGrey, fontSize: 10)),
      getVerticalGap(height: 5),
      _followupCount == 0
          ? getAllCaughtUpView()
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, position) {
                return itemViewFollowUp(position);
              },
              itemCount: _followupCount,
            ),
      _followupCountCompleted > 0
          ? Column(
              children: [
                Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpandedView(
                      title: Text(
                          "$_followupCountCompleted ${AppConstants.COMPLETED}",
                          style: styleMediumColor(AppTheme.colorPrimary)),
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: EdgeInsets.zero,
                      children: itemViewCompleted(AppConstants.TYPE_FOLLOWUP),
                    )),
                getHorizontalLine()
              ],
            )
          : Container()
    ]);
  }

  getCallLogView() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      getVerticalGap(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(Strings.call, style: styleMedium()),
        IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.add,
              color: AppTheme.colorPrimary,
            ),
            onPressed: () {
              gotoCallSchedule();
            })
      ]),
      Text(getDueOverdueText(AppConstants.TYPE_CALLS),
          style: styleRegularColor(AppTheme.colorDarkGrey, fontSize: 10)),
      getVerticalGap(height: 5),
      _callCount == 0
          ? getAllCaughtUpView()
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, position) {
                return itemViewCall(position);
              },
              itemCount: _callCount,
            ),
      _callCountCompleted > 0
          ? Column(
              children: [
                Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpandedView(
                      title: Text(
                          "$_callCountCompleted ${AppConstants.COMPLETED}",
                          style: styleMediumColor(AppTheme.colorPrimary)),
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: EdgeInsets.zero,
                      children: itemCallViewCompleted(),
                    )),
                getHorizontalLine()
              ],
            )
          : Container()
    ]);
  }

  void callHomeApi(DateTime day, {bool isLoading = true}) {
    if (isLoading) showProgress();
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {
        'UserId': UserDetails.userId,
        'ActivityDate': getFormatedDateTime(day, outPutFormat: 'dd MMM yyyy')
      }
    };
    ApiCall.makeApiCall(ApiRequest.HOME_DATA, params, Method.POST,
        ApiConstants.HOME_DATA, this);
  }

  @override
  void onError(String errorResponse, int responseCode, int requestCode) {
    debugPrint(
        "Msg: ${errorResponse} Response Code ${responseCode} Request Code ${requestCode}");
    hideProgress();

    showErrorDialog(Strings.error, errorResponse);
  }

  @override
  void onTokenExpired(String errorMsg, int responseCode, int requestCode) {
    hideProgress();

    showInvalidTokenDialog(errorMsg);
  }

  @override
  void onResponse(String response, int responseCode, int requestCode) {
    debugPrint(
        "Data: ${response} Response Code ${responseCode} Request Code ${requestCode}");
    var jsonData = json.decode(response);
    switch (requestCode) {
      case ApiRequest.HOME_DATA:
        final homeData = HomeCalendarData.fromJson(jsonData);
        checkAndLoadData(homeData.details);
        break;
      case ApiRequest.GET_OUTCOMES:
        hideProgress();
        final outComeData = OutComeList.fromJson(jsonData);
        outComes.clear();
        outComes
            .add(OutCome(id: 0, code: '', text: 'Select Outcome', remark: ''));
        outComes.addAll(outComeData.outComes!);
        showMarkCompleteDialog();
        break;
      case ApiRequest.MARK_AS_COMPLETE:
        callHomeApi(_selectedDay, isLoading: false);
        break;
    }
  }

  void checkAndLoadData(Details? details) {
    dateIndicators.clear();
    if (details?.dateIndicators != null) {
      final ind = details?.dateIndicators;
      for (int i = 0; i < ind!.length; i++) {
        dateIndicators[ind[i].date!] = ind[i].color!;
      }
    }
    print(dateIndicators);

    List<Tasks> _apnmnts = [], _tsks = [], _fups = [], _cls = [];
    _apnmnts.addAll(details!.appointments!);
    _tsks.addAll(details.tasks!);
    _fups.addAll(details.followUps!);
    _cls.addAll(details.callLogs!);

    _appointments.clear();
    _appointmentsCompleted.clear();
    _tasks.clear();
    _tasksCompleted.clear();
    _folloups.clear();
    _folloupsCompleted.clear();
    _calls.clear();
    _callsCompleted.clear();

    for (var i = 0; i < _apnmnts.length; i++) {
      if (_apnmnts[i].taskStatus == AppConstants.COMPLETED) {
        _appointmentsCompleted.add(_apnmnts[i]);
      } else {
        _appointments.add(_apnmnts[i]);
      }
    }
    for (var i = 0; i < _tsks.length; i++) {
      if (_tsks[i].taskStatus == AppConstants.COMPLETED) {
        _tasksCompleted.add(_tsks[i]);
      } else {
        _tasks.add(_tsks[i]);
      }
    }
    for (var i = 0; i < _fups.length; i++) {
      if (_fups[i].taskStatus == AppConstants.COMPLETED) {
        _folloupsCompleted.add(_fups[i]);
      } else {
        _folloups.add(_fups[i]);
      }
    }
    for (var i = 0; i < _cls.length; i++) {
      if (_cls[i].taskStatus == AppConstants.SCHEDULE) {
        _calls.add(_cls[i]);
      } else {
        _callsCompleted.add(_cls[i]);
      }
    }

    hideProgress();

    setState(() {
      _appointmentCount = _appointments.length;
      _appointmentCountCompleted = _appointmentsCompleted.length;
      _taskCount = _tasks.length;
      _taskCountCompleted = _tasksCompleted.length;
      _followupCount = _folloups.length;
      _followupCountCompleted = _folloupsCompleted.length;
      _callCount = _calls.length;
      _callCountCompleted = _callsCompleted.length;
    });
  }

  String getDueOverdueText(int type) {
    var text = "";
    var totalDue = 0,
        totalOverDue = 0,
        scheduled = 0,
        incoming = 0,
        outgoing = 0,
        missed = 0,
        schedule = 0;
    switch (type) {
      case AppConstants.TYPE_APPOINTMENT:
        for (var element in _appointments) {
          if (element.taskStatus!.toLowerCase() ==
              AppConstants.OVER_DUE.toLowerCase()) {
            totalOverDue += 1;
          }
          if (element.taskStatus!.toLowerCase() ==
              AppConstants.DUE.toLowerCase()) {
            totalDue += 1;
          }
          if (element.taskStatus!.toLowerCase() ==
              AppConstants.SCHEDULED.toLowerCase()) {
            scheduled += 1;
          }
        }
        break;
      case AppConstants.TYPE_TASK:
        for (var element in _tasks) {
          if (element.taskStatus!.toLowerCase() ==
              AppConstants.OVER_DUE.toLowerCase()) {
            totalOverDue += 1;
          }
          if (element.taskStatus!.toLowerCase() ==
              AppConstants.DUE.toLowerCase()) {
            totalDue += 1;
          }
          if (element.taskStatus!.toLowerCase() ==
              AppConstants.SCHEDULED.toLowerCase()) {
            scheduled += 1;
          }
        }
        break;
      case AppConstants.TYPE_FOLLOWUP:
        for (var element in _folloups) {
          if (element.taskStatus!.toLowerCase() ==
              AppConstants.OVER_DUE.toLowerCase()) {
            totalOverDue += 1;
          }
          if (element.taskStatus!.toLowerCase() ==
              AppConstants.DUE.toLowerCase()) {
            totalDue += 1;
          }
          if (element.taskStatus!.toLowerCase() ==
              AppConstants.SCHEDULED.toLowerCase()) {
            scheduled += 1;
          }
        }
        break;
    }
    if (type == AppConstants.TYPE_CALLS) {
      text = "${_calls.length} ${AppConstants.SCHEDULE}";
    } else {
      if (totalDue > 0) {
        text = "$totalDue ${AppConstants.DUE} ";
      }
      if (totalOverDue > 0) {
        text += "$totalOverDue ${AppConstants.OVER_DUE} ";
      }
      if (scheduled > 0) {
        text += "$scheduled ${AppConstants.SCHEDULED}";
      }
    }
    return text;
  }

  void updateWeekCalendar(DateTime picked) {
    setState(() {
      _currentMonth = getFormatedDateTime(picked);
      var d = DateTime(picked.year, picked.month + 1, 0).day;
      _firstDay = DateTime.utc(picked.year, picked.month, 01);
      _lastDay = DateTime.utc(picked.year, picked.month, d);
      _selectedDay = picked;
      _focusDay = picked;
    });
    callHomeApi(picked);
  }

  getAllCaughtUpView() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        color: AppTheme.colorGreyLight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/thumbs.png", width: 34, height: 34),
            getHorizontalGap(width: 15),
            Text(Strings.allCaughtUp, style: styleMedium(fontSize: 14))
          ],
        ));
  }

  void getOutComes(int pos, int type) {
    checkPos = pos;
    itemType = type;
    if (type == AppConstants.TYPE_APPOINTMENT)
      _selectedTask = _appointments[pos];
    if (type == AppConstants.TYPE_TASK) _selectedTask = _tasks[pos];
    if (!_selectedTask.isEditable!) {
      showPriviledgeDialog();
      return;
    }
    showProgress();
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {
        'UserId': UserDetails.userId,
        'TaskId': int.tryParse(_selectedTask.id!)
      }
    };
    ApiCall.makeApiCall(ApiRequest.GET_OUTCOMES, params, Method.POST,
        ApiConstants.GET_OUTCOMES, this);
  }

  void markAsCompleted(OutCome outCome) {
    showProgress();
    final Map<String, dynamic> params = {
      'Status': '',
      'Message': '',
      'Token': UserDetails.token,
      'Details': {
        'Id': int.tryParse(_selectedTask.id!),
        'OutcomeId': outCome.id,
        'Remarks': outCome.remark
      }
    };
    ApiCall.makeApiCall(ApiRequest.MARK_AS_COMPLETE, params, Method.POST,
        ApiConstants.MARK_AS_COMPLETE, this);
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

  void gotoAppointmentDetails(Tasks? task) async {
    final result = await Navigator.pushNamed(context, AppointmentDetails.tag,
        arguments: task);
    if (result != null) {
      if (result as bool) {
        callHomeApi(_selectedDay, isLoading: true);
      }
    }
  }

  void gotoTaskDetails(Tasks? task) async {
    final result = await Navigator.pushNamed(context, TaskDetailsView.tag,
        arguments: task);
    if (result != null) {
      if (result as bool) {
        callHomeApi(_selectedDay, isLoading: true);
      }
    }
  }

  void gotoAddAppointment() async {
    final result = await Navigator.pushNamed(context, AddAppointment.tag);
    if (result != null) {
      if (result as bool) {
        callHomeApi(_selectedDay, isLoading: true);
      }
    }
  }

  void gotoCallDetails(Tasks? task) async {
    final result =
        await Navigator.pushNamed(context, CallLogDetails.tag, arguments: task);
    if (result != null) {
      if (result as bool) {
        callHomeApi(_selectedDay, isLoading: true);
      }
    }
  }

  void gotoCallSchedule() async {
    final result = await Navigator.pushNamed(context, AddCallSchedule.tag);
    if (result != null) {
      if (result as bool) {
        callHomeApi(_selectedDay, isLoading: true);
      }
    }
  }

  void gotoFollowUpDetails(Tasks? task) async {
    final result = await Navigator.pushNamed(context, FollowupDetails.tag,
        arguments: task);
    if (result != null) {
      if (result as bool) {
        callHomeApi(_selectedDay, isLoading: true);
      }
    }
  }

  void gotoAddFollowup() async {
    final result = await Navigator.pushNamed(context, AddFollowUp.tag);
    if (result != null) {
      if (result as bool) {
        callHomeApi(_selectedDay, isLoading: true);
      }
    }
  }

  void gotoAddTask() async {
    final result = await Navigator.pushNamed(context, AddTask.tag);
    if (result != null) {
      if (result as bool) {
        callHomeApi(_selectedDay, isLoading: true);
      }
    }
  }
}
