import 'dart:async';
import 'package:flutter/material.dart';
import '../ui/home/dashboard.dart';
import '../../utils/app_prefs.dart';
import '../ui/login_signup/login.dart';
import '../utils/app_theme.dart';
import '../utils/strings.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../base_class.dart';

class IntroSlider extends StatefulWidget {
  static String tag = 'intro_slider';

  @override
  State<StatefulWidget> createState() {
    return _IntroSlider();
  }
}

class _IntroSlider extends BaseClass<IntroSlider> {
  int _current = 0;
  late PageController _pagerController;
  late Timer timer;

  @override
  void initState() {
/*     countryCodes.map((e) {
      Country c = Country.fromJson(e);
      _countryList.add(c);
    }); */
    _pagerController = PageController(initialPage: 0);
    timer = Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      if (_current < 6) {
        _current += 1;
        _pagerController.animateToPage(_current,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        _current = 0;
        _pagerController.animateToPage(_current,
            duration: const Duration(milliseconds: 10), curve: Curves.easeIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    changeSystemUiColor();

    final skip = Card(
        color: AppTheme.colorSearchBg,
        elevation: 3,
        child: OutlinedButton(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                Strings.skip,
                style: styleMediumColor(AppTheme.black),
              ),
            ),
            style: OutlinedButton.styleFrom(
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
                side: const BorderSide(width: 1.0, color: Colors.transparent),
                primary: AppTheme.colorRipple,
                backgroundColor: AppTheme.colorSearchBg),
            onPressed: () {
              gotoLogin();
            }));

    final next = Card(
        color: AppTheme.colorSearchBg,
        elevation: 3,
        child: OutlinedButton(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                Strings.next,
                style: styleMediumColor(AppTheme.white),
              ),
            ),
            style: OutlinedButton.styleFrom(
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
                side:
                    const BorderSide(width: 1.0, color: AppTheme.colorPrimary),
                primary: AppTheme.white,
                backgroundColor: AppTheme.colorPrimary),
            onPressed: () {
              if (_current < 6) {
                _current += 1;
              } else {
                gotoLogin();
              }
              _pagerController.animateToPage(_current,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
            }));

    final skipNext = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [skip, next]);

    final signInWithGoogle = Card(
        color: AppTheme.colorSearchBg,
        elevation: 3,
        child: OutlinedButton(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    Strings.googleSignIn,
                    style: styleMediumColor(AppTheme.black),
                  ),
                ),
                Image.asset('assets/icons/google.png', height: 24)
              ],
            ),
            style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 1.0, color: Colors.transparent),
                primary: AppTheme.colorRipple,
                backgroundColor: AppTheme.colorSearchBg),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
                (Route<dynamic> route) => false,
              );
            }));

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(30),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                  height: 350,
                  child: PageView(
                    controller: _pagerController,
                    children: getItems(),
                    onPageChanged: (int index) {
                      setState(() {
                        _current = index;
                      });
                    },
                  )),
              getVerticalGap(height: 30),
              SmoothPageIndicator(
                  controller: _pagerController, // PageController
                  count: getItems().length,
                  effect: const WormEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 10,
                      dotColor: AppTheme.colorGrey,
                      activeDotColor:
                          AppTheme.colorPrimary), // your preferred effect
                  onDotClicked: (index) {
                    setState(() {
                      _current = index;
                      _pagerController.animateToPage(_current,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    });
                  }),
              getVerticalGap(height: 60),
              skipNext,
            ])));
  }

  List<Widget> getItems() {
    List<Widget> items = [];
    items.add(Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/intro_1.png',
          height: 200,
        ),
        getVerticalGap(),
        Text(
          Strings.intro1Title,
          textAlign: TextAlign.center,
          style: styleBoldColor(AppTheme.black, fontSize: 16),
        ),
        getVerticalGap(height: 10),
        Text(Strings.intro1Msg, textAlign: TextAlign.center)
      ],
    ));
    items.add(Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/intro_2.png',
          height: 200,
        ),
        getVerticalGap(),
        Text(
          Strings.intro2Title,
          textAlign: TextAlign.center,
          style: styleBoldColor(AppTheme.black, fontSize: 16),
        ),
        getVerticalGap(height: 10),
        Text(Strings.intro2Msg, textAlign: TextAlign.center)
      ],
    ));
    items.add(Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/intro_3.png',
          height: 200,
        ),
        getVerticalGap(),
        Text(
          Strings.intro3Title,
          textAlign: TextAlign.center,
          style: styleBoldColor(AppTheme.black, fontSize: 16),
        ),
        getVerticalGap(height: 10),
        Text(Strings.intro3Msg, textAlign: TextAlign.center)
      ],
    ));
    items.add(Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/intro_4.png',
          height: 200,
        ),
        getVerticalGap(),
        Text(
          Strings.intro4Title,
          textAlign: TextAlign.center,
          style: styleBoldColor(AppTheme.black, fontSize: 16),
        ),
        getVerticalGap(height: 10),
        Text(Strings.intro4Msg, textAlign: TextAlign.center)
      ],
    ));
    items.add(Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/intro_5.png',
          height: 200,
        ),
        getVerticalGap(),
        Text(
          Strings.intro5Title,
          textAlign: TextAlign.center,
          style: styleBoldColor(AppTheme.black, fontSize: 16),
        ),
        getVerticalGap(height: 10),
        Text(Strings.intro5Msg, textAlign: TextAlign.center)
      ],
    ));
    items.add(Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/intro_6.png',
          height: 200,
        ),
        getVerticalGap(),
        Text(
          Strings.intro6Title,
          textAlign: TextAlign.center,
          style: styleBoldColor(AppTheme.black, fontSize: 16),
        ),
        getVerticalGap(height: 10),
        Text(Strings.intro6Msg, textAlign: TextAlign.center)
      ],
    ));
    items.add(Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/intro_7.png',
          height: 200,
        ),
        getVerticalGap(),
        Text(
          Strings.intro7Title,
          textAlign: TextAlign.center,
          style: styleBoldColor(AppTheme.black, fontSize: 16),
        ),
        getVerticalGap(height: 10),
        Text(Strings.intro7Msg, textAlign: TextAlign.center)
      ],
    ));
    return items;
  }

  void gotoLogin() {
    AppPref.setIntroViewed(true);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (Route<dynamic> route) => false,
    );
  }
}
