import 'package:flutter/material.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/type.dart';
import 'package:mypaws/core/widget/extensions.dart';
import 'package:mypaws/core/widget/icon_button.dart';
import 'package:mypaws/src/model/pet_match.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MatchItem extends StatelessWidget {
  MatchItem({Key? key, required this.matchpet, this.onSelected})
      : super(key: key);

  final MatchPet matchpet;
  final OnSelected? onSelected;
  String? conTitle;
  String? contentType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: matchpet.isSelected ? 700 : 700,
          height: 900,
          decoration: const BoxDecoration(
              color: LightColor.background,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black38, blurRadius: 20, spreadRadius: 0.5)
              ]),
          margin: EdgeInsets.symmetric(vertical: !matchpet.isSelected ? 0 : 0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          ),
                          // margin: const EdgeInsets.all(10),
                          width: 200,
                          height: 180,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(13)),
                            child: Image.asset(
                              matchpet.image,
                              height: matchpet.isSelected ? 300 : 300,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: product.isSelected ? 15 : 0,
                  // ),
                  textCard(
                      conTitle = 'สายพันธ์',
                      matchpet.breed,
                      icon: Icons.pets,
                      contentType = "text"),
                  const SizedBox(
                    height: 20,
                  ),
                  textCard(
                      conTitle = 'ลักษณะพิเศษ',
                      matchpet.specific,
                      icon: Icons.color_lens,
                      contentType = "text"),
                  const SizedBox(
                    height: 20,
                  ),
                  latLngCtn(
                      conTitle = 'พิกัดที่พบ', matchpet.lat, matchpet.lng),
                  const SizedBox(
                    height: 20,
                  ),
                  textCard(
                    conTitle = 'วันที่พบ',
                    matchpet.date,
                    contentType = "date",
                    icon: Icons.calendar_month,
                  ),

                  const SizedBox(
                    height: 70,
                  )
                ],
              )
            ],
          ),
        ).ripple(
          () {
            if (onSelected != null) {
              onSelected!(matchpet);
            }
          },
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        // const SizedBox(
        //   height: 700,
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 440),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              IconButtonn(icon: Icons.close, color: Colors.red),
              SizedBox(
                width: 40,
              ),
              IconButtonn(icon: Icons.check, color: Colors.green),
            ],
          ),
        )
      ],
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
}
