import 'package:get/get.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  final searchQuery = ''.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  void openSearchTab({String? query}) {
    searchQuery.value = (query ?? '').trim();
    currentIndex.value = 1;
  }
}
