import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:report/ui/screens/add_report/add_report_screen.dart';
import 'package:report/util/app_routes.dart';
import 'package:report/util/dio_helper.dart';
import 'package:report/util/navigation_helper.dart';

void main() {
  Get.put(NavigationHelper());
  DioHelper();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter test',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationHelper.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AddReportScreen(),
      routes: appRoutes,
    );
  }
}
