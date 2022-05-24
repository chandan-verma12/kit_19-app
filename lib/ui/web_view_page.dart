import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../base_class.dart';
import '../../utils/app_theme.dart';
import '../../utils/arguments.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  static String tag = 'web_view_page';

  @override
  State<StatefulWidget> createState() {
    return _WebViewPage();
  }
}

class _WebViewPage extends BaseClass<WebViewPage> {
  int pageLoadPercent = 0;
  WebViewController? webController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    var data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return WillPopScope(
        child: Scaffold(
            appBar: getAppBar(
              data[Arguments.TITLE]!,
            ),
            backgroundColor: AppTheme.white,
            body: Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: WebView(
                      initialUrl: data['url'],
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageFinished: (String url) {
                        debugPrint(url);
                      },
                      onPageStarted: (String s) {
                        debugPrint(s);
                      },
                      onProgress: (int p) {
                        setState(() {
                          pageLoadPercent = p;
                        });
                      },
                      onWebViewCreated: (WebViewController? controller) async {
                        webController = controller;
                      },
                      onWebResourceError: (error) {
                        showToast('Failed to load');
                      },
                    )),
                pageLoadPercent < 100
                    ? Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          child: const SpinKitFadingCircle(
                            color: AppTheme.white,
                            size: 34,
                          ),
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: AppTheme.colorPrimary),
                        ),
                      )
                    : Container()
              ],
            )),
        onWillPop: _onBack);
  }

  Future<bool> _onBack() async {
    bool goBack = true;
    var value = await webController?.canGoBack();
    if (value!) {
      goBack = false;
      webController?.goBack();
    }
    return goBack;
  }
}
