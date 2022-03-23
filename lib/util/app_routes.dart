import 'package:flutter/material.dart';
import 'package:report/ui/screens/add_report/add_report_screen.dart';
import 'package:report/ui/screens/map_screen/map_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  AddReportScreen.route: (BuildContext context) => const AddReportScreen(),
  MapScreen.route: (BuildContext context) => const MapScreen(),
};
