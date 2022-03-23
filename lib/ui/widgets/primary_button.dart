import 'package:fluttertoast/fluttertoast.dart';
import 'package:report/constants/app_color.dart';
import 'package:report/constants/app_style.dart';
import 'package:report/ui/widgets/loader.dart';
import 'package:report/util/screen_helper.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.width = 90,
    this.color = AppColors.darkBlue,
    this.isLoading = false,
  }) : super(key: key);

  final Function() onTap;
  final String title;
  final double width;
  final bool isLoading;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: false,
      child: GestureDetector(
        onTap: isLoading
            ? () {
                Fluttertoast.showToast(msg: "Please wait !");
              }
            : onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          height: ScreenHelper.fromHeight(5.5),
          width: ScreenHelper.fromWidth(width),
          child: Center(
            child: isLoading
                ? const Center(
              child: AppLoader(),
            )
                : Text(
                    title,
                    style: AppStyle.whiteStyle.copyWith(fontSize: 14),
                  ),
          ),
        ),
      ),
    );
  }
}
