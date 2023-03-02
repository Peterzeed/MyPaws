// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:mypaws/core/config/ctr/add_bookmark_controller.dart';
// import 'package:mypaws/core/config/routes.dart';
// import 'package:mypaws/core/theme/light_color.dart';
// import 'package:mypaws/core/theme/theme.dart';
// import 'package:mypaws/core/widget/extensions.dart';
// import 'package:mypaws/core/widget/title_text.dart';
// import 'package:mypaws/src/model/boomark_item.dart';
// import 'package:mypaws/src/model/match_profile_model.dart';
// import 'package:mypaws/src/pages/chat/chat_page_controller.dart';
// import 'package:mypaws/src/pages/search/petmatch/match_item.dart';

// class ChatProfile extends StatelessWidget {
//   ChatProfile({Key? key}) : super(key: key);

//   final _chatPageController = Get.put(ChatPageController());
//   // final _bookmarkController = Get.put(AddBookmartController());

//   String? texttext;

//   String? maintext;

//   String? lat, lng;

//   @override
//   Widget build(BuildContext context) {
//     return _chatProfileItem(context);
//   }

//   Widget _chatProfileItem(BuildContext context) {
//     return _chatPageController.matchitem != 0
//         ? GetBuilder<ChatPageController>(
//             builder: (controller) {
//               return ListView.builder(
//                 itemCount: controller.matchitem.length,
//                 itemBuilder: ((ctx, index) {
//                   return _chatItem(
//                     controller.matchitem[index],
//                   );
//                 }),
//               );
//             },
//           )
//         : const Center(
//             child: TitleText(
//               text: 'Chat is empty',
//               color: LightColor.grey,
//             ),
//           );
//   }

//   Widget _chatItem(MatchItemModel model) {
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.all(Radius.circular(16.0)),
//         child: Container(
//           width: 150,
//           height: 150,
//           color: Colors.white,
//           child: Row(
//             children: [
//               Container(
//                 height: 150,
//                 width: 150,
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.all(Radius.circular(16.0)),
//                   child: Image.network(
//                     model.foundpetpic,
//                     height: 300,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   subTiTle(
//                     maintext = "${model.petbreed}",
//                     texttext = "สายพันธุ์ : ",
//                   ),
//                   subTiTle(
//                     maintext = "${model.matchdate}",
//                     texttext = "วันที่พบ : ",
//                   ),
//                 ],
//               ),
//             ],
//           ).ripple((){
//             Get.toNamed(Routes.chatUiPage);
//           })
//         )
//       )
//     );
//   }

//   Padding subTiTle(
//     String maintext,
//     String texttext,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 3, bottom: 3, left: 5),
//       child: Row(
//         children: [
//           TitleText(
//             text: texttext,
//             color: LightColor.grey,
//             fontSize: 15,
//           ),
//           TitleText(
//             text: maintext,
//             color: LightColor.black,
//             fontSize: 15,
//           ),
//         ],
//       ),
//     );
//   }

//   Padding subTiTlePosition(String lat, String lng, String texttext) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 3, bottom: 3, left: 5),
//       child: Row(
//         children: [
//           TitleText(
//             text: texttext,
//             color: LightColor.grey,
//             fontSize: 15,
//           ),
//           Column(
//             children: [
//               SizedBox(
//                 width: 20,
//               ),
//               TitleText(
//                 text: lat,
//                 color: LightColor.black,
//                 fontSize: 10,
//               ),
//               TitleText(
//                 text: lng,
//                 color: LightColor.black,
//                 fontSize: 10,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
