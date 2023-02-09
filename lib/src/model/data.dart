import 'pet_match.dart';

class AppData {
  static List<MatchPet> matchList = [
    MatchPet(
        id: 1,
        image: "assets/dog3.jpg",
        specific: "brown",
        date: "2023-02-01 00:00:00.000",
        lat: "13.989614507064365",
        lng: "100.62079969793558",
        description: "description",
        type: "dog",
        breed : "German_shepherd",
        ),
        MatchPet(
        id: 2,
        image: "assets/dog4.jpg",
        specific: "brown",
        date: "2023-02-01 00:00:00.000",
        lat: "13.989614507064365",
        lng: "100.62079969793558",
        description: "description",
        type: "dog",
        breed : "pitbull",
        ),
        MatchPet(
        id: 3,
        image: "assets/dog5.jpg",
        specific: "brown",
        date: "2023-02-01 00:00:00.000",
        lat: "13.989614507064365",
        lng: "100.62079969793558",
        description: "description",
        type: "dog",
        breed : "pitbull",
        ),
        MatchPet(
        id: 4,
        image: "assets/dog6.jpg",
        specific: "brown",
        date: "2023-02-01 00:00:00.000",
        lat: "13.989614507064365",
        lng: "100.62079969793558",
        description: "description",
        type: "dog",
        breed : "German_shepherd",
        ),
  ];

  static Future<List<MatchPet>> simulateFetchingMatch(){
    return Future.delayed(const Duration(seconds: 3), (){
      return matchList;
    });
  }
}
