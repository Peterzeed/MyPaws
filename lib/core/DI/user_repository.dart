import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypaws/core/DI/auth_controller.dart';
import 'package:mypaws/core/config/shared_pref.dart';
import 'package:mypaws/src/model/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository extends GetxController{

  var username,userlastname,useremail;

  static UserRepository get instance => Get.find();
  
  final _authRepo = Get.put(AuthController());
  
  final _db = FirebaseFirestore.instance;

  final _prefs = const FlutterSecureStorage();

  @override
  void onInit()async{
    
    // final userId = await _prefs.read(key: SharedPreferenceKey.userId);
    getUserData();
    super.onInit();
  }

  Future<UserModel> getUserDetail(String email) async{
    final snapshot = await _db.collection("Users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e)=> UserModel.fromSnapshot(e)).single;
    return userData;
  }

  
  getUserData()async{
    final email = _authRepo.auth.currentUser!.uid;
    if(email != null){
      return getUserName(email);
    }else{
      Get.snackbar("Error", "Login to continue");
    }
  }


  Future<void> getUserName(email) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .get()
        .then((value) async {
      username = value.data()?['name'];
      userlastname = value.data()?['lastname'];
      useremail = value.data()?['email'];
      await _prefs.write(key: SharedPreferenceKey.userName, value: username);
      await _prefs.write(
          key: SharedPreferenceKey.userLastname, value: userlastname);
          await _prefs.write(
          key: SharedPreferenceKey.useremail, value:useremail);
      // print("name here : ${username}");
    });
  }
  
}