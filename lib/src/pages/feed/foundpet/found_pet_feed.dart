import 'package:flutter/material.dart';
import 'package:mypaws/core/config/routes.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/widget/extensions.dart';
import 'package:mypaws/core/widget/title_text.dart';
import 'package:mypaws/src/pages/feed/foundpet/foundfeeddetail/found_page_detail.dart';
import 'package:mypaws/src/pages/feed/lostpet/feeddetail/lost_feed_detail.dart';
import 'package:mypaws/src/pages/feed/foundpet/found_pet_feed_controller.dart';
import 'package:get/get.dart';
import 'package:mypaws/src/pages/search/findingpet/finding_pet.dart';

class FoundPetFeed extends GetView<FoundPetFeedController> {
  FoundPetFeed({super.key});

  final _foundPetController = Get.put(FoundPetFeedController());

  String? texttext;

  String? maintext;

  String? lat, lng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GetBuilder<FoundPetFeedController>(
          builder: (controller) {
            return Column(
              children: [
                Expanded(
                  child: Obx(
                    () => _foundPetController.myfoundpet.isNotEmpty
                        ? ListView.builder(
                            itemCount: _foundPetController.myfoundpet.length,
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
                                              _foundPetController
                                                  .myfoundpet[index].image,
                                              height: 300,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          subTiTle(
                                            maintext =
                                                "${_foundPetController.myfoundpet[index].type}",
                                            texttext = "ชนิด : ",
                                          ),
                                          subTiTle(
                                            maintext =
                                                "${_foundPetController.myfoundpet[index].breed}",
                                            texttext = "สายพันธุ์ : ",
                                          ),
                                          subTiTlePosition(
                                            lat =
                                                "${_foundPetController.myfoundpet[index].lat}",
                                            lng =
                                                "${_foundPetController.myfoundpet[index].lng}",
                                            texttext = "พิกัดที่พบ : ",
                                          ),
                                          subTiTle(
                                            maintext =
                                                "${_foundPetController.myfoundpet[index].date}",
                                            texttext = "วันที่พบ : ",
                                          ),
                                          subTiTle(
                                            maintext = "ตามหาเจ้าของ",
                                            texttext = "สถานะ : ",
                                          ),
                                        ],
                                      ),
                                    ).ripple(
                                      (){
                                         _selectedFoundPetPost(_foundPetController.myfoundpet[index]);
                                      }
                                    )
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

  Widget _floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => FindingPet(), arguments: "foundpet");
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

   void _selectedFoundPetPost(dynamic mylostpet) {
     Get.toNamed(Routes.foundFeedDetailPage, arguments: [
      {
        FoundFeedDetail.itemArg: mylostpet,
      }
    ]);
  }
}
