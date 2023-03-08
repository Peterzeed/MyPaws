import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener_event.dart';
import 'package:mypaws/src/model/lost_pet_model.dart';

class LostPetController extends GetxController with LifecycleListenerEvent {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late LifecycleListener _lifecycleListener;

  late CollectionReference collectionReference;

  @override
  void onInit() async {
    _lifecycleListener = LifecycleListener(providerInstance: this);

    collectionReference = firebaseFirestore.collection("findpet");
    mylostpet.bindStream(readPetLost());
    super.onInit();
  }

  Stream<List<LostPetModel>> readPetLost() => collectionReference
      .where('ismypaws', isEqualTo: "finding")
      .snapshots()
      .map((query) =>
          query.docs.map((item) => LostPetModel.fromMap(item)).toList());

  RxList<LostPetModel> mylostpet = RxList<LostPetModel>([]);
}
