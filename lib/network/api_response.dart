abstract class ApiResponse {
  void onResponse(String response, int responseCode, int requestCode);
  void onError(String errorResponse, int responseCode, int requestCode);
  void onTokenExpired(String errorMsg, int responseCode, int requestCode);
}

abstract class DialogValue {
  void onValue(String v);
}
