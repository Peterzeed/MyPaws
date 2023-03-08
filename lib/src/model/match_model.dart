import 'package:cloud_firestore/cloud_firestore.dart';

class PetMatchModel {
  String? id;
  late final String founder;
  late final String foundername;
  late final String founderphone;
  late final String date;
  late final String lat;
  late final String lng;
  late final String specific;
  late final String type;
  late final String description;
  late final String breed;
  late final String image;
  late final String ismypaws;
  bool isBookMarkAdd = false;

  PetMatchModel(
      {this.id,
      required this.founder,
      required this.image,
      required this.foundername,
      required this.founderphone,
      required this.specific,
      required this.date,
      required this.lat,
      required this.lng,
      required this.description,
      required this.type,
      required this.breed,
      required this.ismypaws,
      required this.isBookMarkAdd});

  PetMatchModel.fromMap(DocumentSnapshot data) {
    id = data.id;
    founder = data["founder"];
    foundername = data['foundername'];
    founderphone = data['founderphone'];
    image = data["image"];
    specific = data["specific"];
    date = data["date"];
    lat = data["lat"];
    lng = data["lng"];
    description = data["description"];
    type = data["type"];
    breed = data["breed"];
    ismypaws = data["ismypaws"];
    // isBookMarkAdd = data["isBookMarkAdd"];
  }

  factory PetMatchModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PetMatchModel(
        id: document.id,
        founder: data["founder"],
        foundername: data["foundername"],
        founderphone: data["founderphone"],
        image: data["image"],
        specific: data["specific"],
        date: data["date"],
        lat: data["lat"],
        lng: data["lng"],
        description: data["description"],
        type: data["type"],
        breed: data["breed"],
        ismypaws: data["ismypaws"],
        isBookMarkAdd: data["isBookMarkAdd"]);
  }
}
