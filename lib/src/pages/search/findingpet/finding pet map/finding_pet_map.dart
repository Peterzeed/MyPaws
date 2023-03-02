import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mypaws/core/config/routes.dart';
import 'package:mypaws/core/widget/custom_confirm_dialog.dart';
import 'package:mypaws/src/pages/search/findingpet/finding_pet.dart';
import 'package:mypaws/src/pages/search/findingpet/finding_pet_controller.dart';
import 'package:get/get.dart';

class FindPetMap extends StatelessWidget {
  FindPetMap({super.key});

  final _findPetController = Get.put(FindingPetController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FindingPetController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // Get.delete<FindingPetController>(force: true);
              Get.back();
            },
          ),
          title: const Text(
            'Google Map',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            // IconButton(
            //   icon: const Icon(Icons.add_alert),
            //   color: Colors.black,
            //   tooltip: 'Show Snackbar',
            //   onPressed: () {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text('This is a snackbar')));
            //   },
            // ),
          ],
        ),
        body: Stack(
          children: [
            GoogleMap(
              zoomGesturesEnabled: true, //enable Zoom in, out on map
              initialCameraPosition: _findPetController.currentDeviceLocation,
              mapType: MapType.normal, //map type
              onMapCreated: (GoogleMapController controller) {
                _findPetController.controller.complete(controller);
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              compassEnabled: false,
              onCameraMove: (CameraPosition cameraPositiona) {
                _findPetController.cameraPosition =
                    cameraPositiona; //when map is dragging
              },
              // onCameraIdle: _findPetController.pinMap,
              markers: Set<Marker>.of(_findPetController.myMarker),
              onTap: _findPetController.handleMapTap,
              // onTap  _findPetController.handleMapTap,
            ),
            Positioned(
              //widget to display location name
              bottom: 100,

              child: Padding(
                padding: EdgeInsets.only(left: 100),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width - 200,
                    child: ListTile(
                      leading: const Icon(Icons.touch_app_outlined),
                      title: Text(
                        _findPetController.location,
                        style: TextStyle(fontSize: 18),
                      ),
                      dense: true,
                      onTap: () {
                        // if (_findPetController.lat == null ||
                        //     _findPetController.lng == null) {
                        //   showDialog(
                        //       context: context,
                        //       builder: (ctx) {
                        //         return CustomConfirmDialog(
                        //           title: "โปรดปักหมุดบนแผนที่",
                        //           description: "",
                        //           positiveText: "ยืนยัน",
                        //           negativeText: "ยกเลิก",
                        //           assetImage: "assets/logout.svg",
                        //           positiveHandler: () async {},
                        //           negativeHandler: () async {},
                        //         );
                        //       });
                        // } else {
                        // Navigator.pushNamed(context, '/findpet', arguments: {_findPetController.lat,_findPetController.lng});
                        // Get.toNamed(
                        //   Routes.findPetPage,
                        //   arguments: [
                        //     {FindingPet.pinLat : _findPetController.lat},
                        //     {FindingPet.pinLng :_findPetController.lng},
                        //   ],
                        // );
                        _findPetController.savePinMap();
                        if (_findPetController.lat != null &&
                            _findPetController.lng != null) {
                          // _findPetController.savePinMap();
                          print("Heyy ${_findPetController.lat}");
                          Navigator.pop(context);
                        } else {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return CustomConfirmDialog(
                                  title: "โปรดปักหมุดบนแผนที่",
                                  description: "",
                                  positiveText: "ยืนยัน",
                                  negativeText: "ยกเลิก",
                                  assetImage: "assets/logout.svg",
                                  positiveHandler: () async {},
                                  negativeHandler: () async {},
                                );
                              });
                        }

                        // }
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );

      // Center( //picker image on google map
      //     child: Image.asset("assets/pin2.png", width: 80,),
      //  ),

      //  Positioned(  //widget to display location name
      //    bottom:100,
      //    child: Padding(
      //        padding: EdgeInsets.all(15),
      //         child: Card(
      //            child: Container(
      //              padding: EdgeInsets.all(0),
      //              width: MediaQuery.of(context).size.width - 40,
      //              child: ListTile(
      //                 leading: Image.asset("assets/pin2.png", width: 25,),
      //                 title:Text(_findPetController.location, style: TextStyle(fontSize: 18),),
      //                 dense: true,
      //              )
      //            ),
      //         ),
      //      )
      //    )
    });
  }
}
