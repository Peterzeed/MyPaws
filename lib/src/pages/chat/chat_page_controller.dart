import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/config/shared_pref.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener_event.dart';
import 'package:mypaws/src/model/match_profile_model.dart';
import 'package:mypaws/src/pages/chat/chatUI/chat_ui_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatPageController extends GetxController  with GetSingleTickerProviderStateMixin{

  final String title = 'Chat';

  late TabController controller;

  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: 'Lost Pet',
    ),
    const Tab(text: 'Found Pet'),
  ];

  @override
  void onInit() async {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onReady() {
    super.onReady();
  }

}
