import 'package:flutter/material.dart';
import 'package:mypaws/core/config/ctr/add_bookmark_controller.dart';
import 'package:mypaws/core/config/ctr/found_data_controller.dart';
import 'package:mypaws/core/config/routes.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/theme/theme.dart';
import 'package:mypaws/core/type.dart';
import 'package:mypaws/core/widget/appbar_back.dart';
import 'package:mypaws/core/widget/extensions.dart';
import 'package:mypaws/core/widget/home_header.dart';
import 'package:mypaws/core/widget/icon_button.dart';
import 'package:mypaws/core/widget/title_back.dart';
import 'package:mypaws/core/widget/title_text.dart';
import 'package:mypaws/src/model/boomark_item.dart';
import 'package:mypaws/src/model/match_data.dart';
import 'package:mypaws/src/model/match_model.dart';
import 'package:mypaws/src/pages/chat/chat_page.dart';
import 'package:mypaws/src/pages/search/petmatch/match_item.dart';
import 'package:mypaws/src/pages/search/petmatch/pet_match_controller.dart';
import 'package:get/get.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class PetMatchPage extends StatelessWidget {
  PetMatchPage({super.key, this.onSelected});

  final db = FirebaseFirestore.instance;

  String? conTitle;

  final OnSelected? onSelected;

  String? contentType;

  final _bookmarkController = Get.find<AddBookmartController>();

  final _petMatchController = Get.put(PetMatchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(children: [
          HomeHeader(headLine1: "MyPaws", headLine2: "Match"),
          Expanded(
            child: Obx(() => _petMatchController.petmatch.isNotEmpty
                ? petMatchCard()
                : notFoundCard()),
          ),
        ]),
      ),
    );
  }

  Container notFoundCard() {
    return Container(
      width: 300,
      height: 500,
      decoration: const BoxDecoration(
          color: LightColor.background,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black38, blurRadius: 20, spreadRadius: 0.5)
          ]),
      margin: const EdgeInsets.symmetric(vertical: 0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Get.offAllNamed(Routes.mainPage);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                        // margin: const EdgeInsets.all(10),
                        width: 200,
                        height: 180,
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                "ไม่พบข้อมูล",
                                style: GoogleFonts.mulish(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: LightColor.titleTextColor,
                                ),
                              ),
                              Text(
                                "แตะเพื่อกลับ",
                                style: GoogleFonts.mulish(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: LightColor.titleTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  GridView petMatchCard() {
    return GridView.builder(
      itemCount: _petMatchController.petmatch.length,
      itemBuilder: (context, index) => Stack(
        children: [
          Center(
            child: Container(
              width: 300,
              height: 500,
              decoration: const BoxDecoration(
                  color: LightColor.background,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 20,
                        spreadRadius: 0.5)
                  ]),
              margin: const EdgeInsets.symmetric(vertical: 0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                              ),
                              // margin: const EdgeInsets.all(10),
                              width: 200,
                              height: 180,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(13)),
                                child: Image.network(
                                  _petMatchController.petmatch[index].image,
                                  height: 300,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: product.isSelected ? 15 : 0,
                      // ),
                      textCard(
                          conTitle = 'สายพันธ์',
                          _petMatchController.petmatch[index].breed,
                          icon: Icons.pets,
                          contentType = "text"),
                      const SizedBox(
                        height: 20,
                      ),
                      textCardFade(
                          conTitle = 'ลักษณะพิเศษ',
                          _petMatchController.petmatch[index].specific,
                          icon: Icons.color_lens,
                          contentType = "text"),
                      const SizedBox(
                        height: 20,
                      ),
                      latLngCtn(
                          conTitle = 'พิกัดที่พบ',
                          _petMatchController.petmatch[index].lat,
                          _petMatchController.petmatch[index].lng),
                      const SizedBox(
                        height: 20,
                      ),
                      textCard(
                          conTitle = 'วันที่พบ',
                          _petMatchController.petmatch[index].date,
                          icon: Icons.calendar_month,
                          contentType = "date"),
                      const SizedBox(
                        height: 70,
                      )
                    ],
                  )
                ],
              ),
            ).ripple(
              () {
                if (onSelected != null) {
                  onSelected!(_petMatchController.petmatch);
                }
                // print();
              },
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
          // const SizedBox(
          //   height: 700,
          // ),
          GetBuilder<PetMatchController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(top: 485, left: 130),
                child: Container(
                  width: 50,
                  height: 50,
                  // child: IconButtonn(icon: Icons.bookmark, color: Colors.black54),
                  child: Material(
                    borderRadius: BorderRadius.circular(100),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.white12,
                    child: InkWell(
                      onTap: _petMatchController
                                  .petmatch[index].isBookMarkAdd ==
                              false
                          ? () {
                              _petMatchController.setSelected(
                                  _petMatchController.petmatch[index]);
                              // _bookmarkController.addBookmark(BookmarkItem(
                              //     _petMatchController.petmatch[index]));
                              insertMatchData(
                                  _petMatchController.petmatch[index]);
                              Get.snackbar(
                                "",
                                "แตะที่นี่เพื่อ Chat",
                                backgroundColor: Color.fromARGB(66, 56, 56, 56),
                                snackPosition: SnackPosition.BOTTOM,
                                titleText: const Text(
                                  "เพิ่มไปยังหน้า Chat",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: (snack) {
                                  Get.offNamed(Routes.chatPage);
                                },
                              );
                              print(_petMatchController.petmatch[index].id);
                            }
                          : null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          GetBuilder<PetMatchController>(
                            builder: (controller) {
                              return Icon(
                                (_petMatchController
                                        .petmatch[index].isBookMarkAdd)
                                    ? Icons.favorite
                                    : Icons.favorite,
                                size: 30,
                                color: (_petMatchController
                                        .petmatch[index].isBookMarkAdd)
                                    ? Colors.red
                                    : Colors.black26,
                              );
                            },
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2,
        mainAxisSpacing: 1,
        crossAxisSpacing: 5,
      ),
      padding: const EdgeInsets.only(left: 20, right: 20),
      scrollDirection: Axis.horizontal,
    );
  }

  Future<void> insertMatchData(PetMatchModel matchsave) async {
    String founderid = matchsave.founder.toString();
    String foundername = matchsave.foundername;
    String founderphone = matchsave.founderphone;
    String foundPetPic = matchsave.image.toString();
    String petBreed = matchsave.breed.toString();
    String finderid = _petMatchController.owner!;
    String matchdate = _petMatchController.getCurrentDate();
    String findername = "${_petMatchController.username} ${_petMatchController.userlastname}";
    String finderphone = _petMatchController.userphone!;
    String finderpic = _petMatchController.userprofile!;
    String findpetid = _petMatchController.findpetid!;
    String foundpetid = matchsave.id.toString();

    final foundmatchData = {
      // "userid": [founderid,finderid],
      "foundpetid" : foundpetid,
      "founderid" : founderid,
      "foundername" : foundername,
      "founderphone" : founderphone,
      "findpetid" : findpetid,
      "finderid" : finderid,
      "findername" : findername,
      "finderphone" : finderphone,
      "finderpic" : finderpic,
      // "finderid": finderid,
      "foundpetpic": foundPetPic,
      "matchdate": matchdate,
      "petbreed": petBreed,
    };

    
    
    db.collection("matchdata").add(foundmatchData);
  }

  Widget latLngCtn(
    String title,
    String lat,
    String lng,
  ) {
    return Container(
      height: 40,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: LightColor.lightGrey.withAlpha(100),
        // color: Colors.black,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          const Icon(Icons.pin_drop, color: Colors.black54),
          const SizedBox(
            width: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Lat : ${lat}",
                style: const TextStyle(color: Colors.black54, fontSize: 11),
              ),
              Text(
                "Lat : ${lng}",
                style: const TextStyle(color: Colors.black54, fontSize: 11),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget textCard(String title, String ans, String content, {IconData? icon}) {
    return Container(
      height: 40,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: LightColor.lightGrey.withAlpha(100),
        // color: Colors.black,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          Icon(icon, color: Colors.black54),
          const SizedBox(
            width: 12,
          ),
          content == "text"
              ? Text(
                  "${title} : ${ans}",
                  style: const TextStyle(color: Colors.black54, fontSize: 11),
                )
              : Text(
                  "${title} : ${(ans).split(" ")[0]}",
                  style: const TextStyle(color: Colors.black54, fontSize: 11),
                )
        ],
      ),
    );
  }

  Widget textCardFade(String title, String ans, String content,
      {IconData? icon}) {
    return Container(
      height: 40,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: LightColor.lightGrey.withAlpha(100),
        // color: Colors.black,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          Icon(icon, color: Colors.black54),
          const SizedBox(
            width: 12,
          ),
          Flexible(
            child: Text(
              "${ans}",
              style: const TextStyle(color: Colors.black54, fontSize: 11),
              overflow: TextOverflow.clip,
              maxLines: 4,
              softWrap: false,
            ),
          )
        ],
      ),
    );
  }
}
