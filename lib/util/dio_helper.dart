import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:report/constants/api_const.dart';
import 'package:report/util/interceptors.dart';

class DioHelper {
  static late Dio dioInstance;

  DioHelper() {
    dioInstance = getDioInstanceWithOptions();
  }

  Dio getDioInstanceWithOptions() {
    final String _baseUrl = ApiConst.baseUrl;
    var dio = Dio();
    dio.options.baseUrl = _baseUrl;
    dio.interceptors.add(CustomInterceptors(dio));
    return dio;
  }

  static Future post(FormData formData, String url, {var headers}) async {
    try {
      final response = await dioInstance.post(
        url,
        data: formData,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json", "Accept": "application/json", "need_auth": false},
          followRedirects: false,
          validateStatus: (status) {
            return status! <= 500;
          },
        ),
      );

      return response;
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "Check your internet");
    }
  }

  static Future put(Map<String, dynamic> formData, String url, Map<String, dynamic>? headers) async {
    formData["_method"] = "PUT";
    try {
      final response = await dioInstance.post(
        url,
        data: FormData.fromMap(formData),
        options: Options(
          headers: headers ?? {"Content-Type": "application/json", "Accept": "application/json", "need_auth": true},
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      return response;
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "Check your internet");
    }
  }

  static Future get(String url, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    try {
      Uri uri = Uri.parse(url);
      Uri newUri = uri.replace(queryParameters: queryParameters);
      final response = await dioInstance.getUri(
        newUri,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json", "Accept": "application/json", "need_auth": false},
        ),
      );
      return response;
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "Check your internet");
    } catch (e) {
      rethrow;
    }
  }

  static Future delete(String url, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    try {
      final response = await dioInstance.delete(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json", "Accept": "application/json", "need_auth": false},
        ),
      );
      return response;
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "Check your internet");
    } catch (e) {
      rethrow;
    }
  }
}
