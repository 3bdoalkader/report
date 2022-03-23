import 'package:flutter/material.dart';
import 'package:report/constants/app_style.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    Key? key,
    this.hintText,
    this.title,
    this.initValue,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);

  final String? title;
  final String? hintText;
  final String? initValue;
  final Function(String) onChanged;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
            left: 8,
          ),
          child: Text(
            title ?? "",
            style: AppStyle.darkBlueStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        TextFormField(
          initialValue: initValue ?? "",
          validator: validator,
          keyboardType: TextInputType.emailAddress,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            hintText: hintText ?? "",
            hintStyle: AppStyle.lightGray.copyWith(
              fontSize: 13,
            ),
            border: const OutlineInputBorder(borderSide: BorderSide()),
          ),
        )
      ],
    );
  }
}
