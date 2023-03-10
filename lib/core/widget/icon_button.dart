import 'package:flutter/material.dart';
import 'package:mypaws/core/theme/light_color.dart';

class IconButtonn extends StatelessWidget {
  const IconButtonn({super.key, required this.icon, required this.color});

  final IconData icon;
  final Color color;
  

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: color,
      child: InkWell(
        onTap: (() {

        }),
        child: Row(mainAxisSize: MainAxisSize.min, children:  [
          const SizedBox(
            width: 10,
          ),
          Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          )
        ]),
      ),
    );
  }
}