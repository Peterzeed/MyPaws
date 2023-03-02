import 'package:flutter/material.dart';
import 'package:mypaws/core/DI/auth_controller.dart';
import 'package:mypaws/core/config/ctr/scan_controller.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/theme/theme.dart';
import 'package:mypaws/core/widget/appbar_back.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/widget/title_text.dart';
import 'package:mypaws/src/pages/search/scanbreed/scan_breed_controller.dart';

class ScanBreedPage extends StatelessWidget {
  ScanBreedPage({super.key});

  final _scanBreedController = Get.put(ScanBreedController());
  final _scanController = Get.put(ScanController());
  // final _authController = Get.put(AuthController());

  String textBoxName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  const AppBarBack(),
                  _title(),
                ],
              ),
              _detailWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailWidget(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: DraggableScrollableSheet(
        maxChildSize: 1,
        initialChildSize: .75,
        minChildSize: .75,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            padding: AppTheme.padding.copyWith(bottom: 0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                controller: scrollController,
                // physics: const BouncingScrollPhysics(),
                child: _bottomSheetContent(context),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _bottomSheetContent(context) {
    return GetBuilder<ScanController>(
      builder: (ScanController controller) {
        return Column(
          children: [
            GestureDetector(
              child: _enterPic(controller),
              onTap: () {
                _showOptions(context);
              },
            ),
            _textField(controller)
          ],
        );
      },
    );
  }

  Widget _textField(ScanController controller) {
    return Container(
      height: 40,
      width: 350,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: LightColor.lightGrey.withAlpha(100),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          const Icon(Icons.adb_outlined, color: Colors.black54),
          const SizedBox(
            width: 12,
          ),
          _scanController.image != null
            ? _scanController.outputbreed != null
              ?
              Text(
                  'The animal is: ${(_scanController.outputbreed![0]['label']).split("-")[1]}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : const Text(
                  'The animal is: error',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : const Text(
                  'ค้นหาสายพันธุ์',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
          const Divider(
            height: 25,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Future _showOptions(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                _scanController.getImageFromGallery();
                Navigator.pop(Get.overlayContext!);
              },
              leading: const Icon(Icons.image_outlined),
              title: const TitleText(
                text: "Gallery",
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {
                _scanController.getImageFromCamera();
                Navigator.pop(Get.overlayContext!);
              },
              leading: const Icon(Icons.photo_camera_outlined),
              title: const TitleText(
                text: "Camera",
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  Container _enterPic(ScanController controller) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
      margin: const EdgeInsets.all(16),
      width: 250,
      height: 150,
      child: _scanController.image != null
          ? ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(13)),
              child: Image.file(
                _scanController.image!,
                fit: BoxFit.contain,
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TitleText(
                    color: Colors.white,
                    text: "รูปภาพสัตว์เลี้ยง",
                  ),
                  TitleText(
                    color: Colors.white,
                    text: "แตะเพื่อเลือกรูป",
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Icon(
                    Icons.touch_app_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
    );
  }

  Widget _title() {
    return Center(
      // padding: const EdgeInsets.all(16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Scan",
              style: GoogleFonts.mulish().copyWith(
                  fontSize: 45,
                  fontWeight: FontWeight.w400,
                  color: LightColor.lightGrey),
            ),
            Text(
              "Breed",
              style: GoogleFonts.mulish().copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: LightColor.lightGrey),
            ),
          ]),
    );
  }
}
