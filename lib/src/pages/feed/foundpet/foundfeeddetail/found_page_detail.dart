import 'package:flutter/material.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/theme/theme.dart';
import 'package:mypaws/core/widget/appbar_back.dart';
import 'package:get/get.dart';
import 'package:mypaws/src/pages/feed/foundpet/foundfeeddetail/found_page_detail_controller.dart';
import 'package:mypaws/src/pages/feed/lostpet/feeddetail/lost_feed_detial_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FoundFeedDetail extends StatelessWidget {
  FoundFeedDetail({Key? key}) : super(key: key);

  static const itemArg = "itemArg";

  final _petPost = Get.put(FoundPageDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: AppTheme.fullWidth(context),
          height: AppTheme.fullHeight(context),
          child: Column(
            children: <Widget>[
              AppBarBack(),
              // Center(
              //   child: Text(_petPost.postDetail.petname!),
              // )
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: 1000,
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Container(
                          height: 180,
                          width: AppTheme.fullWidth(Get.context!),
                          color: LightColor.orange,
                          child: Image.network(
                            _petPost.postDetail.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 160,
                          child: Container(
                            width: AppTheme.fullWidth(Get.context!),
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _petPost.postDetail.breed
                                                  .substring(0, 1)
                                                  .toUpperCase() +
                                              _petPost.postDetail.breed
                                                  .substring(1),
                                          style: GoogleFonts.mulish().copyWith(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w800,
                                              color: LightColor.black),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.favorite,
                                      size: 35,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 40,
                                  width: 150,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: LightColor.lightGrey.withAlpha(100),
                                    // color: Colors.black,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.person),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        _petPost.postDetail.foundername
                                                .substring(0, 1)
                                                .toUpperCase() +
                                            _petPost.postDetail.foundername
                                                .substring(1),
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 40,
                                  width: 400,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: LightColor.lightGrey.withAlpha(100),
                                    // color: Colors.black,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_month),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        _petPost.postDetail.date,
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "About",
                                  style: GoogleFonts.mulish().copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w100,
                                      color: LightColor.black),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 150,
                                  width: 400,
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                    color: LightColor.lightGrey.withAlpha(100),
                                    // color: Colors.black,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        _petPost.postDetail.description,
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Position",
                                  style: GoogleFonts.mulish().copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w100,
                                      color: LightColor.black),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 200,
                                  width: 400,
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                    color: LightColor.lightGrey.withAlpha(100),
                                    // color: Colors.black,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      GoogleMap(
                                        zoomGesturesEnabled:
                                            true, //enable Zoom in, out on map
                                        initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                                double.parse(
                                                    _petPost.postDetail.lat),
                                                double.parse(
                                                    _petPost.postDetail.lng)),
                                            zoom: 14.4746),
                                        mapType: MapType.normal, //map type
                                        onMapCreated:
                                            (GoogleMapController controller) {
                                          _petPost.controller
                                              .complete(controller);
                                        },
                                        myLocationEnabled: true,
                                        myLocationButtonEnabled: false,
                                        zoomControlsEnabled: true,
                                        compassEnabled: false,
                                        // onCameraIdle: _findPetController.pinMap,
                                        markers: {
                                          Marker(
                                            markerId: const MarkerId("marker1"),
                                            position: LatLng(
                                                double.parse(
                                                    _petPost.postDetail.lat),
                                                double.parse(
                                                    _petPost.postDetail.lng)),
                                            draggable: true,
                                            onDragEnd: (value) {
                                              // value is the new position
                                            },
                                          )
                                        },
                                        // onTap  _findPetController.handleMapTap,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
