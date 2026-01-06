import 'package:get/get.dart';


class OfferController extends GetxController{

  RxSet<int> offerIndexes = <int>{}.obs;

  bool isOffer(int index) {
    return offerIndexes.contains(index);
  }


  void toggleLove(int index) {
    if (offerIndexes.contains(index)) {
      offerIndexes.remove(index);
    } else {
      offerIndexes.add(index);
    }
  }





}