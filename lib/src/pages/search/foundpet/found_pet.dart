import 'package:flutter/material.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/theme/theme.dart';
import 'package:mypaws/core/widget/appbar_back.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypaws/core/widget/title_text.dart';
import 'package:mypaws/src/pages/feed/foundpet/found_pet_feed_controller.dart';
import 'package:get/get.dart';
import 'package:mypaws/src/pages/search/findingpet/finding_pet.dart';
import 'package:mypaws/src/pages/search/foundpet/found_pet_controller.dart';

class FoundPetPage extends StatelessWidget {
  FoundPetPage({super.key});

  final _foundPetController = Get.put(FoundPetPageController());

  String? texttext;

  String? maintext;

  String? lat,lng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GetBuilder<FoundPetPageController>(
          builder: (controller) {
            return Column(
              children: [
                const AppBarBack(),
                _title(),
                const SizedBox(
                  height: 20,
                ),
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
                                              subTiTle(maintext = "${_foundPetController.myfoundpet[index].type}",texttext = "ชนิด : ",),
                                              subTiTle(maintext = "${_foundPetController.myfoundpet[index].breed}",texttext = "สายพันธุ์ : ",),
                                              subTiTlePosition(lat = "${_foundPetController.myfoundpet[index].lat}",lng = "${_foundPetController.myfoundpet[index].lng}",texttext = "พิกัดที่พบ : ",),
                                              subTiTle(maintext = "${_foundPetController.myfoundpet[index].date}",texttext = "วันที่พบ : ",),
                                              subTiTle(maintext = "ตามหาเจ้าของ",texttext = "สถานะ : ",),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
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

  Padding subTiTle(String maintext,String texttext,) {
    return Padding(
      padding: const EdgeInsets.only(top: 3,bottom: 3,left: 5),
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

  Padding subTiTlePosition(String lat,String lng,String texttext) {
    return Padding(
      padding: const EdgeInsets.only(top: 3,bottom: 3,left: 5),
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


  Widget _detailWidget(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: DraggableScrollableSheet(
        maxChildSize: 1,
        initialChildSize: .75,
        minChildSize: .75,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            padding: AppTheme.padding.copyWith(bottom: 0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                controller: scrollController,
                // physics: const BouncingScrollPhysics(),
                child: _bottomSheetContent(context),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _title() {
    return Center(
      // padding: const EdgeInsets.all(16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Found",
              style: GoogleFonts.mulish().copyWith(
                  fontSize: 45,
                  fontWeight: FontWeight.w400,
                  color: LightColor.lightGrey),
            ),
            Text(
              "Pet",
              style: GoogleFonts.mulish().copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: LightColor.lightGrey),
            ),
          ]),
    );
  }

  Widget _floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Navigator.of(context).pushNamed('/findpet');
        Get.to(() => FindingPet(), arguments: 'foundpet');
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

  Widget _bottomSheetContent(context) {
    return Column(
      children: [
        Expanded(
            child: Obx(() => _foundPetController.myfoundpet.isNotEmpty
                ? myFoundingPet()
                : Center(
                    child: Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      color: Colors.greenAccent[100],
                      child: SizedBox(
                        width: 300,
                        height: 500,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.green[500],
                                radius: 108,
                                child: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"), //NetworkImage
                                  radius: 100,
                                ), //CircleAvatar
                              ), //CircleAvatar
                              const SizedBox(
                                height: 10,
                              ), //SizedBox
                              Text(
                                'GeeksforGeeks',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.w500,
                                ), //Textstyle
                              ), //Text
                              const SizedBox(
                                height: 10,
                              ), //SizedBox
                              const Text(
                                'GeeksforGeeks is a computer science portal for geeks at geeksforgeeks.org. It contains well written, well thought and well explained computer science and programming articles, quizzes, projects, interview experiences and much more!!',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                ), //Textstyle
                              ), //Text
                              const SizedBox(
                                height: 10,
                              ), //SizedBox
                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () => 'Null',
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.touch_app),
                                        Text('Visit')
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )))
      ],
    );
  }

  Widget myFoundingPet() {
    return ListView.builder(
      itemCount: _foundPetController.myfoundpet.length,
      itemBuilder: (context, index) => Center(
        child: Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.greenAccent[100],
          child: SizedBox(
            width: 300,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green[500],
                    radius: 108,
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"), //NetworkImage
                      radius: 100,
                    ), //CircleAvatar
                  ), //CircleAvatar
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  Text(
                    'GeeksforGeeks',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green[900],
                      fontWeight: FontWeight.w500,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  const Text(
                    'GeeksforGeeks is a computer science portal for geeks at geeksforgeeks.org. It contains well written, well thought and well explained computer science and programming articles, quizzes, projects, interview experiences and much more!!',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () => 'Null',
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: const [
                            Icon(Icons.touch_app),
                            Text('Visit')
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
