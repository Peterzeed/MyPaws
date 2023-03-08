import 'package:flutter/material.dart';
import 'package:mypaws/src/model/match_model.dart';
import 'package:mypaws/src/pages/chat/chatUI/chat_ui_page.dart';
import 'package:mypaws/src/pages/chat/chat_page.dart';
import 'package:mypaws/src/pages/createaccount/create_account_page.dart';
import 'package:mypaws/src/pages/feed/foundpet/foundfeeddetail/found_page_detail.dart';
import 'package:mypaws/src/pages/feed/lostpet/feeddetail/lost_feed_detail.dart';
import 'package:mypaws/src/pages/login/login_page.dart';
import 'package:mypaws/src/pages/main/main_page.dart';
import 'package:mypaws/src/pages/main/main_page_binder.dart';
import 'package:mypaws/src/pages/search/findingpet/finding%20pet%20map/finding_pet_map.dart';
import 'package:mypaws/src/pages/search/findingpet/finding_pet.dart';
import 'package:mypaws/src/pages/search/foundpet/found_pet.dart';
import 'package:mypaws/src/pages/search/petmatch/pet_match_page.dart';
import 'package:mypaws/src/pages/search/scanbreed/scan_breed.dart';
import 'package:mypaws/src/pages/search/search_page.dart';

import 'package:get/get.dart';
import 'package:mypaws/src/pages/setting/setting_page.dart';

class Routes {
  static const rootPage = "/";
  static const mainPage = "/main";
  static const findPetPage = "/findpet";
  static const findPetMap = "/findpetmap";
  static const foundPetPage = "/foundpet";
  static const ScanBreed = "/scanbreed";
  static const petMatchPage = "/petmatch";
  static const createAccountPage = "/createaccount";
  static const chatPage = "/chatpage";
  static const chatUiPage = "/chatui";
  static const settingPage = "/setting";
  static const lostfeedDetailPage = "/lostfeed";
  static const foundFeedDetailPage = "/foundfeeddetail";

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      rootPage: (_) => MainPage(
            title: '',
            email: '',
          ),
      // petMatchPage: (_) => PetMatchPage(petmatchmodel: ),
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
          title: '',
          email: '',
        ),
      ),
      GetPage(
        name: findPetPage,
        page: () => FindingPet(),
      ),
      GetPage(
        name: findPetMap,
        page: () => FindPetMap(),
      ),
      GetPage(
        name: foundPetPage,
        page: () => FoundPetPage(),
      ),
      GetPage(
        name: ScanBreed,
        page: () => ScanBreedPage(),
      ),
      GetPage(
        name: petMatchPage,
        page: () => PetMatchPage(),
      ),
      GetPage(
        name: createAccountPage,
        page: () => CreateAccountPage(),
      ),
      // GetPage(
      //   name: chatPage,
      //   page: () => ChatUiPage(arguments: arguemnt),
      // ),
      // GetPage(
      //   name: chatUiPage,
      //   page: () => ChatUiPage(id: '', name: '',),
      // ),
      GetPage(
        name: settingPage,
        page: () => SettingPage(),
      ),
      GetPage(
        name: lostfeedDetailPage,
        page: () => LostFeedDetail(),
      ),
      GetPage(
        name: foundFeedDetailPage,
        page: () => FoundFeedDetail(),
      ),
    ];
  }
}