import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/config/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mypaws/core/config/shared_pref.dart';
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
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  //email,password,name..

  final _prefs = const FlutterSecureStorage();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //our user would be notifield
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("Login Page");
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => MainPage(title: "Main Page", email: user.email!));
    }
  }

  void register(String email, password, name, lastname, phone) async {
    // final _prefs = await SharedPreferences.getInstance();
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        var uid = auth.currentUser!.uid;

        await _prefs.write(key: SharedPreferenceKey.userId, value: uid);

        CollectionReference reference =
            FirebaseFirestore.instance.collection("Users");

        Map<String, String> userData = {
          "userid": uid,
          "First Name": name,
          "Last Name": lastname,
          "Email": email,
          "phone": phone
        };
        print(await _prefs.read(key: SharedPreferenceKey.userId));
        reference.add(userData).then((value) => Get.offAll(MainPage(
              email: email,
              title: '',
            )));
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

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      var uid = auth.currentUser!.uid;

      await _prefs.write(key: SharedPreferenceKey.userId, value: uid);
      print(await _prefs.read(key: SharedPreferenceKey.userId));
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

  void logOut() async {
    await auth.signOut();
  }
}
