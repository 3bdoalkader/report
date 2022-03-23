import 'package:flutter/material.dart';
import 'package:get/get.dart';

NavigationHelper navigationHelper = NavigationHelper.instance;

class NavigationHelper extends GetxController {
  static NavigationHelper instance = Get.find();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool enable = true;

  Future pushNamed(String routeName, {List? arguments}) {
    if (enable) {
      return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments ?? []);
    }
    return Future.value();
  }

  Future popAndPushNamed(String routeName, {List? arguments}) {
    if (enable) {
      return navigatorKey.currentState!.popAndPushNamed(routeName, arguments: arguments ?? []);
    }
    return Future.value();
  }

  Future pushNamedAndRemoveUntil(String routeName, {List? arguments}) {
    if (enable) {
      return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments ?? []);
    }
    return Future.value();
  }

  Future pushReplacementNamed(String routeName, {Object? arguments}) {
    if (enable) {
      return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments ?? []);
    }
    return Future.value();
  }

  Future goBack({Object? result}) {
    if (enable) {
      if (canGoBake()) {
        navigatorKey.currentState!.pop(result);
      }

      /// ToDo return to home
      // else {
      //
      //   return pushReplacementNamed(HomeScreen.route);
      // }
    }
    return Future.value();
  }

  bool canGoBake() => navigatorKey.currentState!.canPop() && enable;

  BuildContext getCurrentContext() {
    return navigatorKey.currentContext!;
  }

  closeKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
