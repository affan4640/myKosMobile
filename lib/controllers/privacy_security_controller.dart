import 'package:get/get.dart';

class PrivacySecurityController extends GetxController {
  var isBiometricEnabled = false.obs;
  var isAppLockEnabled = false.obs;

  void toggleBiometric(bool value) => isBiometricEnabled.value = value;

  void toggleAppLock(bool value) => isAppLockEnabled.value = value;
}
