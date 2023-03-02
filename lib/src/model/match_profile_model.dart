import 'package:cloud_firestore/cloud_firestore.dart';

class MatchItemModel {
  String? id;
  late final String finderid;
  late final String findername;
  late final String finderphone;
  late final String finderpic;
  late final String founderid;
  late final String foundername;
  late final String founderphone;
  late final String foundpetpic;
  late final String matchdate;
  late final String petbreed;

  MatchItemModel(
      {this.id,
      required this.finderid,
      required this.findername,
      required this.finderphone,
      required this.finderpic,
      required this.founderid,
      required this.foundername,
      required this.founderphone,
      required this.foundpetpic,
      required this.matchdate,
      required this.petbreed
      });

  MatchItemModel.fromMap(DocumentSnapshot data) {
    id = data.id;
    finderid = data["finderid"];
    findername = data["findername"];
    finderphone = data["finderphone"];
    finderpic = data["finderpic"];
    founderid = data["founderid"];
    foundername = data["foundername"];
    founderphone = data["founderphone"];
    foundpetpic = data["foundpetpic"];
    matchdate = data["matchdate"];
    petbreed = data["petbreed"];
  }
}
