import 'package:flutter/material.dart';
import 'package:mypaws/core/DI/auth_controller.dart';
import 'package:mypaws/core/widget/extensions.dart';
import 'package:get/get.dart';

import '../theme/light_color.dart';
import '../theme/theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _icon(
            context,
            Icons.logout_outlined,
            color: Colors.black54,
            onPressed: () {
              AuthController.instance.logOut();
              
                          },
          ),
          _icon(
            context,
            Icons.pin_drop,
            color: LightColor.orange,
            onPressed: () {
              // Get.toNamed(Routes.nearbyStorePage);
            },
          ),
        ],
      ),
    );
  }

  Widget _icon<T>(BuildContext context, T icon,
      {Color color = LightColor.iconColor, VoidCallback? onPressed}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: LightColor.lightGrey,
      ),
      child: icon is IconData
          ? Icon(
              icon,
              color: color,
            )
          : Image.asset(
              icon as String,
              color: color,
              width: 24,
              height: 24,
            ),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }
}
