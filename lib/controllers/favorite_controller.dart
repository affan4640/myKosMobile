import 'package:get/get.dart';
import '../models/kost_model.dart';

class FavoriteController extends GetxController {
  var favorites = <Kost>[].obs;
  var selectedSort = 'Terbaru'.obs;

  // Menyimpan urutan asli sebelum diurutkan untuk fitur "Terbaru"
  List<Kost> _originalFavorites = [];

  @override
  void onInit() {
    super.onInit();
    // Simulasi memuat data favorit dari model (mockKosts)
    _originalFavorites = List.from(mockKosts);
    favorites.assignAll(_originalFavorites);
  }

  void removeFavorite(String id) {
    favorites.removeWhere((item) => item.id == id);
    _originalFavorites.removeWhere((item) => item.id == id);
  }

  void sortFavorites(String sortType) {
    selectedSort.value = sortType;
    if (sortType == 'Terbaru') {
      favorites.assignAll(_originalFavorites);
    } else if (sortType == 'Termurah') {
      var sortedList = List<Kost>.from(favorites);
      sortedList.sort((a, b) => a.price.compareTo(b.price));
      favorites.assignAll(sortedList);
    }
  }
}
