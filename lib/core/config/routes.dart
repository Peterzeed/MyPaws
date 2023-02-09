import 'package:flutter/material.dart';
import 'package:mypaws/src/pages/create%20account/create_account_page.dart';
import 'package:mypaws/src/pages/login/login_page.dart';
import 'package:mypaws/src/pages/main/main_page.dart';
import 'package:mypaws/src/pages/main/main_page_binder.dart';
import 'package:mypaws/src/pages/search/finding%20pet/finding%20pet%20map/finding_pet_map.dart';
import 'package:mypaws/src/pages/search/finding%20pet/finding_pet.dart';
import 'package:mypaws/src/pages/search/found%20pet/found_pet.dart';
import 'package:mypaws/src/pages/search/pet%20match/pet_match_page.dart';
import 'package:mypaws/src/pages/search/scan%20breed/scan_breed.dart';
import 'package:mypaws/src/pages/search/search_page.dart';


import 'package:get/get.dart';


class Routes {
  static const rootPage = "/";
  static const mainPage = "/main";
  static const findPetPage = "/findpet";
  static const findPetMap = "/findpetmap";
  static const foundPetPage = "/foundpet";
  static const ScanBreed = "/scanbreed";
  static const petMatchPage = "/petmatch";
  static const createAccountPage = "/createaccount"; 

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      rootPage: (_) => MainPage(
            title: '', email: '', 
          ),
    };
  }

  static List<GetPage> getPageRoute() {
    return [
      GetPage(
        name: rootPage,
        page: () => LoginPage(),
      ),
      GetPage(
        name: mainPage,
        page: () => MainPage(
          title: '', email: '', 
        ),
      ),
      GetPage(
        name: findPetPage,
        page: () => FindingPet(
        ),
      ),
      GetPage(
        name: findPetMap,
        page: () => FindPetMap(
        ),
      ),
      GetPage(
        name: foundPetPage,
        page: () => FoundPetPage(
        ),
      ),
      GetPage(
        name: ScanBreed,
        page: () => ScanBreedPage(
        ),
      ),
      GetPage(
        name: petMatchPage,
        page: () => PetMatchPage(
        ),
      ),
      GetPage(
        name: createAccountPage,
        page: () => CreateAccountPage(
        ),
      ),
    ];
  }
}
