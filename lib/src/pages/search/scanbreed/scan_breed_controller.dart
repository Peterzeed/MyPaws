import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/DI/auth_controller.dart';
import 'package:mypaws/core/DI/user_repository.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener_event.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class ScanBreedController extends GetxController with LifecycleListenerEvent {
  late LifecycleListener _lifecycleListener;

  @override
  void onReady() {
    _lifecycleListener.dispose();
    super.onReady();
  }

  // @override
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
}
