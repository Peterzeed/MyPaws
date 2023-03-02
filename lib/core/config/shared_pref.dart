import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPreferenceKey {
  static const userId = "uid";
  static const userName = "username";
  static const userLastname = "userlastname";
  // static const petBreed = "";
  static const useremail = "useremail";
  static const breed = "breed";
  static const petPic = "petpic";
  static const userphone = "phone";
  static const userPic = "userpic";
  static File? image;

  static Future<void> clearAll() async{
    const prefs = FlutterSecureStorage();
    print("Token before logout : ${await prefs.read(key : SharedPreferenceKey.userId)}");
    await prefs.deleteAll();
  }
}