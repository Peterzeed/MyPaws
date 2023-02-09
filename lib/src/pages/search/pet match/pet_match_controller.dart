import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener_event.dart';
import 'package:mypaws/src/model/data.dart';
import 'package:mypaws/src/model/match_data.dart';
import 'package:mypaws/src/model/match_model.dart';
import 'package:mypaws/src/model/pet_match.dart';
import 'package:dio/dio.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PetMatchController extends GetxController with LifecycleListenerEvent {
  late LifecycleListener? _lifecycleListener;

  List<MatchPet> matchList = [];

  List<MatchPet> _originalMatchList = [];

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore.collection("foundpet");
    petmatch.bindStream(readPetMatch());
  }

  @override
  void onReady() {
    // _lifecycleListener.dispose();
    // _fetchMatchPet();
    super.onReady();
  }

  var counter = 0.obs;
  var counter2 = 0.obs;

  @override
  void onClose() {
    _lifecycleListener!.dispose();
    super.onClose();
  }

  @override
  void onResume() {
    super.onResume();
  }

  void _fetchMatchPet() async {
    showDialog<void>(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: WillPopScope(
              child: Row(
                children: [
                  const CircularProgressIndicator(),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: const Text("Loading.."),
                  )
                ],
              ),
              onWillPop: () {
                return Future.value(false);
              },
            ),
          );
        });

    // final response = await Future.wait(
    //   [
    //     AppData.simulateFetchingMatch(),
    //   ],
    // );
    // // categoryList = response[0] as List<Category>;
    // _originalMatchList = response[0];
    // matchList = _originalMatchList.toList();

    // Navigator.of(Get.overlayContext!).pop();

    update();
  }

  Stream<List<PetMatchModel>> readPetMatch() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => PetMatchModel.fromMap(item)).toList());

  RxList<PetMatchModel> petmatch= RxList<PetMatchModel>([]);
}
