import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mypaws/core/config/ctr/scan_controller.dart';
import 'package:mypaws/core/config/enum/pet_type.dart';
import 'package:mypaws/core/config/routes.dart';
import 'package:mypaws/core/config/shared_pref.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/theme/theme.dart';
import 'package:mypaws/core/widget/appbar_back.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/widget/extensions.dart';
import 'package:mypaws/core/widget/title_text.dart';
import 'package:mypaws/src/pages/search/finding%20pet/finding_pet_controller.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mypaws/src/pages/search/pet%20match/pet_match_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FindingPet extends StatelessWidget {
  FindingPet({super.key});

  var searchType = Get.arguments;

  final formkey = GlobalKey<FormState>();

  TextEditingController _petname = TextEditingController();
  TextEditingController _petSpecific = TextEditingController();
  TextEditingController _petDescription = TextEditingController();

  final _prefs = const FlutterSecureStorage();

  static const pinLat = '';
  static const pinLng = '';

  final _findPetController = Get.put(FindingPetController());
  final _scanPetBreed = Get.put(ScanController());

  PetType? petsEnum;

  String? urlPic;

  String textBoxName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(
              FocusScopeNode()), //ต้องการเอาคีบอร์ดลง หรือหมายถึง ออกจากโฟกัส
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
              "${searchType}",
              style: GoogleFonts.mulish().copyWith(
                  fontSize: 45,
                  fontWeight: FontWeight.w400,
                  color: LightColor.lightGrey),
            ),
            // Text(
            //   "Pet",
            //   style: GoogleFonts.mulish().copyWith(
            //       fontSize: 20,
            //       fontWeight: FontWeight.w700,
            //       color: LightColor.lightGrey),
            // ),
          ]),
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

  Widget _bottomSheetContent(context) {
    return GetBuilder<FindingPetController>(
      builder: (FindingPetController controller) {
        return Form(
          key: formkey,
          child: Column(
            children: [
              GetBuilder<ScanController>(
                builder: (ScanController scanController) {
                  return GestureDetector(
                    child: _enterPic(scanController),
                    onTap: () {
                      _showOptions(context);
                    },
                  );
                },
              ),
              searchType == 'findpet'
                  ? _textField(
                      textBoxName = 'ชื่อสัตว์เลี้ยง',
                      icon: Icons.pets,
                      controller: _petname,
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              _textField(textBoxName = 'ลักษณะพิเศษ',
                  icon: Icons.color_lens, controller: _petSpecific),
              const SizedBox(
                height: 10,
              ),
              chooseDate(controller),
              const SizedBox(
                height: 10,
              ),
              chooseLocation(context),
              const SizedBox(
                height: 10,
              ),
              _description(textBoxName = 'ข้อความเพิ่มเติม',
                  icon: Icons.edit_outlined, controller: _petDescription),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    const Text('ประเภทสัตว์เลี้ยง'),
                    addRadioButton(0, "สุนัข"),
                    addRadioButton(1, "แมว"),
                  ],
                ),
              ),
              // _petType(),
              // RadioListTile(value: PetType.cat , groupValue: petsEnum, onChanged: null),
              const SizedBox(
                height: 20,
              ),
              _iconButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _petType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const TitleText(
          text: 'ประเภทของสัตว์เลี้ยง',
          fontSize: 17,
          color: Colors.black54,
        ),
        const SizedBox(
          height: 20,
        ),
        GetBuilder<FindingPetController>(
          builder: (controller) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: controller.gender
                  .map((e) =>
                      _sizeWidget(e, isSelected: e == controller.selectType))
                  .toList(),
            );
          },
        )
      ],
    );
  }

  Widget _sizeWidget(PetType type, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: !isSelected ? BorderStyle.solid : BorderStyle.none),
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        color: isSelected ? LightColor.black : Colors.white,
      ),
      child: TitleText(
        text: type.name,
        fontSize: 16,
        color: isSelected ? LightColor.background : Colors.black54,
      ),
    ).ripple(() {
      _findPetController.setSelectedType(type);
    }, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }

  GestureDetector chooseLocation(context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/findpetmap');
      },
      child: Container(
        height: 70,
        width: 300,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: LightColor.lightGrey.withAlpha(100),
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
            // const Text("วันเวลาที่หาย",style: TextStyle(color: Colors.black54),),
            _findPetController.lat == null || _findPetController.lng == null
                ? const Text("พิกัดที่สัตว์เลี้ยงหาย",
                    style: TextStyle(color: Colors.black54))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "พิกัดที่หาย ",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        "Lat :  ${_findPetController.lat} ",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        "Lng :  ${_findPetController.lng}",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  GestureDetector chooseDate(FindingPetController controller) {
    return GestureDetector(
      onTap: () {
        controller.chooseDate();
      },
      child: Container(
        height: 40,
        width: 300,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: LightColor.lightGrey.withAlpha(100),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            Icon(Icons.calendar_month, color: Colors.black54),
            const SizedBox(
              width: 12,
            ),
            // const Text("วันเวลาที่หาย",style: TextStyle(color: Colors.black54),),
            controller.pickedDate == null
                ? const Text("วันเวลาที่หาย",
                    style: TextStyle(color: Colors.black54))
                : Text(
                    "วันที่หาย : ${DateFormat("dd-MM-yyyy").format(controller.selectedDate.value)}",
                    style: const TextStyle(color: Colors.black54),
                  )
          ],
        ),
      ),
    );
  }

  Container _enterPic(ScanController controller) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
      margin: const EdgeInsets.all(16),
      width: 250,
      height: 150,
      child: _scanPetBreed.image != null
          ? ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(13)),
              child: Image.file(
                _scanPetBreed.image!,
                fit: BoxFit.contain,
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TitleText(
                    color: Colors.white,
                    text: "รูปภาพสัตว์เลี้ยง",
                  ),
                  TitleText(
                    color: Colors.white,
                    text: "แตะเพื่อเลือกรูป",
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Icon(
                    Icons.touch_app_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
    );
  }

  Widget _textField(String textBoxName,
      {IconData? icon, TextEditingController? controller}) {
    return Container(
      height: 70,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: LightColor.lightGrey.withAlpha(100),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        // controller: _mainPageController.searchController,
        // onSubmitted: (_) {
        //   _mainPageController.search();
        // },
        // key: formkey,
        controller: controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: textBoxName,
          contentPadding:
              EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 15),
          prefixIcon: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกข้อมูล';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _description(String textBoxName,
      {IconData? icon, TextEditingController? controller}) {
    return Container(
      height: 100,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: LightColor.lightGrey.withAlpha(100),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        maxLines: 10,
        // controller: _mainPageController.searchController,
        // onSubmitted: (_) {
        //   _mainPageController.search();
        // },
        controller: controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: textBoxName,
          contentPadding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
          prefixIcon: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกข้อมูล';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Future _showOptions(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                _scanPetBreed.getImageFromGallery();
                Navigator.pop(Get.overlayContext!);
              },
              leading: const Icon(Icons.image_outlined),
              title: const TitleText(
                text: "Gallery",
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {
                _scanPetBreed.getImageFromCamera();
                Navigator.pop(Get.overlayContext!);
              },
              leading: const Icon(Icons.photo_camera_outlined),
              title: const TitleText(
                text: "Camera",
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _iconButton() {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(50),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: LightColor.lightGrey.withAlpha(100),
        child: InkWell(
          onTap: (() {
            // if (formkey.currentState!.validate()) {
            // await searchType != null
            //     ? searchType == 'findpet'
            //         ? insertfindPetData()
            //         : insertfoundPetData()
            //     : print('something bad happened');
            // insertfindPetData();
            String petBreed = (_scanPetBreed.outputbreed![0]['label']).split("-")[1];
            Get.toNamed(Routes.petMatchPage, arguments: petBreed);
            // }
          }),
          child: Row(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.search,
              size: 50,
              color: Colors.black38,
            ),
            SizedBox(
              width: 5,
            )
          ]),
        ),
      ),
    );
  }

  Row addRadioButton(int btnIndex, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          activeColor: Colors.black,
          value: _findPetController.pets[btnIndex],
          groupValue: _findPetController.selectedType,
          onChanged: (value) => _findPetController.onClickRadioButton(value),
        ),
        Text(title)
      ],
    );
  }

  void insertfindPetData() async {
    await uploadPicture();

    String name = _petname.text;
    String specific = _petSpecific.text;
    String description = _petDescription.text;
    String petBreed = (_scanPetBreed.outputbreed![0]['label']).split("-")[1];
    String pettype = (_findPetController.selectedType).toString();
    String lostdate = (_findPetController.pickedDate).toString();
    String lostlat = _findPetController.lat.toString();
    String lostlng = _findPetController.lng.toString();
    String lostimg = (_findPetController.image).toString();

    final String? userId = await _prefs.read(key: SharedPreferenceKey.userId);

    CollectionReference reference =
        FirebaseFirestore.instance.collection("findpet");

    Map<String, String> findData = {
      "owner": userId!,
      "date": lostdate,
      "lat": lostlat,
      "lng": lostlng,
      "petname": name,
      "specific": specific,
      "type": pettype,
      "description": description,
      "breed": petBreed,
      "image": urlPic.toString()
    };

    reference
        .add(findData)
        .then((value) => Get.toNamed(Routes.petMatchPage, arguments: petBreed));
  }

  void insertfoundPetData() async {

    await uploadPicture();

    // String name = _petname.text;
    String specific = _petSpecific.text;
    String description = _petDescription.text;
    String petBreed = (_scanPetBreed.outputbreed![0]['label']).split("-")[1];
    String pettype = (_findPetController.selectedType).toString();
    String lostdate = (_findPetController.pickedDate).toString();
    String lostlat = _findPetController.lat.toString();
    String lostlng = _findPetController.lng.toString();
 

    final String? userId = await _prefs.read(key: SharedPreferenceKey.userId);

    CollectionReference reference =
        FirebaseFirestore.instance.collection("foundpet");

    Map<String, String> findData = {
      "founder": userId!,
      "date": lostdate,
      "lat": lostlat,
      "lng": lostlng,
      // "petname": name,
      "specific": specific,
      "type": pettype,
      "description": description,
      "breed": petBreed,
      "image" : urlPic.toString()
    };

    reference.add(findData).then((value) => Get.back());
  }


  

  Future<void> uploadPicture() async {
    Random random = Random();
    int i = random.nextInt(10000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference folderRef = firebaseStorage.ref().child('findpet/pet$i.jpg');
    UploadTask uploadTask = folderRef.putFile(_scanPetBreed.image!);

    urlPic = await (await uploadTask).ref.getDownloadURL();
    print("Url Picture : ${urlPic.toString()}");
  }
}
