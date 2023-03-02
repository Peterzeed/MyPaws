import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypaws/core/config/shared_pref.dart';
import 'package:mypaws/src/model/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SettingPageController extends GetxController {

  final picker = ImagePicker();

  File? image;

  final _prefs = const FlutterSecureStorage();

  final _db = FirebaseFirestore.instance;

  // late CollectionReference collectionReference;

  String? uid;

  @override
  void onInit() async {
    uid = await _prefs.read(key: SharedPreferenceKey.userId);
    super.onInit();
  }

  @override
  void onReady() {
    // collectionReference = firebaseFirestore.collection("Users");
    // userModel.bindStream(readUserData());

    super.onReady();
  }


  Future getImageFromCamera() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        image = File(pickedFile.path);
        update();
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  Future getImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        image = File(pickedFile.path);
        update();
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
    update();
  }

  // Stream<UserModel> readUserData() => collectionReference
  //     .where("userid", isEqualTo: uid)
  //     .snapshots()
  //     .map((query) =>
  //         query.docs.map((item) => UserModel.fromMapMap(item)).single);

  Future<UserModel> getUserData(String email)async{
    final snapshot = await _db.collection("Users").where("email" , isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }
}
