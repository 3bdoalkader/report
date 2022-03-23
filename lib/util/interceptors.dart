import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:report/util/navigation_helper.dart';

class CustomInterceptors extends Interceptor {
  Dio previous;

  Dio refreshDio = Dio();

  CustomInterceptors(this.previous);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    bool? needAuth = await options.headers["need_auth"];
    if (needAuth ?? false) {
      /// ToDo add token
    }

    options.headers["Accept"] = "application/vnd.api.v1+json";

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.error is SocketException) {
      /// ToDo go to no internet screen

      navigationHelper.enable = false;
    } else if (err.response!.statusCode == 401) {
      /// ToDo your session has been expired
      super.onError(err, handler);
    } else if (err.response!.statusCode == 403) {
      String message = err.response!.data["message"];
      Fluttertoast.showToast(msg: message);
      super.onError(err, handler);
    } else if (err.response!.statusCode == 422) {
      Fluttertoast.showToast(msg: err.response!.data["data"]);
      super.onError(err, handler);
    } else if (err.response!.statusCode! >= 500) {
      Fluttertoast.showToast(msg: "Server error: Please wait and try again.");
      super.onError(err, handler);
    }
  }
}

class RefreshDioTokenError extends DioError {
  String cause;

  RefreshDioTokenError(this.cause, RequestOptions requestOptions) : super(requestOptions: requestOptions);

  @override
  String get message => cause;
}
