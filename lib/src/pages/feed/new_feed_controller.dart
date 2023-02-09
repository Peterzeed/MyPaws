import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewFeedPageController extends GetxController with GetSingleTickerProviderStateMixin {
  final String title = 'New Feed';
  
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Lost',),
    const Tab(text: 'Found'),
  ];


  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
  }

  // @override
  // void onClose() {
  //   controller.dispose();
  //   super.onClose();
  // }
}