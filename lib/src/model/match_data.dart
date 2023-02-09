import 'dart:convert';

MatchData matchDataFromJson(String str) => MatchData.fromJson(json.decode(str));

class MatchData {
  MatchData({
    this.result,
  });

  Result? result;

  factory MatchData.fromJson(Map<String, dynamic> json) => MatchData(
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
    };
}

class Result {
  Result({
    this.founder,
    this.image,
    this.specific,
    this.date,
    this.lat,
    this.lng,
    this.description,
    this.type,
    this.breed
  });

  int? founder;
  String? image;
  String? specific;
  String? date;
  String? lat;
  String? lng;
  String? description;
  String? type;
  String? breed;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        founder: json["founder"],
        image : json["image"],
        specific: json["specific"],
        date: json["date"],
        lat: json["lat"],
        lng: json["lng"],
        description: json["description"],
        type: json["type"],
        breed: json["breed"],
      );

  Map<String, dynamic> toJson() => {
        "founder": founder,
        "image": image,
        "specific": specific,
        "date": date,
        "lat": lat,
        "lng":lng,
        "description": description,
        "type": type,
        "breed" : breed
      };
}
