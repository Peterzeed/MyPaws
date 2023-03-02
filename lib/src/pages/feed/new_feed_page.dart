import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/widget/custom_appbar.dart';
import 'package:mypaws/core/widget/title.dart';
import 'package:mypaws/src/pages/feed/foundpet/found_pet_feed.dart';
import 'package:mypaws/src/pages/feed/lostpet/lost_pet_feed.dart';
import 'package:mypaws/src/pages/feed/new_feed_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class NewFeedPage extends GetView<NewFeedPageController> {
  NewFeedPage({super.key});
  final NewFeedPageController _newFeedPageController =
      Get.put(NewFeedPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: const Header(headLine1: 'MyPaws', headLine2: 'Feed'),
        bottom: PreferredSize(
          preferredSize: new Size(2, 2),
          child: TabBar(
            labelColor: Colors.black,
            controller: _newFeedPageController.controller,
            tabs: _newFeedPageController.myTabs,
          ),
        ),
      ),
      body: _myTab(),
    );
  }

  TabBarView _myTab() {
    return TabBarView(
      controller: _newFeedPageController.controller,
      // children: _newFeedPageController.myTabs.map((Tab tab) {
      //   final String label = tab.text!;
      //   return Center(
      //     child: Text(
      //       'This is the $label tab',
      //       style: const TextStyle(fontSize: 36,color: Colors.white),
      //     ),
      //   );
      // }).toList(),
      children: [
        LostPetFeed(),
        FoundPetFeed(),
      ],
    );
  }
}
