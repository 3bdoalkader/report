import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report/constants/app_color.dart';

class AttachmentImage extends StatelessWidget {
  const AttachmentImage({Key? key, required this.file, required this.delete}) : super(key: key);

  final XFile file;
  final Function() delete;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(
              File(file.path),
              height: 100,
              width: 100,
            ),
            GestureDetector(
              onTap: delete,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.delete,
                    color: AppColors.red,
                  ),
                  Text(
                    "Delete",
                    style: TextStyle(color: AppColors.red, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
