import 'package:flutter/material.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

class SubText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  const SubText(
      {Key? key,
      required this.text,
      this.fontSize = 18,
      this.fontWeight = FontWeight.w800,
      this.color = LightColor.dialogTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.mulish(
          fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }
}
