import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/theme/theme.dart';
import 'package:mypaws/core/widget/appbar_icon_button.dart';
import 'package:mypaws/core/widget/extensions.dart';
import 'package:mypaws/core/widget/title_text.dart';
import 'package:mypaws/src/model/user_model.dart';
import 'package:mypaws/src/pages/setting/setting_page_controller.dart';
import 'package:mypaws/src/pages/setting/user_repo.dart';

import '../../../core/DI/auth_controller.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final _settingPageController = Get.put(SettingPageController());

  final _userProfile = Get.put(ProfileController());

  String textBoxName = '';
  String? conTitle;
  // var emailCtr = TextEditingController();
  // var passwordCtr = TextEditingController();
  // var nameCtr = TextEditingController();
  // var lastnameCtr = TextEditingController();
  // var phoneCtr = TextEditingController();

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: AppTheme.fullWidth(context),
          height: AppTheme.fullHeight(context),
          child: Column(
            children: <Widget>[
              _appBar(),
              Expanded(
                child: _content(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              AppbarIconButton(
                Icons.arrow_back_ios,
                iconColor: Colors.black54,
                boxShadow: const [],
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Container(
      height: AppTheme.fullHeight(Get.context!),
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: AppTheme.fullWidth(Get.context!),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Column(
                children: [
                  FutureBuilder(
                    future: _userProfile.getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          UserModel userData = snapshot.data as UserModel;
                          return Column(
                            children: [
                              // Center(
                              //   child: GestureDetector(
                              //     child: _enterPic(_settingPageController),
                              //     onTap: () {
                              //       _showOptions(context);
                              //     },
                              //   ),
                              // ),
                              Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                  ),
                                  margin: const EdgeInsets.all(16),
                                  width: 150,
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                    child: Image.network(
                                      userData.urlPic,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              textCard(
                                textBoxName = 'Email',
                                userData.email,
                                icon: Icons.lock_person,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textCard(
                                textBoxName = 'Name',
                                userData.name,
                                icon: Icons.person,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textCard(
                                textBoxName = 'Lastname',
                                userData.lastname,
                                icon: Icons.abc_outlined,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textCard(
                                textBoxName = 'Phone',
                                userData.phone,
                                icon: Icons.phone_android,
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else {
                          return const Center(
                            child: Text("Something went wrong"),
                          );
                        }
                      } else {
                        return Center(
                          child: Container(),
                        );
                      }
                    },
                    // textCard(conTitle = 'Email',
                    //   icon: Icons.person ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  // _textField(textBoxName = 'Password',
                  //     icon: Icons.lock_person, controller: passwordCtr),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // _textField(textBoxName = 'Name',
                  //     icon: Icons.face, controller: nameCtr),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // _textField(textBoxName = 'Lastname',
                  //     icon: Icons.color_lens, controller: lastnameCtr),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // _textField(textBoxName = 'Phone',
                  //     icon: Icons.contact_phone_outlined, controller: phoneCtr),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: LightColor.iconColor,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.logout_outlined),
                        SizedBox(
                          width: 16,
                        ),
                        TitleText(
                          text: "logout",
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ).ripple(
                    () {
                      _authController.logOut();
                    },
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _enterPic(SettingPageController controller) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      margin: const EdgeInsets.all(16),
      width: 150,
      height: 150,
      child: _settingPageController.image != null
          ? ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              child: Image.file(
                _settingPageController.image!,
                fit: BoxFit.cover,
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TitleText(
                    color: Colors.white,
                    text: "รูปโปรไฟล์",
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

  Widget _textField(
    String textBoxName,
    String? value, {
    IconData? icon,
  }) {
    return Container(
      height: 60,
      width: 400,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 202, 202, 202).withAlpha(100),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        initialValue: value,
        // textInputAction: TextInputAction.search,
        // decoration: InputDecoration(
        //   border: InputBorder.none,
        //   hintText: textBoxName,
        //   contentPadding:
        //       EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 15),
        //   prefixIcon: Icon(
        //     icon,
        //     color: Colors.black54,
        //   ),
        // ),
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
                _settingPageController.getImageFromGallery();
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
                _settingPageController.getImageFromCamera();
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

  Widget textCard(String title, String ans, {IconData? icon}) {
    return Container(
      height: 40,
      width: 400,
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
          Text(
            "${title} : ${ans}",
            style: const TextStyle(color: Colors.black54, fontSize: 15),
          )
        ],
      ),
    );
  }
}
