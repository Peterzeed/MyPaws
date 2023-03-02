import 'package:get/get.dart';
import 'package:mypaws/core/config/shared_pref.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mypaws/src/model/match_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';


class FoundPetPageController extends GetxController
    with LifecycleListenerEvent {
  late LifecycleListener _lifecycleListener;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  final _prefs = const FlutterSecureStorage();

  String? myFounderid;

  @override
  void onReady() {
    collectionReference = firebaseFirestore.collection("foundpet");
    myfoundpet.bindStream(readFoundPet());
    super.onReady();
  }

  @override
  void onInit() async{
    _lifecycleListener = LifecycleListener(providerInstance: this);
    myFounderid = await _prefs.read(key: SharedPreferenceKey.userId);
    super.onInit();
  }

  @override
  void onClose() {
    _lifecycleListener.dispose();
    super.onClose();
  }

  // @override
  // void onResume() {
  //   super.onResume();
  // }


  Stream<List<PetMatchModel>> readFoundPet() => collectionReference
      .where("founder", isEqualTo: myFounderid)
      .snapshots()
      .map((query) =>
          query.docs.map((item) => PetMatchModel.fromMap(item)).toList());

  RxList<PetMatchModel> myfoundpet = RxList<PetMatchModel>([]);

  
}
