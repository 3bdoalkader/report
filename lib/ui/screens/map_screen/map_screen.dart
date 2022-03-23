import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:report/constants/app_color.dart';
import 'package:report/ui/screens/map_screen/controller/map_controller.dart';
import 'package:report/ui/widgets/back_arrow.dart';
import 'package:report/ui/widgets/loader.dart';
import 'package:report/ui/widgets/primary_button.dart';
import 'package:report/util/navigation_helper.dart';
import 'package:report/util/screen_helper.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static String route = "/MapScreen";

  @override
  _MapScreenState createState() => _MapScreenState();
}

late PersistentBottomSheetController controller;

class _MapScreenState extends State<MapScreen> {
  List args = [];

  LatLng? location;

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments! as List;
    location = args.first;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ScreenHelper(context);
    return GetBuilder<MapController>(
      init: MapController(location: location),
      builder: (controller) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.lightBlue,
            title: const Text("Select location"),
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: BackArrow(back: () {
                navigationHelper.goBack(result: location);
              }),
            ),
            actions: [
              IconButton(
                onPressed: controller.submit,
                icon: const Icon(
                  Icons.check,
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              controller.checkReady()
                  ? const Center(
                      child: AppLoader(color: AppColors.darkBlue, size: 80),
                    )
                  : Stack(
                      children: [
                        GoogleMap(
                          mapType: controller.mapHyper ? MapType.hybrid : MapType.normal,
                          onMapCreated: (GoogleMapController googleMapController) {
                            controller.mapController.complete(googleMapController);
                          },
                          onTap: controller.addLocation,
                          myLocationButtonEnabled: false,
                          markers: controller.markers,
                          initialCameraPosition: CameraPosition(
                            target: controller.location ?? controller.currentLatLng ?? const LatLng(0, 0),
                            zoom: 12.0,
                          ),
                          zoomControlsEnabled: false,
                          zoomGesturesEnabled: true,
                        ),
                      ],
                    ),
              if (!controller.checkReady())
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: ScreenHelper.fromHeight(3), bottom: 5),
                          child: GestureDetector(
                            onTap: controller.updateHyper,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.lightBlue,
                              ),
                              child: const Center(
                                child: Icon(Icons.map_outlined, color: Colors.white, size: 25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (controller.permission == LocationPermission.whileInUse || controller.permission == LocationPermission.whileInUse)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: ScreenHelper.fromHeight(3), bottom: 8),
                            child: GestureDetector(
                              onTap: controller.toCurrentLocation,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.lightBlue,
                                ),
                                child: const Center(
                                  child: Icon(Icons.location_searching_outlined, color: Colors.white, size: 25),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
