import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String urlPic;
  final String email;
  final String name;
  final String lastname;
  final String userid;
  final String phone;

  UserModel(
      {
      this.id,  
      required this.urlPic,
      required this.email,
      required this.name,
      required this.lastname,
      required this.phone,
      required this.userid});

  // UserModel.fromMapMap(DocumentSnapshot data) {
  //   email = data["email"];
  //   name = data["name"];
  //   lastname = data["lastname"];
  //   phone = data["phone"];
  //   userid = data["userid"];
  //   urlPic = data["urlpic"];
  // }

  toJson() {
    return {
      "urlpic": urlPic,
      "email": email,
      "name": name,
      "lastname": lastname,
      "phone": phone,
      "userid": userid
    };
  }

  //Map User fetch data from firebase to usermodel
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      urlPic: data["urlpic"],
      email: data["email"],
      name: data["name"],
      lastname: data["lastname"],
      phone: data["phone"],
      userid: data["userid"],
    );
  }

  // static fromMap(QueryDocumentSnapshot<Object?> item) {}

  // void bindStream(Stream<UserModel> readUserData) {}
}
