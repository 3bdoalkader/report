import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key? key, this.size = 27, this.color = Colors.white}) : super(key: key);
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      color: color,
      size: size,
    );
  }
}
