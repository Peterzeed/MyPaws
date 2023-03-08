import 'package:get/get.dart';
import 'package:mypaws/core/config/shared_pref.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener_event.dart';
import 'package:mypaws/src/model/match_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class PetMatchController extends GetxController with LifecycleListenerEvent {
  late LifecycleListener? _lifecycleListener;

  var isBookMarkAdd = false.obs;

  bool clicked = false;

  getCurrentDate() {
    return DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  }

  // final RxInt _petBreed = RxInt(0);

  final _prefs = const FlutterSecureStorage();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  String? petBreed, owner , username , userlastname , userphone , userprofile , findpetid;

  @override
  void onInit() async {
    _lifecycleListener = LifecycleListener(providerInstance: this);

    petBreed = await _prefs.read(key: SharedPreferenceKey.breed);
    owner = await _prefs.read(key: SharedPreferenceKey.userId);
    username = await _prefs.read(key: SharedPreferenceKey.userName);
    userlastname= await _prefs.read(key: SharedPreferenceKey.userLastname);
    userphone = await _prefs.read(key: SharedPreferenceKey.userphone);
    userprofile= await _prefs.read(key: SharedPreferenceKey.userPic);
    findpetid = await _prefs.read(key: SharedPreferenceKey.docid);
    super.onInit();
    // Map<String, dynamic> args = Get.arguments;
    // _petBreed.value = args['petBreed'];
  }

  @override
  void onReady() {
    print("PetBreed : $petBreed");
    collectionReference = firebaseFirestore.collection("foundpet");
    petmatch.bindStream(readPetMatch());
    super.onReady();
  }

  var counter = 0.obs;
  var counter2 = 0.obs;

  @override
  void onClose() async {
    _lifecycleListener!.dispose();
    const prefs = FlutterSecureStorage();
    print(
        "PetBreed before Back : ${await prefs.read(key: SharedPreferenceKey.breed)}");
    await prefs.delete(key: petBreed!);
    super.onClose();
  }

  @override
  void onResume() {
    super.onResume();
  }

  Stream<List<PetMatchModel>> readPetMatch() => collectionReference
      .where("breed", isEqualTo: petBreed)
      .where("founder", isNotEqualTo: owner)
      .where("ismypaws" , isEqualTo: "finding")
      .snapshots()
      .map((query) =>
          query.docs.map((item) => PetMatchModel.fromMap(item)).toList());

  RxList<PetMatchModel> petmatch = RxList<PetMatchModel>([]);

  // List<PetMatchModel> get petmatchmodel => petmatch.value;

  void setSelected(PetMatchModel item) {
    item.isBookMarkAdd = !item.isBookMarkAdd;
    update();
  }
}
