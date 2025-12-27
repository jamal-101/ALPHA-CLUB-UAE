import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  RxSet<int> likeIndexes = <int>{}.obs;
  var baseLikeCount = 567;

  void toggleLike(int index) {
    if (likeIndexes.contains(index)) {
      likeIndexes.remove(index);
    } else {
      likeIndexes.add(index);
    }
  }

  bool isLiked(int index) {
    return likeIndexes.contains(index);
  }
}