import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener_event.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class ScanBreedController extends GetxController with LifecycleListenerEvent {
  late LifecycleListener _lifecycleListener;

  // File? image;

  // bool loading = true;

  // final picker = ImagePicker();

  // Future getImageFromGallery() async {
  //   try {
  //     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //     if (pickedFile != null) {
  //       image = File(pickedFile.path);
  //       update();
  //     }
  //   } on PlatformException catch (e) {
  //     if (kDebugMode) {
  //       print('Failed to pick image: $e');
  //     }
  //   }
  //   // update();
  //   classifyImage(image!);
  // }

  // List? outputbreed ;

  // classifyImage(File image) async {
  //   //this function runs the model on the image

  //   var output = await Tflite.runModelOnImage(
  //     path: image.path,
  //     numResults:
  //         5, //the amout of categories our neural network can predict (here no. of animals)
  //     threshold: 0.5,
  //     imageMean: 127.5,
  //     imageStd: 127.5,
  //   );
  //   update();
  //   // setState(() {
  //   outputbreed = output!;
  //   loading = false;

  //   // });
  // }

  // Future getImageFromCamera() async {
  //   try {
  //     final pickedFile = await picker.pickImage(source: ImageSource.camera);

  //     if (pickedFile != null) {
  //       image = File(pickedFile.path);
  //       update();
  //     }
  //   } on PlatformException catch (e) {
  //     if (kDebugMode) {
  //       print('Failed to pick image: $e');
  //     }
  //   }

  //   classifyImage(image!);
  // }

  // Future loadModel() async {
  //   //this function loads our model
  //   await Tflite.loadModel(
  //     model: 'assets/model.tflite',
  //     labels: 'assets/labels.txt',
  //   );
  //   // outputbreed = ;
  // }

  @override
  void onReady() {
    _lifecycleListener.dispose();
    super.onReady();
  }

  // @override
  void onClose() {
    _lifecycleListener.dispose();
    // Tflite.close();
    super.onClose();
  }

  @override
  void onResume() {
    // loadModel();
    super.onResume();
  }

  @override
  void onInit() {
    _lifecycleListener = LifecycleListener(providerInstance: this);
    super.onInit();
  }
}
