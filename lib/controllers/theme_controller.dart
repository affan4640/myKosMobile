import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  Future<void> toggleTheme(bool value) async {
    // Set explicitly from caller (avoid race conditions)
    isDarkMode.value = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode.value);

    // Apply immediately so other parts of the app update
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('isDarkMode') ?? false;
    isDarkMode.value = saved;

    // Ensure the app theme matches persisted value on startup
    Get.changeThemeMode(saved ? ThemeMode.dark : ThemeMode.light);
  }
}
