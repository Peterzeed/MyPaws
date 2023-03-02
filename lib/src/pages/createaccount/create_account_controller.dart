import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener_event.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccountController extends GetxController
    with LifecycleListenerEvent {

  var isPasswordHide = true.obs;

  late LifecycleListener _lifecycleListener;

  final picker = ImagePicker();

  File? image;

  String? urlPic;

  @override
  void onClose() {
    _lifecycleListener.dispose();
    super.onClose();
  }

  @override
  void onResume() {
    super.onResume();
  }

  @override
  void onInit() {
    _lifecycleListener = LifecycleListener(providerInstance: this);

    super.onInit();
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

  Future<void> uploadPicture() async {
    Random random = Random();
    int i = random.nextInt(10000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference folderRef = firebaseStorage.ref().child('user_avatar/avatar$i.jpg');
    UploadTask uploadTask = folderRef.putFile(image!);

    urlPic = await (await uploadTask).ref.getDownloadURL();
    print("Url Picture : ${urlPic.toString()}");
  }
}
