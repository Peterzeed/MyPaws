import 'package:get/get.dart';

import 'package:mypaws/src/pages/chat/chat_page_controller.dart';
import 'package:mypaws/src/pages/feed/new_feed_controller.dart';
import 'package:mypaws/src/pages/search/search_page_controller.dart';


class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatPageController>(() => ChatPageController());
    Get.lazyPut<NewFeedPageController>(() => NewFeedPageController());
    Get.lazyPut<SearchPageController>(() => SearchPageController());
  }
}