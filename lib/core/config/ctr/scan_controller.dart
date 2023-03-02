import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypaws/core/config/shared_pref.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener_event.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class ScanController extends  GetxController with LifecycleListenerEvent{
  File? image;

  bool loading = true;

  final picker = ImagePicker();

  late LifecycleListener _lifecycleListener;

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
    classifyImage(image!);
  }

  List? outputbreed ;

  classifyImage(File image) async {
    //this function runs the model on the image

    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults:
          5, //the amout of categories our neural network can predict (here no. of animals)
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    update();
    // setState(() {
    outputbreed = output!;
    loading = false;
    print("Breed : $outputbreed");
    // });
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

    classifyImage(image!);
  }

  void loadModel() async {
    //this function loads our model
    await Tflite.loadModel(
      model: 'assets/model.tflite',
      labels: 'assets/labels.txt',
    );
    // outputbreed = ;
  }

  @override
  void onInit() {
    _lifecycleListener = LifecycleListener(providerInstance: this);
    loadModel();
    super.onInit();
  }

  @override
  void onClose() {
    _lifecycleListener.dispose();
    Tflite.close();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

}