import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:report/util/navigation_helper.dart';

class MapController extends GetxController {
  MapController({this.location});

  final Completer<GoogleMapController> mapController = Completer();
  Set<Marker> markers = {};

  LatLng initPosition = const LatLng(0, 0);
  LatLng? currentLatLng;
  LatLng? location;

  LocationPermission permission = LocationPermission.denied;
  bool mapHyper = false;

  @override
  void onInit() async {
    super.onInit();

    await getCurrentLocation();
    if (location != null) {
      addLocation(location!);
    }
    update();
  }

  void updateHyper() {
    mapHyper = !mapHyper;
    update();
  }

  // get current location
  Future<void> getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      currentLatLng = LatLng(position.latitude, position.longitude);
      update();
    }
  }

  //call this onPress floating action button
  void toCurrentLocation() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: currentLatLng!,
          zoom: 12,
        ),
      ),
    );
  }

  bool checkReady() {
    if (currentLatLng == null) {
      return true;
    } else {
      return false;
    }
  }

  submit() {
    navigationHelper.goBack(result: location);
  }

  addLocation(LatLng newLocation) {
    markers = {};
    location = newLocation;
    markers.add(
      Marker(
        markerId: const MarkerId("location"),
        position: LatLng(newLocation.latitude, newLocation.longitude),
      ),
    );
    update();
  }
}
