import 'package:cloud_firestore/cloud_firestore.dart';

class LostPetModel {
  String? owner;
  String? ownername;
  String? petname;
  String? date;
  String? lat;
  String? lng;
  String? specific;
  String? type;
  String? description;
  String? breed;
  String? image;
  // bool isBookMarkAdd = false;

  LostPetModel(
      {this.owner,
      this.ownername,
      this.petname,
      this.image,
      this.specific,
      this.date,
      this.lat,
      this.lng,
      this.description,
      this.type,
      this.breed,
      // required this.isBookMarkAdd
      });

  LostPetModel.fromMap(DocumentSnapshot data) {
    owner = data["owner"];
    ownername = data["ownername"];
    petname = data["petname"];
    image = data["image"];
    specific = data["specific"];
    date = data["date"];
    lat = data["lat"];
    lng = data["lng"];
    description = data["description"];
    type = data["type"];
    breed = data["breed"];
    // isBookMarkAdd = data["isBookMarkAdd"];
  }
}
