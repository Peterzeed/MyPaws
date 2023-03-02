import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/config/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mypaws/core/config/shared_pref.dart';
import 'package:mypaws/src/model/user_model.dart';
import 'package:mypaws/src/pages/login/login_page.dart';
import 'package:mypaws/src/pages/main/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController extends GetxController {
  void bypassLogin() {
    Get.offNamed(Routes.mainPage);
  }

  String? loginName;

  //AuthCOntroller.instance...
  static AuthController get instance => Get.find();

  late final Rx<User?> user;
  //email,password,name..

  var uid;

  final _prefs = const FlutterSecureStorage();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    //our user would be notifield
    user.bindStream(auth.userChanges());
    ever(user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("Login Page");
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => MainPage(title: "Main Page", email: user.email!));
    }
  }

  Future<void> register(
      String urlpic, email, password, name, lastname, phone) async {
    // final _prefs = await SharedPreferences.getInstance();
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        var uid = auth.currentUser!.uid;

        await _prefs.write(key: SharedPreferenceKey.userId, value: uid);

        // CollectionReference reference =
        //     FirebaseFirestore.instance.collection("Users");

        final user = UserModel(
          urlPic: urlpic,
          email: email,
          name: name,
          lastname: lastname,
          phone: phone,
          userid: uid,
        );

        AuthController.instance.createUser(user);
        await _getUserName(auth.currentUser!.uid);
        // print(await _prefs.read(key: SharedPreferenceKey.userId));
        // reference.doc(uid).set(userData).then(
        //   (value) async{
        //    await _getUserName(auth.currentUser!.uid);
        //   },
        // );
      });
    } catch (e) {
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Account Creation Failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  Future<void> login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      uid = auth.currentUser!.uid;

      await _prefs.write(key: SharedPreferenceKey.userId, value: uid);

      print(await _prefs.read(key: SharedPreferenceKey.userId));

      await _getUserName(auth.currentUser!.uid);
    } catch (e) {
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Login Failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  Future<void> _getUserName(uid) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) async {
      // setState(() {
      //   _userName = value.data['UserName'].toString();
      // });

      var username = value.data()?['name'];
      var userlastname = value.data()?['lastname'];
      var userphone = value.data()?['phone'];
      var userprofile = value.data()?['urlpic'];

      await _prefs.write(key: SharedPreferenceKey.userName, value: username);
      await _prefs.write(
          key: SharedPreferenceKey.userLastname, value: userlastname);
      await _prefs.write(key: SharedPreferenceKey.userphone, value: userphone);
      await _prefs.write(key: SharedPreferenceKey.userPic, value: userprofile);
      print("name here : ${username}");
    });
  }

  Future<void> logOut() async {
    await auth.signOut();
    await SharedPreferenceKey.clearAll();
  }

  createUser(UserModel user) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .set(user.toJson())
        .whenComplete(() => Get.snackbar(
            "Success", "Your account has been Created.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black54,
            colorText: Colors.green))
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.red);
    });
    Get.toNamed(Routes.mainPage);
  }
}
