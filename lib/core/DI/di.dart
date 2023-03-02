import 'package:get/get.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mypaws/core/config/ctr/add_bookmark_controller.dart';
import 'package:mypaws/src/pages/setting/setting_page_controller.dart';

Future<void> initGetX() async {
  Get.put<AddBookmartController>(AddBookmartController());
}
