import 'package:get/get.dart';
import 'package:mypaws/core/config/shared_pref.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener.dart';
import 'package:mypaws/core/lifecycle/lifecycle_listener_event.dart';
import 'package:mypaws/src/model/boomark_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mypaws/src/model/match_profile_model.dart';

class AddBookmartController extends GetxController with LifecycleListenerEvent{
  
  

  // List<BookmarkItem> bookmarkList = [];

  // int get chatTotal => bookmarkList.length;

  // void addBookmark(BookmarkItem bookmarkItem) {
  //   final bookmarkItemList = bookmarkList.firstWhereOrNull((element) =>
  //       element.matchdata.founder == bookmarkItem.matchdata.founder);
  //   if (bookmarkItemList != null) {
  //     bookmarkItemList.quantity += 1;
  //     update();
  //   } else {
  //     bookmarkList.add(bookmarkItem);
  //     update();
  //   }
  //   update();
  // }

  @override
  void onInit() async {
    
    // _getMatchItem();
    super.onInit();
  }

  

}
