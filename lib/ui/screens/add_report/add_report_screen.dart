import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report/constants/app_color.dart';
import 'package:report/constants/app_style.dart';
import 'package:report/ui/screens/add_report/controller/add_report_controller.dart';
import 'package:report/ui/screens/add_report/widgets/attachment_image.dart';
import 'package:report/ui/widgets/back_arrow.dart';
import 'package:report/ui/widgets/custom_field.dart';
import 'package:report/ui/widgets/primary_button.dart';
import 'package:report/ui/widgets/text_area_widget.dart';
import 'package:report/util/app_validators.dart';
import 'package:report/util/screen_helper.dart';

class AddReportScreen extends StatefulWidget {
  const AddReportScreen({Key? key}) : super(key: key);
  static const String route = "/AddReportScreen";

  @override
  State<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ScreenHelper(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightBlue,
        title: const Text("Create Report"),
        leading: const Padding(
          padding: EdgeInsets.all(8),
          child: BackArrow(),
        ),
      ),
      body: GetBuilder<AddReportController>(
        init: AddReportController(),
        builder: (controller) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextAreaWidget(
                        onChanged: controller.updateReportComment,
                        validator: requiredValidator,
                        title: "Report Comments",
                        initialValue: controller.reportComment,
                        hintText: "Write Comments .....",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomField(
                        onChanged: controller.updateEmail,
                        validator: emailValidator,
                        title: "Contact",
                        hintText: "Email Address",
                        initValue: controller.reportContent,
                      ),
                      if (controller.audioPath != '')
                        Row(
                            crossAxisAlignment:CrossAxisAlignment.center,children: [
                          GestureDetector(
                            onTap: controller.mPlayer!.isPlaying ? controller.stopPlayer : controller.play,
                            child: Icon(
                              controller.mPlayer!.isPlaying ? Icons.stop : Icons.play_arrow,
                              color: AppColors.darkBlue,
                              size: 40,
                            ),
                          ),
                          Padding(padding:const EdgeInsets.only(top: 8),child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Duration ${controller.recorderTxt} min"),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: controller.mPlayer!.isPlaying ? controller.stopPlayer : controller.play,
                                    child: Text(
                                      controller.mPlayer!.isPlaying? "Stop record":"Play record",
                                      style: AppStyle.darkBlueStyle.copyWith(fontSize: 15),
                                    ),
                                  ),
                                  const  SizedBox(width: 8,),
                                  GestureDetector(
                                    onTap: controller.removeAudio,
                                    child: Text(
                                      "remove record",
                                      style: AppStyle.darkBlueStyle.copyWith(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),),
                        ]),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          for (XFile element in controller.imageList)
                            AttachmentImage(
                              file: element,
                              delete: () {
                                controller.removeImage(element);
                              },
                            )
                        ],
                      ),
                      if (controller.imageList.isEmpty)
                        const SizedBox(
                          height: 150,
                        ),
                      PrimaryButton(
                        onTap: controller.submit,
                        title: "Submit",
                      )
                    ],
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: ScreenHelper.width,
                  height: 50,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: controller.selectLocation,
                        icon: const Icon(Icons.location_pin, color: Colors.white, size: 20),
                      ),
                      GestureDetector(
                        onTap: controller.mRecorder!.isRecording ? controller.stopRecorder : controller.record,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.lightGrey,
                            border: Border.all(color: Colors.black),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Icon(controller.mRecorder!.isRecording ? Icons.stop : Icons.mic, color: Colors.black, size: 30),
                        ),
                      ),
                      IconButton(
                        onPressed: controller.selectImages,
                        icon: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 20),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
