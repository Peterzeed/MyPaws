import 'package:flutter/material.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/widget/extensions.dart';

class AppBarBack extends StatelessWidget {
  const AppBarBack({
    Key? key,
    this.onPressedIcon,
  }) : super(key: key);
  final Function? onPressedIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_appbar(context)],
      ),
    );
  }

  Widget _appbar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _icon(context, Icons.arrow_back_ios,
              color: Colors.black, size: 15, padding: 12, onPressed: () {
            Navigator.of(context).pop();
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
      width: 40,
      height: 40,
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
