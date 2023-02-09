import 'package:get/get.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener_event.dart';

class CreateAccountController extends GetxController with LifecycleListenerEvent {
  
  late LifecycleListener _lifecycleListener;

  @override


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

}