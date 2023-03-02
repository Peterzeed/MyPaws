import 'package:mypaws/src/model/match_data.dart';
import 'package:mypaws/src/model/match_model.dart';

class BookmarkItem {
  PetMatchModel matchdata;
  int quantity;
  BookmarkItem(this.matchdata,{this.quantity = 1});
}
