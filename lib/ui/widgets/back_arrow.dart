import 'package:flutter/material.dart';
import 'package:report/util/navigation_helper.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    Key? key,
    this.back,
  }) : super(key: key);
  final Function()? back;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: back ?? navigationHelper.goBack,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.black54),
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }
}
