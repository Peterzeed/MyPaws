import 'package:flutter/material.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/theme/theme.dart';
import 'package:mypaws/core/widget/appbar_back.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypaws/src/pages/feed/found%20pet/found_pet_feed_controller.dart';
import 'package:get/get.dart';
import 'package:mypaws/src/pages/search/finding%20pet/finding_pet.dart';

class FoundPetPage extends StatelessWidget {
 FoundPetPage({super.key});

  final _foundPetController = Get.put(FoundPetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  const AppBarBack(),
                  _title(),
                ],
              ),
              _detailWidget(context),
            ],
          ),
        ),
      ),
      floatingActionButton: _floatingButton(context),
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
        Get.to(()=>FindingPet(), arguments: 'foundpet');
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
                    child: const Icon(Icons.add,color: Colors.black,size: 15,),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSheetContent(context) {
    return GetBuilder<FoundPetController>(
      builder: (FoundPetController controller) {
        return Column(
          children: [
            Card(
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Image.asset('assets/dog1.jpg'),
                    title: const Text('สุนัข'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('พันธุ์ : ไทยหลังอาน'),
                        Text('พิกัดที่พบ : 122.00000,161.1351510'),
                        Text('วันที่พบ : 12/01/2023'),
                        Text('สถานะ : กำลังตามหาเจ้าของ'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
