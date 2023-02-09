class MatchPet {
  int id;
  String image;
  String specific;
  String date;
  String lat;
  String lng;
  String description;
  String type;
  String breed;
  bool isSelected;
  MatchPet({
    required this.id,
    required this.image,
    required this.specific,
    required this.date,
    required this.lat,
    required this.lng,
    required this.description,
    required this.type,
    required this.breed,
    this.isSelected = false,
  });
}
