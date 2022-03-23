import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report/constants/api_const.dart';
import 'package:report/util/dio_helper.dart';

class ReportServices {
  static Future addReport(String comment, String contact, LatLng location, List<XFile> images, String audioPath) async {
    FormData formData = FormData.fromMap({
      "comment": comment,
      "contact": contact,
      "location": {
        "latitude": location.latitude,
        "longitude": location.longitude,
      },
    });
    for (XFile image in images) {
      formData.files.add(MapEntry("image", await MultipartFile.fromFile(image.path)));
    }
    formData.files.add(MapEntry("audio", await MultipartFile.fromFile(audioPath)));
    Response response = await DioHelper.post(
      formData,
      ApiConst.addReport,
      headers: {"need_auth": true},
    );
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode != 403 && response.statusCode != 422) {
      String message = response.data["message"];
      Fluttertoast.showToast(msg: message);
      return null;
    } else {
      return null;
    }
  }
}
