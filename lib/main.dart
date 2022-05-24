import 'package:flutter/material.dart';
import 'ui/home/dashboard.dart';
import 'ui/intro_slider.dart';
import 'ui/login_signup/login.dart';
import 'utils/app_prefs.dart';
import 'utils/app_route.dart';
import 'utils/app_theme.dart';
import 'utils/app_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppPref.getUserData().then((v) {
    if (v != null) {
      AppUtils.setUserData(v);
      runApp(const HomePage());
    } else {
      AppPref.isIntroViewed().then((val) {
        if (val) {
          runApp(const LoginPage());
        } else {
          runApp(const IntroPage());
        }
      });
    }
  });
}

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kit19',
        theme: AppTheme.theme,
        routes: AppRoute.route,
        home: IntroSlider());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kit19',
        theme: AppTheme.theme,
        routes: AppRoute.route,
        home: Dashboard());
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kit19',
        theme: AppTheme.theme,
        routes: AppRoute.route,
        home: Login());
  }
}
