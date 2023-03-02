import 'dart:io';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mypaws/core/config/enum/pet_type.dart';
import 'package:mypaws/core/config/routes.dart';
import 'package:mypaws/core/config/shared_pref.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener_event.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FindingPetController extends GetxController with LifecycleListenerEvent {
  List<Marker> myMarker = <Marker>[].obs;

  bool isOpenAppSetting = false;

  late LifecycleListener _lifecycleListener;

  var selectedDate = DateTime.now().obs;

  final _defaultLocation = const LatLng(37.42796133580664, -122.085749655962);

  late final CameraPosition _fabButtonCameraLocation;

  CameraPosition? cameraPosition;

  String location = "ปักหมุด";

  // final homeScaffoldKey = GlobalKey<ScaffoldState>();

  final _fabLocation = const LatLng(37.43296265331129, -122.08832357078792);

  // late GoogleMapController googleMapController;

  Set<Marker> markersList = {};

  final _prefs = const FlutterSecureStorage();

  String? userId, userName, userLastname , userphone;

  @override
  void onInit() async {
    _defaultCameraLocation = CameraPosition(
      target: _defaultLocation,
      zoom: 14.4746,
    );

    _fabButtonCameraLocation = CameraPosition(
        bearing: 192.8334901395799,
        target: _fabLocation,
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    _moveCameraToCurrentLocation();

    _lifecycleListener = LifecycleListener(providerInstance: this);

    userId = await _prefs.read(key: SharedPreferenceKey.userId);
    userName = await _prefs.read(key: SharedPreferenceKey.userName);
    userLastname = await _prefs.read(key: SharedPreferenceKey.userLastname);
    userphone = await _prefs.read(key: SharedPreferenceKey.userphone);
    //  for (var value in PetType.values) {
    //   gender.add(value);
    // }

    super.onInit();
  }

  @override
  void onReady() {
    _lifecycleListener.dispose();
    super.onReady();
  }

  @override
  void onClose() {
    _lifecycleListener.dispose();
    super.onClose();
  }

  File? image;
  final picker = ImagePicker();

  DateTime? pickedDate;

  chooseDate() async {
    pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),

      //initialEntryMode: DatePickerEntryMode.input,
      // initialDatePickerMode: DatePickerMode.year,

      // helpText: 'Select DOB',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      // fieldLabelText: 'DOB',
      // selectableDayPredicate: disableDate);
      fieldHintText: 'Month/Date/Year',
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate!;
      update();
    }
  }

  var lat;
  var lng;
  LatLng? pinTap;

  void handleMapTap(LatLng tappedPoint) {
    print(tappedPoint);
    myMarker = [];
    myMarker.add(
      Marker(
        consumeTapEvents: true,
        markerId: MarkerId(
          tappedPoint.toString(),
        ),
        draggable: true,
        onDragEnd: (dragEndPosition) {
          print(dragEndPosition);
        },
        position: tappedPoint,
      ),
    );
    pinTap = tappedPoint;
    // lat = tappedPoint.latitude.obs;
    // lng = tappedPoint.longitude.obs;
    update();
  }

  void savePinMap() {
    print("***SavePinMap");
    lat = pinTap?.latitude;
    lng = pinTap?.longitude;

    update();
  }

  Completer<GoogleMapController> controller = Completer();

  late final CameraPosition _defaultCameraLocation;

  final Set<Marker> markers = {};

  LatLng? _currentDeviceLocation;

  CameraPosition get currentDeviceLocation {
    return _currentDeviceLocation != null
        ? CameraPosition(
            target: LatLng(_currentDeviceLocation!.latitude,
                _currentDeviceLocation!.longitude),
            zoom: 14.4746)
        : _defaultCameraLocation;
  }

  void _moveCameraToCurrentLocation() async {
    try {
      final position = await _determinePosition();
      _currentDeviceLocation = LatLng(position.latitude, position.longitude);

      final GoogleMapController controller = await this.controller.future;

      controller
          .animateCamera(CameraUpdate.newCameraPosition(currentDeviceLocation));

      update();
    } catch (e) {
      _openAppSetting(e.toString());
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _openAppSetting(String message) {
    Get.dialog(AlertDialog(
      title: const Text("ไม่สามารถเข้าถึงตำแหน่งได้"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(Get.overlayContext!).pop();
            Get.back();
          },
          child: const Text("ยกเลิก"),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(Get.overlayContext!).pop();
            if (Platform.isAndroid) {
              isOpenAppSetting = await Geolocator.openAppSettings();
              return;
            }
          },
          child: const Text("ตั้งค่า"),
        ),
      ],
    ));
  }

  @override
  void onResume() {
    super.onResume();

    if (Get.currentRoute == Routes.findPetPage && isOpenAppSetting) {
      isOpenAppSetting = false;
      _moveCameraToCurrentLocation();
    }
  }

  String? selectedGender;

  List<PetType> gender = [];

  List<String> pets = ['สุนัข', 'แมว'];

  PetType selectType = PetType.cat;

  void setSelectedType(PetType type) {
    selectType = type;
    update();
  }

  String? selectedType;

  void onClickRadioButton(value) {
    print(value);
    selectedType = value;
    update();
  }
}
