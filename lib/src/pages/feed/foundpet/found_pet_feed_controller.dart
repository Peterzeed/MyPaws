import 'package:get/get.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener_event.dart';
import 'package:mypaws/src/model/match_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FoundPetFeedController extends GetxController with LifecycleListenerEvent {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late LifecycleListener _lifecycleListener;

  late CollectionReference collectionReference;

  @override
  void onInit() async{
    _lifecycleListener = LifecycleListener(providerInstance: this);
   
    collectionReference = firebaseFirestore.collection("foundpet");
    myfoundpet.bindStream(readPetFound());
    super.onInit();
  }


  Stream<List<PetMatchModel>> readPetFound() => collectionReference
      .snapshots()
      .map((query) =>
          query.docs.map((item) => PetMatchModel.fromMap(item)).toList());

  RxList<PetMatchModel> myfoundpet = RxList<PetMatchModel>([]);

}