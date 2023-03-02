import 'package:get/get.dart';
import 'package:mypaws/core/config/shared_pref.dart';
import 'package:mypaws/src/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainPageControler extends GetxController {
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

}
