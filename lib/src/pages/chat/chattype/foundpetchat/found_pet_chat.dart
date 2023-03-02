import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/widget/extensions.dart';
import 'package:mypaws/core/widget/title_text.dart';
import 'package:mypaws/src/pages/chat/chatUI/chat_ui_page.dart';
import 'package:mypaws/src/pages/chat/chattype/foundpetchat/found_pet_chat_controller.dart';
import 'package:mypaws/src/pages/chat/chattype/lostpetchat/lost_pet_chat_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class FoundPetChat extends StatelessWidget {
  FoundPetChat({super.key});
  
  final _foundPetChat = Get.put(FoundPetChatController());

  String? texttext;

  String? maintext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.black,
      body: SafeArea(child: GetBuilder<LostPetChatController>(
        builder: (controller) {
          return Column(
            children: [
              
              Expanded(
                  child: Obx(() => _foundPetChat.matchitem.isNotEmpty
                      ? _chatItem(context)
                      : const Center(
                          child: TitleText(
                            text: 'Chat is empty',
                            color: LightColor.grey,
                          ),
                        ))),
            ],
          );
        },
      )),
    );
  }

  ListView _chatItem(BuildContext context) {
    return ListView.builder(
      itemCount: _foundPetChat.matchitem.length,
      itemBuilder: ((ctx, index) => Padding(
            padding: const EdgeInsets.all(15),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: 150,
                height: 70,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: Image.network(
                          _foundPetChat.matchitem[index].foundpetpic,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        subTiTle(
                          maintext =
                              "${_foundPetChat.matchitem[index].findername}",
                          texttext = "",
                        ),
                        subTiTle(
                          maintext =
                              "${_foundPetChat.matchitem[index].petbreed}",
                          texttext = "Breed : ",
                        ),
                        // subTiTle(
                        //   maintext =
                        //       "${_lostPetChat.matchitem[index].matchdate}",
                        //   texttext = "จับคู่เมื่อ : ",
                        // ),
                        
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          child: Container(
                            height: 10,
                            width: 10,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          _foundPetChat.matchitem[index].matchdate,
                          style: GoogleFonts.mulish().copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: LightColor.grey),
                        ),
                      ],
                    ),
                  ],
                ).ripple(
                  () {
                    // Get.toNamed(Routes.chatUiPage ,arguments: _bookmarkController.matchitem[index]);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChatUiPage(
                        matchItem: _foundPetChat.matchitem[index],
                        // getBookData: widget.getBookData,
                      );
                    }));
                  },
                ),
              ),
            ),
          )),
    );
  }

  Padding subTiTle(
    String maintext,
    String texttext,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3, left: 5),
      child: Row(
        children: [
          TitleText(
            text: texttext,
            color: LightColor.grey,
            fontSize: 15,
          ),
          TitleText(
            text: maintext,
            color: LightColor.black,
            fontSize: 15,
          ),
        ],
      ),
    );
  }
}