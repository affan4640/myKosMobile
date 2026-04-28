import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/theme_controller.dart';
import 'views/auth/splash_screen.dart';
import 'theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyKost',

          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: AppColors.primary,
            scaffoldBackgroundColor: AppColors.background,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),


          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: AppColors.primary,
            scaffoldBackgroundColor: const Color(0xFF121212),
            textTheme: GoogleFonts.poppinsTextTheme(
              ThemeData.dark().textTheme,
            ),
          ),


          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,

          home: const SplashScreen(),
        ));
  }
}