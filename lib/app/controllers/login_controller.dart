import 'package:flutter/cupertino.dart';
import 'package:ykapay/utils/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ykapay/app/services/auth_services.dart';

class LoginController extends GetxController with GetTool {
  // handle here
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isValidateUsername = false.obs;
  RxBool isValidatePassword = false.obs;
  RxBool isEnableSubmit = false.obs;
  RxBool isSubmitting = false.obs;
  GetStorage box = GetStorage();

  formValidate() {
    if (isValidateUsername.value && isValidatePassword.value) {
      isEnableSubmit.value = true;
      return true;
    }
    isEnableSubmit.value = false;
    return false;
  }

  handleLogin() async {
    isSubmitting.value = true;
    isEnableSubmit.value = false;
    if (isValidateUsername.value && isValidatePassword.value) {
      Map<String, String> data = {
        'username': usernameController.text.trim(),
        'password': passwordController.text,
      };
      var response = await AuthService().login(data: data);
      //print(response);
      if (response != null && response['error'] == 0) {
        isSubmitting.value = false;
        isEnableSubmit.value = true;
        Get.back();
        Get.offAllNamed('home');
        box.write('account', usernameController.text.trim());
        box.write('password', passwordController.text);
        box.write('money', response['money']);
        box.write('atm', response['atm']);
        box.write('momo', response['momo']);
        box.write('zalo', response['zalo']);
        // box.writeInMemory('accountMemory', usernameController.text);
        notify.success(message: response['msg'], title: 'Thành công');
      } else {
        Get.back();
        isSubmitting.value = false;
        isEnableSubmit.value = true;
        notify.error(message: response['msg'], title: 'Thất bại');
      }
    }
  }
}
