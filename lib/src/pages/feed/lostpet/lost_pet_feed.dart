import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/config/routes.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/widget/extensions.dart';
import 'package:mypaws/core/widget/title_text.dart';
import 'package:mypaws/src/model/lost_pet_model.dart';
import 'package:mypaws/src/pages/feed/lostpet/feeddetail/lost_feed_detail.dart';
import 'package:mypaws/src/pages/feed/lostpet/lost_pet_controller.dart';
import 'package:mypaws/src/pages/search/findingpet/finding_pet.dart';

class LostPetFeed extends GetView<LostPetController> {
  LostPetFeed({super.key});

  final _lostPetController = Get.put(LostPetController());

  String? texttext;

  String? maintext;

  String? lat, lng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GetBuilder<LostPetController>(
          builder: (controller) {
            return Column(
              children: [
                Expanded(
                  child: Obx(
                    () => _lostPetController.mylostpet.isNotEmpty
                        ? ListView.builder(
                            itemCount: _lostPetController.mylostpet.length,
                            itemBuilder: (context, index) => Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                    child: Container(
                                      width: 300,
                                      height: 300,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 300,
                                            child: Image.network(
                                              _lostPetController
                                                  .mylostpet[index].image!,
                                              height: 300,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          subTiTle(
                                            maintext =
                                                "${_lostPetController.mylostpet[index].type}",
                                            texttext = "ชนิด : ",
                                          ),
                                          subTiTle(
                                            maintext =
                                                "${_lostPetController.mylostpet[index].breed}",
                                            texttext = "สายพันธุ์ : ",
                                          ),
                                          subTiTlePosition(
                                            lat =
                                                "${_lostPetController.mylostpet[index].lat}",
                                            lng =
                                                "${_lostPetController.mylostpet[index].lng}",
                                            texttext = "พิกัดที่หาย : ",
                                          ),
                                          subTiTle(
                                            maintext =
                                                "${_lostPetController.mylostpet[index].date}",
                                            texttext = "วันที่หาย : ",
                                          ),
                                          subTiTle(
                                            maintext = "ตามหาเจ้าของ",
                                            texttext = "สถานะ : ",
                                          ),
                                        ],
                                      ),
                                    ).ripple(
                                      () {
                                        // Get.to();
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) {
                                        //       return LostFeedDetail(
                                        //         lostPetPostSelect:
                                        //             _lostPetController
                                        //                 .mylostpet[index],
                                        //       );
                                        //     },
                                        //   ),
                                        _selectedLostPetPost(_lostPetController
                                            .mylostpet[index]);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: const [
                              SizedBox(
                                height: 200,
                              ),
                              Center(
                                child: TitleText(
                                  text: 'My Found Pet is empty',
                                  color: LightColor.grey,
                                ),
                              ),
                            ],
                          ),
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: _floatingButton(context),
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

  Widget _floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => FindingPet(), arguments: "lostpet");
      },
      backgroundColor: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Align(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Icon(Icons.pets,
                    color: Theme.of(Get.context!)
                        .floatingActionButtonTheme
                        .backgroundColor),
              ),
              Positioned(
                right: 3,
                top: 27,
                child: Container(
                  width: 22,
                  height: 22,
                  padding: const EdgeInsets.only(left: 1),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black54),
                    color: Colors.white,
                  ),
                  // child: GetBuilder<CartController>(
                  //   builder: (controller) {
                  //     return TitleText(
                  //       text: "${controller.carTotal}",
                  //       color: LightColor.orange,
                  //       fontSize: 12,
                  //     );
                  //   },
                  // )
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding subTiTlePosition(String lat, String lng, String texttext) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3, left: 5),
      child: Row(
        children: [
          TitleText(
            text: texttext,
            color: LightColor.grey,
            fontSize: 15,
          ),
          Column(
            children: [
              SizedBox(
                width: 20,
              ),
              TitleText(
                text: lat,
                color: LightColor.black,
                fontSize: 10,
              ),
              TitleText(
                text: lng,
                color: LightColor.black,
                fontSize: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _selectedLostPetPost(dynamic mylostpet) {
     Get.toNamed(Routes.lostfeedDetailPage, arguments: [
      {
        LostFeedDetail.itemArg: mylostpet,
      }
    ]);
  }
}
