import 'package:get/get.dart';
import 'package:mypaws/core/DI/auth_controller.dart';
import 'package:mypaws/core/DI/user_repository.dart';

class SearchPageController extends GetxController {
  final String title = 'Search Title';

  Rx<double> range = 0.0.obs; //again initialized it to a Rx<double>

  void setRange(double range) {
    this.range.value = range; //updating the value of Rx Variable.
  }
}
