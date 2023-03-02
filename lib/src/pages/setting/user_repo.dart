import 'package:get/get.dart';
import 'package:mypaws/core/DI/auth_controller.dart';
import 'package:mypaws/src/pages/setting/setting_page_controller.dart';

class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthController());
  final _userSettingController = Get.put(SettingPageController());

  getUserData(){
    final email = _authRepo.user.value?.email;
    if (email != null) {
     return _userSettingController.getUserData(email);
    }else{
      Get.snackbar("Error", "Login to continue");
    }
  }
}