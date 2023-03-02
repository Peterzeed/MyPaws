import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/widget/title_text.dart';
import 'package:mypaws/src/model/match_profile_model.dart';
import 'package:mypaws/src/pages/chat/chat_page_controller.dart';

class ChatUiPage extends StatefulWidget {
  final MatchItemModel? matchItem;
  ChatUiPage({super.key, required this.matchItem});

  @override
  State<ChatUiPage> createState() => _ChatUiPageState();
}

class _ChatUiPageState extends State<ChatUiPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  String? texttext;

  String? maintext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                // margin: const EdgeInsets.all(5),
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Image.network(
                    widget.matchItem!.foundpetpic,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subTiTle(
                    maintext = "${widget.matchItem!.petbreed}",
                    // texttext = "สายพันธุ์ : ",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3, left: 5),
                    child: Row(
                      children: [
                        TitleText(
                          text: widget.matchItem!.matchdate,
                          color: LightColor.background,
                          fontSize: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Chat(
          messages: _messages, onSendPressed: _handleSendPressed, user: _user),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: "id",
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  Padding subTiTle(
    String maintext,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3, left: 5),
      child: Row(
        children: [
          TitleText(
            text:
                maintext.substring(0, 1).toUpperCase() + maintext.substring(1),
            color: LightColor.background,
            fontSize: 25,
          ),
        ],
      ),
    );
  }
}
