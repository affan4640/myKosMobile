import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  var isNotificationEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    isNotificationEnabled.value = prefs.getBool('isNotification') ?? true;
  }

  Future<void> toggleNotification(bool value) async {
    isNotificationEnabled.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isNotification', value);
  }
}
