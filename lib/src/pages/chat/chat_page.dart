import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/widget/custom_appbar.dart';
import 'package:mypaws/core/widget/title.dart';
import 'package:mypaws/src/pages/chat/chat_page_controller.dart';

class ChatPage extends GetView<ChatPageController> {
  ChatPage({super.key});
  final _chatPageController = Get.put(ChatPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(headLine1: 'MyPaws', headLine2: 'Chat')
        ],
      )),
    );
  }
}
