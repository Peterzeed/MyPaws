import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypaws/core/config/shared_pref.dart';
import 'package:mypaws/src/model/match_profile_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LostPetChatController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  final _prefs = const FlutterSecureStorage();

  String? userId;

  @override
  void onInit() async {
    userId = await _prefs.read(key: SharedPreferenceKey.userId);
    // _receiveArguments();
    super.onInit();
  }

  @override
  void onReady() {
    collectionReference = firebaseFirestore.collection("matchdata");
    // getMatchItem();
    matchitem.bindStream(getMatchItem());
    super.onReady();
  }

  Stream<List<MatchItemModel>> getMatchItem() => collectionReference
      .where('finderid', isEqualTo: userId)
      .snapshots()
      .map((query) =>
          query.docs.map((item) => MatchItemModel.fromMap(item)).toList());

  RxList<MatchItemModel> matchitem = RxList<MatchItemModel>([]);
}
