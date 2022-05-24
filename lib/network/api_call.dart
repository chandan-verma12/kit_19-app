import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../utils/strings.dart';
import 'api_client.dart';
import 'api_response.dart';
import 'method.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiCall {
  static Future<void> makeApiCall(int requestCode, Object? params, Method m,
      String apiName, ApiResponse apiResponse,
      {String? baseUrl, File? file}) async {
    var dio = ApiClient.getInstance(baseUrl: baseUrl);
    //dio.options.headers['content-Type'] = 'application/json';
    //final uData = await AppPref.getUserData();
    //dio.options.headers["authorization"] = UserDetails.token;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      switch (m) {
        case Method.GET:
          {
            debugPrint("GET Api: $apiName Params: ${jsonEncode(params)}");
            dio
                .get(apiName, queryParameters: params as Map<String, dynamic>)
                .then((value) {
              apiResponse.onResponse(
                  json.encode(value.data), value.statusCode!, requestCode);
            }).catchError((err) {
              try {
                if (err is DioError) {
                  apiResponse.onError(json.encode(err.response!.data),
                      err.response!.statusCode!, requestCode);
                } else {
                  apiResponse.onError(err.toString(), 404, requestCode);
                }
              } catch (e) {
                apiResponse.onError(err.toString(), 405, requestCode);
              }
            });
          }
          break;
        case Method.POST:
          {
            debugPrint("POST Api: $apiName Params: ${jsonEncode(params)}");
            dio.post(apiName, data: jsonEncode(params)).then((value) {
              var jsonData = json.decode(json.encode(value.data));
              if (jsonData['Status'] == -1) {
                apiResponse.onTokenExpired(
                    jsonData['Message'], value.statusCode!, requestCode);
              } else {
                apiResponse.onResponse(
                    json.encode(value.data), value.statusCode!, requestCode);
              }
            }).catchError((err) {
              try {
                if (err is DioError) {
                  apiResponse.onError(json.encode(err.response!.data),
                      err.response!.statusCode!, requestCode);
                } else {
                  apiResponse.onError(err.toString(), 404, requestCode);
                }
              } catch (e) {
                apiResponse.onError(err.toString(), 405, requestCode);
              }
            });
          }
          break;

        case Method.PATCH:
          {
            debugPrint("PATCH Api: $apiName Params: ${jsonEncode(params)}");
            dio.patch(apiName, data: jsonEncode(params)).then((value) {
              apiResponse.onResponse(
                  json.encode(value.data), value.statusCode!, requestCode);
            }).catchError((err) {
              try {
                if (err is DioError) {
                  apiResponse.onError(json.encode(err.response!.data),
                      err.response!.statusCode!, requestCode);
                } else {
                  apiResponse.onError(err.toString(), 404, requestCode);
                }
              } catch (e) {
                apiResponse.onError(err.toString(), 405, requestCode);
              }
            });
          }
          break;

        case Method.PUT:
          {
            debugPrint("PUT Api: $apiName Params: ${jsonEncode(params)}");
            dio.put(apiName, data: jsonEncode(params)).then((value) {
              apiResponse.onResponse(
                  json.encode(value.data), value.statusCode!, requestCode);
            }).catchError((err) {
              try {
                if (err is DioError) {
                  apiResponse.onError(json.encode(err.response!.data),
                      err.response!.statusCode!, requestCode);
                } else {
                  apiResponse.onError(err.toString(), 404, requestCode);
                }
              } catch (e) {
                apiResponse.onError(err.toString(), 405, requestCode);
              }
            });
          }
          break;
        case Method.UPLOAD:
          dio.options.headers["Content-Type"] = "multipart/form-data";
          FormData formData = FormData.fromMap({
            'details': jsonEncode(params),
            'file': await MultipartFile.fromFile(file!.path,
                filename: file.path.split('/').last)
          });
          debugPrint("UPLOAD Api: $apiName Params: ${jsonEncode(params)}");
          dio.post(apiName, data: formData).then((value) {
            var jsonData = json.decode(json.encode(value.data));
            if (jsonData['Status'] == -1) {
              apiResponse.onTokenExpired(
                  jsonData['Message'], value.statusCode!, requestCode);
            } else {
              apiResponse.onResponse(
                  json.encode(value.data), value.statusCode!, requestCode);
            }
          }).catchError((err) {
            try {
              if (err is DioError) {
                apiResponse.onError(json.encode(err.response!.data),
                    err.response!.statusCode!, requestCode);
              } else {
                apiResponse.onError(err.toString(), 404, requestCode);
              }
            } catch (e) {
              apiResponse.onError(err.toString(), 405, requestCode);
            }
          });
          break;
      }
    } else {
      apiResponse.onError(Strings.noInternet, 500, requestCode);
    }
  }

  static Future<void> getCountryList(
      ApiResponse apiResponse, int requestCode) async {
    final String response =
        await rootBundle.loadString('assets/country_json.json');
    final data = await json.decode(response);
    apiResponse.onResponse(json.encode(data), 200, requestCode);
  }
}



/* import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
Add the specific contentType.

  String mimeType = mime(fileName);
  String mimee = mimeType.split('/')[0];
  String type = mimeType.split('/')[1];

  Dio dio = new Dio();
  dio.options.headers["Content-Type"] = "multipart/form-data";
  FormData formData = new FormData.fromMap({
   'file':await MultipartFile.fromFile(filePath,
      filename: fileName, contentType: MediaType(mimee, type))
  });
  Response response = await dio
      .post('http://192.168.18.25:8080/test', data: formData)
      .catchError((e) => print(e.response.toString())); */
