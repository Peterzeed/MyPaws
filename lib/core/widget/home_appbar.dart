import 'package:flutter/material.dart';
import 'package:mypaws/core/config/routes.dart';
import 'package:mypaws/core/config/shared_pref.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/widget/extensions.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mypaws/src/pages/main/main_page.dart';

class AppBarHome extends StatelessWidget {

  static const prefs = FlutterSecureStorage();
  const AppBarHome({
    Key? key,
    this.onPressedIcon,
  }) : super(key: key);
  final Function? onPressedIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_appbar(context)],
      ),
    );
  }

  Widget _appbar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _icon(context, Icons.home,
              color: Colors.black, size: 20, padding: 12, onPressed: () {
            // Get.to(() => MainPage(email: '', title: '',));
                Get.offAllNamed(Routes.mainPage);
                // Get.offAndToNamed() Get.of() ตัวไหน
          }, isOutline: true),
        ],
      ),
    );
  }

  Widget _icon(BuildContext context, IconData icon,
      {double padding = 10,
      Color color = LightColor.iconColor,
      double size = 20,
      Function? onPressed,
      bool isOutline = false}) {
    return Container(
      // width: 40,
      // height: 40,
      padding: EdgeInsets.all(padding),
       decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: LightColor.lightGrey ,
          ),
      child: Padding(
        padding: EdgeInsets.only(left: icon == Icons.arrow_back_ios ? 2 : 0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: color,
                size: size,
              ),
            ),
          ],
        ),
      ),
    ).ripple(
      () {
        if (onPressed != null) {
          onPressed();
        }
      },
      borderRadius: const BorderRadius.all(
        Radius.circular(13),
      ),
    );
  }
}
