import 'package:cloud_firestore/cloud_firestore.dart';

class PetMatchModel {
  String? founder;
  String? date;
  String? lat;
  String? lng;
  String? specific;
  String? type;
  String? description;
  String? breed;
  String? image;

  PetMatchModel(
      {this.founder,
      this.image,
      this.specific,
      this.date,
      this.lat,
      this.lng,
      this.description,
      this.type,
      this.breed});

  PetMatchModel.fromMap(DocumentSnapshot data) {
    founder = data["founder"];
    image = data["image"];
    specific = data["specific"];
    date = data["date"];
    lat = data["lat"];
    lng = data["lng"];
    description = data["description"];
    type = data["type"];
    breed = data["breed"];
  }
}
