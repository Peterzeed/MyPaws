import 'package:flutter/material.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/theme/theme.dart';
import 'package:mypaws/core/widget/appbar_back.dart';
import 'package:mypaws/core/widget/custom_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';


class HeaderBack extends StatelessWidget {
  const HeaderBack ({
    Key? key,
    required this.headLine1,
    required this.headLine2,
    this.isShoppingCart = false,
    this.onPressedIcon,
  }) : super(key: key);
  final String headLine1;
  final String headLine2;
  final bool isShoppingCart;
  final Function? onPressedIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarBack(),
          _title(),
        ],
      ),
    );
  }

  Widget _title() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headLine1,
                    style: GoogleFonts.mulish().copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: LightColor.titleTextColor),
                  ),
                  Text(
                    headLine2,
                    style: GoogleFonts.mulish().copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: LightColor.titleTextColor),
                  ),
                ]),
           
          ]),
    );
  }
}
