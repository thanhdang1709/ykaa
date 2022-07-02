import 'package:flutter/material.dart';
import 'package:ykapay/utils/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:ykapay/app/services/auth_services.dart';
import 'package:ykapay/utils/common.dart';

class RegisterController extends GetxController with GetTool {
  // handle here
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  RxBool isValidateUsername = false.obs;
  RxBool isValidatePassword = false.obs;
  RxBool isValidateRepassword = false.obs;
  RxBool isEnableSubmit = false.obs;
  RxBool isSubmitting = false.obs;
  RxString errorString = ''.obs;

  formValidate() {
    if (isValidateUsername.value &&
        isValidatePassword.value &&
        isValidateRepassword.value) {
      if (passwordController.text != rePasswordController.text) {
        errorString.value = 'login_confirm_password_wrong'.tr;
        return;
      } else {
        errorString.value = '';
      }
      isEnableSubmit.value = true;
      return true;
    }
    isEnableSubmit.value = false;
    return false;
  }

  handleRegister() async {
    isSubmitting.value = true;
    isEnableSubmit.value = false;
    CommonWidget.progressIndicator();
    if (isValidateUsername.value && isValidatePassword.value) {
      Map<String, String> data = {
        'account': usernameController.text.trim(),
        'password': passwordController.text,
        'repassword': rePasswordController.text,
      };
      var response = await AuthService().register(data: data);
      if (response != null && response['error'] == 0) {
        isSubmitting.value = false;
        isEnableSubmit.value = true;
        Get.back();
        Get.offAllNamed('login');
        notify.success(message: response['msg'], title: 'Thành công');
      } else {
        isSubmitting.value = false;
        isEnableSubmit.value = true;
        Get.back();
        notify.error(message: response['msg'], title: 'Thất bại');
      }
    }
  }
}
