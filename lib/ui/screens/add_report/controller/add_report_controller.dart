import 'dart:async';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:report/ui/screens/map_screen/map_screen.dart';
import 'package:report/util/navigation_helper.dart';

class AddReportController extends GetxController {
  String reportComment = '';
  String reportContent = '';

  List<XFile> imageList = [];

  LatLng? location;

  FlutterSoundPlayer? mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mplaybackReady = false;
  int duration = 0;
  Timer? _timer;

  String audioPath = '';
  String recorderTxt = '00:00';

  @override
  onInit() {
    super.onInit();
    mPlayer!.openPlayer().then((value) {
      _mPlayerIsInited = true;
      update();
    });

    openTheRecorder().then((value) {
      update();
    });
  }

  updateReportComment(String newValue) {
    reportComment = newValue;
  }

  updateEmail(String newValue) {
    reportComment = newValue;
  }

  selectImages() async {
    // Pick multiple images
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      imageList.addAll(images);
      update();
    }
  }

  selectLocation() async {
    location = await navigationHelper.pushNamed(MapScreen.route, arguments: [location]);
  }

  removeImage(XFile image) {
    imageList.removeWhere((element) => element == image);
    update();
  }

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await mRecorder!.openRecorder();
  }

  void record() {
    audioPath = '';
    duration = 0;
    update();

    mRecorder!.startRecorder(toFile: 'path.mp4', codec: Codec.aacMP4, audioSource: AudioSource.microphone).then((value) {
      update();
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        duration++;
      });
    });
  }

  removeAudio() {
    audioPath = '';

    update();
  }

  void stopRecorder() async {
    await mRecorder!.stopRecorder().then((value) {
      _timer?.cancel();

      recorderTxt = "${duration ~/ 60}:${duration % 60}";
      _mplaybackReady = true;
      audioPath = value!;
      update();
    });
  }

  void play() {
    assert(_mPlayerIsInited && _mplaybackReady && mRecorder!.isStopped && mPlayer!.isStopped);
    mPlayer!
        .startPlayer(
            fromURI: 'path.mp4',
            whenFinished: () {
              update();
            })
        .then((value) {
      update();
    });
  }

  void stopPlayer() {
    mPlayer!.stopPlayer().then((value) {
      update();
    });
  }

  submit() {
    if ((audioPath != '' && imageList.isNotEmpty) && location != null) {
      /// toDo post to Api
      // ReportServices.addReport(reportComment, email, location!, imageList, audioPath);
      return;
    } else {
      if (audioPath == '') {
        Fluttertoast.showToast(msg: "You should record audio");
        return;
      }
      if (imageList.isEmpty) {
        Fluttertoast.showToast(msg: "You should select an image");
        return;
      }
      if (location == null) {
        Fluttertoast.showToast(msg: "You should select a location from map");
        return;
      }
    }
  }

  @override
  void dispose() {
    mPlayer!.closePlayer();
    mPlayer = null;

    mRecorder!.closeRecorder();
    mRecorder = null;
    super.dispose();
  }
}
