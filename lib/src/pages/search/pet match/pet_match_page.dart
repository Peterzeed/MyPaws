import 'package:flutter/material.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/theme/theme.dart';
import 'package:mypaws/core/type.dart';
import 'package:mypaws/core/widget/appbar_back.dart';
import 'package:mypaws/core/widget/extensions.dart';
import 'package:mypaws/core/widget/icon_button.dart';
import 'package:mypaws/core/widget/title_back.dart';
import 'package:mypaws/src/pages/chat/chat_page.dart';
import 'package:mypaws/src/pages/search/pet%20match/match_item.dart';
import 'package:mypaws/src/pages/search/pet%20match/pet_match_controller.dart';
import 'package:get/get.dart';
import 'package:dots_indicator/dots_indicator.dart';

class PetMatchPage extends StatelessWidget {
  PetMatchPage({super.key, this.onSelected});

  String? petBreed = Get.arguments as String;

  String? conTitle;
  final OnSelected? onSelected;

  String? contentType;

  final _petMatchController = Get.put(PetMatchController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
            reverse: false,
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: AppTheme.fullWidth(context),
                  height: AppTheme.fullHeight(context) * .4,
                  child: GetBuilder<PetMatchController>(builder: (controller) {
                    if (controller.petmatch.isNotEmpty) {
                      return GridView.builder(
                        itemCount: _petMatchController.petmatch.length,
                        itemBuilder: (context, index) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.white,
                        ),
                        physics: const BouncingScrollPhysics(),
                        clipBehavior: Clip.none,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 5,
                        ),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        scrollDirection: Axis.horizontal,
                      );
                    }
                    return const SizedBox();
                  }))
            ])));
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
          Icon(Icons.pin_drop, color: Colors.black54),
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

  Widget _matchList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 1000,
      height: 500,
      child: GetBuilder<PetMatchController>(
        builder: (controller) {
          if (controller.matchList.isNotEmpty) {
            return GridView(
              physics: const BouncingScrollPhysics(),
              clipBehavior: Clip.none,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 5,
              ),
              padding: const EdgeInsets.only(left: 20, right: 20),
              scrollDirection: Axis.horizontal,
              children: controller.matchList
                  .where((element) => petBreed == element.breed)
                  .map(
                    (match) => MatchItem(
                      matchpet: match,
                      onSelected: _onSelectedMatch,
                    ),
                  )
                  .toList(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _onSelectedMatch(item) {
    // Navigator.of(context).pushNamed(Routes.detailPage,
    //     arguments: {ProductDetailPage.productItemArg: item});
    // Get.toNamed(
    //   Routes.detailPage,
    //   arguments: [
    //     {ProductDetailPage.productItemArg: item},
    //     {ProductDetailPage.productItemArg: item},
    //   ],
    // );
  }
}
