import 'package:flutter/material.dart';

import '../../../base_class.dart';
import '../../../network/api_response.dart';

class LeadList extends StatefulWidget {
  static String tag = 'LeadList';

  @override
  State<StatefulWidget> createState() {
    return _LeadList();
  }
}

class _LeadList extends BaseClass<LeadList> implements ApiResponse {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  @override
  void onError(String errorResponse, int responseCode, int requestCode) {
    // TODO: implement onError
  }

  @override
  void onResponse(String response, int responseCode, int requestCode) {
    // TODO: implement onResponse
  }

  @override
  void onTokenExpired(String errorMsg, int responseCode, int requestCode) {
    // TODO: implement onTokenExpired
  }
}
