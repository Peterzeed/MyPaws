import 'dart:async';
import 'package:get/get.dart';
import 'package:mypaws/src/model/lost_pet_model.dart';
import 'package:mypaws/src/model/match_model.dart';
import 'package:mypaws/src/pages/feed/lostpet/feeddetail/lost_feed_detail.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class FoundPageDetailController extends GetxController {

  Completer<GoogleMapController> controller = Completer();

  List<Marker> myMarker = <Marker>[].obs;
  
  late PetMatchModel postDetail;

  @override
  void onInit() {
    _receiveArguments();
    super.onInit();
  }

  void _receiveArguments() {
    final args = Get.arguments;
    postDetail = args[0][LostFeedDetail.itemArg];
    
  }
}