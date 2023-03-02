// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mypaws/src/model/match_model.dart';


// class FoundDataController extends GetxController{

//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//   late CollectionReference collectionReference;

//   String searchbreed = "".obs as String;

//   @override
//   void onInit() {
//     super.onInit();
//     collectionReference = firebaseFirestore.collection("foundpet");
//     petmatch.bindStream(readPetMatch());
//   }

//   Stream<List<PetMatchModel>> readPetMatch() =>
//       collectionReference.where("breed" , isEqualTo: "German_shepherd").snapshots().map((query) =>
//           query.docs.map((item) => PetMatchModel.fromMap(item)).toList());

//   RxList<PetMatchModel> petmatch= RxList<PetMatchModel>([]);

// }