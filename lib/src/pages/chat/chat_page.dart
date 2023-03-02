import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/config/ctr/add_bookmark_controller.dart';
import 'package:mypaws/core/config/routes.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/widget/custom_appbar.dart';
import 'package:mypaws/core/widget/extensions.dart';
import 'package:mypaws/core/widget/home_header.dart';
import 'package:mypaws/core/widget/title.dart';
import 'package:mypaws/core/widget/title_text.dart';
import 'package:mypaws/src/pages/chat/chatUI/chat_ui_page.dart';
import 'package:mypaws/src/pages/chat/chat_page_controller.dart';
import 'package:mypaws/src/pages/chat/chat_profile.dart';
import 'package:mypaws/src/pages/chat/chattype/foundpetchat/found_pet_chat.dart';
import 'package:mypaws/src/pages/chat/chattype/lostpetchat/lost_pet_chat.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  final _chatPageController = Get.put(ChatPageController());
  // final _bookmarkController = Get.put(AddBookmartController());

  String? texttext;

  String? maintext;

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
            controller: _chatPageController.controller,
            tabs: _chatPageController.myTabs,
          ),
        ),
      ),
      // body: SafeArea(
      //     child: Column(
      //   children: [
          // HomeHeader(headLine1: "MyPaws", headLine2: "Chat"),
          // Expanded(
          //     child: Obx(() => _chatPageController.matchitem.isNotEmpty
          //         ? _chatItem(context)
          //         : const Center(
          //             child: TitleText(
          //               text: 'Chat is empty',
          //               color: LightColor.grey,
          //             ),
          //           )))
        // ],
      // )),
      body: _myTab(),
    );
  }

  TabBarView _myTab() {
    return TabBarView(
      controller: _chatPageController.controller,
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
        LostPetChat(),
        FoundPetChat(),
      ],
    );
  }

  // ListView _chatItem(BuildContext context) {
  //   return ListView.builder(
  //     itemCount: _chatPageController.matchitem.length,
  //     itemBuilder: ((ctx, index) => Padding(
  //           padding: const EdgeInsets.all(15),
  //           child: ClipRRect(
  //             borderRadius: const BorderRadius.all(Radius.circular(10)),
  //             child: Container(
  //               width: 150,
  //               height: 70,
  //               color: Colors.white,
  //               child: Row(
  //                 children: [
  //                   Container(
  //                     height: 150,
  //                     width: 70,
  //                     child: ClipRRect(
  //                       borderRadius:
  //                           const BorderRadius.all(Radius.circular(10)),
  //                       child: Image.network(
  //                         _chatPageController.matchitem[index].foundpetpic,
  //                         height: 300,
  //                         fit: BoxFit.cover,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       subTiTle(
  //                         maintext =
  //                             "${_chatPageController.matchitem[index].petbreed}",
  //                         texttext = "สายพันธุ์ : ",
  //                       ),
  //                       subTiTle(
  //                         maintext =
  //                             "${_chatPageController.matchitem[index].matchdate}",
  //                         texttext = "จับคู่เมื่อ : ",
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     width: 40,
  //                   ),
  //                   ClipRRect(
  //                     borderRadius:
  //                         const BorderRadius.all(Radius.circular(100)),
  //                     child: Container(
  //                       height: 10,
  //                       width: 10,
  //                       color: Colors.green,
  //                       // child: Center(
  //                       //   child: Text(
  //                       //     "Match!!",
  //                       //     style: TextStyle(color: Colors.white),
  //                       //   ),
  //                       // ),
  //                     ),
  //                   ),
  //                 ],
  //               ).ripple(
  //                 () {
  //                   // Get.toNamed(Routes.chatUiPage ,arguments: _bookmarkController.matchitem[index]);
  //                   Navigator.push(context,
  //                       MaterialPageRoute(builder: (context) {
  //                     return ChatUiPage(
  //                       matchItem: _chatPageController.matchitem[index],
  //                       // getBookData: widget.getBookData,
  //                     );
  //                   }));
  //                 },
  //               ),
  //             ),
  //           ),
  //         )),
  //   );
  // }

  // Padding subTiTle(
  //   String maintext,
  //   String texttext,
  // ) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 3, bottom: 3, left: 5),
  //     child: Row(
  //       children: [
  //         TitleText(
  //           text: texttext,
  //           color: LightColor.grey,
  //           fontSize: 15,
  //         ),
  //         TitleText(
  //           text: maintext,
  //           color: LightColor.black,
  //           fontSize: 15,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
