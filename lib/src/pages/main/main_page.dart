import 'package:flutter/material.dart';
import 'package:mypaws/core/widget/btnbar/btn_nav_bar.dart';
import 'package:mypaws/core/widget/title.dart';
import 'package:get/get.dart';
import 'package:mypaws/src/pages/chat/chat_page.dart';
import 'package:mypaws/src/pages/feed/new_feed_page.dart';
import 'package:mypaws/src/pages/main/main_page_controller.dart';
import 'package:mypaws/src/pages/search/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatelessWidget {
  final String title;
  String email;
  
  MainPage({super.key, required this.title, required this.email});

  final _mainpageController = Get.put(MainPageControler());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPageControler>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: IndexedStack(
          index: _mainpageController.tabIndex,
          children: [NewFeedPage(), SearchPage(email: email), ChatPage()],
        )),
        bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _bottomNavigationBarItem(icon: Icons.people_alt, label: 'Feed'),
              _bottomNavigationBarItem(icon: Icons.pets, label: 'Search'),
              _bottomNavigationBarItem(icon: Icons.chat_bubble, label: 'Chat'),
            ]),
        // body: Container(
        //   child: Text('Hey'),
        
      );
    });
  }

  _bottomNavigationBarItem({IconData? icon, String? label}) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}
