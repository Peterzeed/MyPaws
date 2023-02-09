import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/config/routes.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/theme/theme.dart';
import 'package:mypaws/core/widget/custom_appbar.dart';
import 'package:mypaws/core/widget/title.dart';
import 'package:mypaws/src/pages/search/finding%20pet/finding_pet.dart';
import 'package:mypaws/src/pages/search/found%20pet/found_pet.dart';
import 'package:mypaws/src/pages/search/scan%20breed/scan_breed.dart';
import 'package:mypaws/src/pages/search/search_page_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchPage extends GetView<SearchPageController> {
  String email;
  String? imageBtn;

  String? btnName;
  Routes? searchRoute;
  String? route;

  

  SearchPage({Key? key ,required this.email}) : super(key: key);
  final _searchPageController = Get.put(SearchPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(headLine1: 'Welcome', headLine2: email.toString()),
          // _title(),
          const SizedBox(
            height: 50,
          ),
          _imageButton(context , imageBtn = 'assets/paw1.jpg', btnName = 'Finding Pet', route = 'findpet'),
          const SizedBox(
            height: 30,
          ),
          _imageButton(context , imageBtn = 'assets/paw2.jpg', btnName = 'Found Pet' , route = 'foundpet'),
          const SizedBox(
            height: 30,
          ),
          _imageButton(context , imageBtn = 'assets/paw4.jpg', btnName = 'Breed Scan' , route = 'scanbreed'),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
            child: _iconButton(),
          ),
        ],
      )),
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
    BuildContext context,
    String imgBtn,
    String btnName,
    String route
  ) {
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
              default: Get.to(() => SearchPage(email: '')); 
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

  Widget _iconButton() {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(5),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.white,
        child: InkWell(
          onTap: (() {}),
          child: Row(mainAxisSize: MainAxisSize.min, children: const [
            Icon(Icons.settings,size: 20,color: Colors.black,),
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
