import 'package:get/get.dart';

class ProfileChangePasswordController extends GetxController {
  var showOldPassword = false.obs;
  var showNewPassword = false.obs;
  var showConfirmPassword = false.obs;

  void toggleOldPassword() => showOldPassword.value = !showOldPassword.value;
  void toggleNewPassword() => showNewPassword.value = !showNewPassword.value;
  void toggleConfirmPassword() =>
      showConfirmPassword.value = !showConfirmPassword.value;
}
