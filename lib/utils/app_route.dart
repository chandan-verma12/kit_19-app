import 'package:flutter/material.dart';
import '../ui/follwup/add_followup.dart';
import '../ui/follwup/followup_details.dart';
import '../ui/appointment/add_appoinments.dart';
import '../ui/appointment/pick_mao_location.dart';
import '../ui/call/add_call_schedule.dart';
import '../ui/call/call_details.dart';
import '../ui/appointment/appointment_details.dart';
import '../ui/home/dashboard.dart';
import '../ui/login_signup/enter_signup_email.dart';
import '../ui/login_signup/forgot_password.dart';
import '../ui/login_signup/login.dart';
import '../ui/login_signup/signup.dart';
import '../ui/login_signup/signup_done.dart';
import '../ui/intro_slider.dart';
import '../ui/task/add_task.dart';
import '../ui/task/task_details.dart';
import '../ui/web_view_page.dart';

class AppRoute {
  static Map<String, WidgetBuilder> route = <String, WidgetBuilder>{
    IntroSlider.tag: (context) => IntroSlider(),
    Login.tag: (context) => Login(),
    ForgotPassword.tag: (context) => ForgotPassword(),
    EnterSignupEmail.tag: (context) => EnterSignupEmail(),
    Signup.tag: (context) => Signup(),
    SignupDone.tag: (context) => SignupDone(),
    Dashboard.tag: (context) => Dashboard(),
    WebViewPage.tag: (context) => WebViewPage(),
    AppointmentDetails.tag: (context) => AppointmentDetails(),
    AddAppointment.tag: (context) => AddAppointment(),
    PickMapLocation.tag: (context) => PickMapLocation(),
    CallLogDetails.tag: (context) => CallLogDetails(),
    AddCallSchedule.tag: (context) => AddCallSchedule(),
    FollowupDetails.tag: (context) => FollowupDetails(),
    AddFollowUp.tag: (context) => AddFollowUp(),
    AddTask.tag: (context) => AddTask(),
    TaskDetailsView.tag: (context) => TaskDetailsView()
  };
}
