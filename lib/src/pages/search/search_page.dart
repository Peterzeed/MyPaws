import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/config/routes.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/theme/theme.dart';
import 'package:mypaws/core/widget/custom_appbar.dart';
import 'package:mypaws/core/widget/title.dart';
import 'package:mypaws/core/widget/title_text.dart';
import 'package:mypaws/src/pages/search/findingpet/finding_pet.dart';
import 'package:mypaws/src/pages/search/foundpet/found_pet.dart';
import 'package:mypaws/src/pages/search/scanbreed/scan_breed.dart';
import 'package:mypaws/src/pages/search/search_page_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchPage extends GetView<SearchPageController> {
  String email;
  String? imageBtn;

  String? btnName;
  Routes? searchRoute;
  String? route;

  SearchPage({Key? key, required this.email}) : super(key: key);
  final _searchPageController = Get.put(SearchPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(headLine1: 'Mypaws', headLine2: "search"),
          // _title(),
          const SizedBox(
            height: 50,
          ),
          _imageButton(context, imageBtn = 'assets/paw1.jpg',
              btnName = 'Finding Pet', route = 'findpet'),
          const SizedBox(
            height: 30,
          ),
          _imageButton(context, imageBtn = 'assets/paw2.jpg',
              btnName = 'Found Pet', route = 'foundpet'),
          const SizedBox(
            height: 30,
          ),
          _imageButton(context, imageBtn = 'assets/paw4.jpg',
              btnName = 'Breed Scan', route = 'scanbreed'),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
            child: _iconButton(context),
          ),
        ],
      )),
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
              onTap: () {},
              leading: const Icon(Icons.pin_drop),
              title: const TitleText(
                text: "Search distance",
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Obx(
              () => Slider(
                value: _searchPageController.range.value,
                min: 0, //initialized it to a double
                max: 50, //initialized it to a double
                divisions: 10,
                label: _searchPageController.range.round().toString(),
                onChanged: (double value) {
                  _searchPageController.setRange(value);
                },
              ),
            ),
            // ListTile(
            //   onTap: () {},
            //   leading: const Icon(Icons.photo_camera_outlined),
            //   title: const TitleText(
            //     text: "Camera",
            //     fontWeight: FontWeight.w400,
            //     color: Colors.black,
            //   ),
            // ),
            SizedBox(
              height: 50,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                width: 150,
                height: 30,
                color: Colors.black,
                child: InkWell(
                  onTap: () {
                    
                  },
                  child: Center(
                    child: Text("Save",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        );
      },
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
              "Welcome",
              style: GoogleFonts.mulish().copyWith(
                  fontSize: 45,
                  fontWeight: FontWeight.w400,
                  color: LightColor.lightGrey),
            ),
            Text(
              "$email",
              style: GoogleFonts.mulish().copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: LightColor.lightGrey),
            ),
          ]),
    );
  }

  Widget _imageButton(
      BuildContext context, String imgBtn, String btnName, String route) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.white,
        child: InkWell(
          onTap: (() {
            // Get.toNamed(
            //   Routes.findPetPage
            // );
            // Navigator.of(context).pushNamed('/$route');
            // print(route);
            switch (route) {
              case 'findpet':
                Get.to(() => FindingPet(), arguments: route);
                break;
              case 'foundpet':
                Get.to(() => FoundPetPage());
                break;
              case 'scanbreed':
                Get.to(() => ScanBreedPage());
                break;
              default:
                Get.to(() => SearchPage(email: ''));
                break;
            }

            // Get.to(() => FindingPet(), arguments: route);
          }),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Ink.image(
              image: AssetImage(imgBtn),
              height: 65,
              width: 170,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              btnName,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(
              width: 10,
            ),
          ]),
        ),
      ),
    );
  }

  Widget _iconButton(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(5),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.white,
        child: InkWell(
          onTap: (() {
            _showOptions(context);
          }),
          child: Row(mainAxisSize: MainAxisSize.min, children: const [
            Icon(
              Icons.settings,
              size: 20,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Search Filter',
              style: TextStyle(fontSize: 10, color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
          ]),
        ),
      ),
    );
  }
}
