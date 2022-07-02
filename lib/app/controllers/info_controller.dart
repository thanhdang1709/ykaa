import 'package:flutter/cupertino.dart';
import 'package:ykapay/app/services/auth_services.dart';
import 'package:ykapay/utils/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InfoController extends GetxController with GetTool {
  GetStorage box = GetStorage();
  RefreshController refreshController = RefreshController(initialRefresh: false);
  TextEditingController accountController = TextEditingController();
  TextEditingController atmController = TextEditingController();
  TextEditingController momoController = TextEditingController();
  TextEditingController zaloController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController rePwController = TextEditingController();

  RxBool isValidateATM = false.obs;
  RxBool isValidateMoMo = false.obs;
  RxBool isValidateZaloPay = false.obs;
  RxBool isEnableSubmit = false.obs;
  RxBool isSubmitting = false.obs;

  String version = "1.4.0";
  @override
  void onInit() async {
    super.onInit();
    accountController.text = box.read('account');
    atmController.text = box.read('atm');
    momoController.text = box.read('momo');
    zaloController.text = box.read('zalo');
    pwController.text = box.read('password');
  }

  formValidate() {
    if (isValidateATM.value && isValidateMoMo.value && isValidateZaloPay.value) {
      isEnableSubmit.value = true;
      return true;
    }
    isEnableSubmit.value = false;
    return false;
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController..refreshCompleted();
  }

  Future submitButton() async {
    isSubmitting.value = true;
    isEnableSubmit.value = false;
    Map<String, String> data = {
      'atm': atmController.text.trim(),
      'momo': momoController.text.trim(),
      'zalo': zaloController.text.trim(),
    };
    var response = await AuthService().updateInfo(data: data);
    if (response != null && response['error'] == 0) {
      isSubmitting.value = false;
      isEnableSubmit.value = true;
      notify.success(message: response['msg'], title: 'Thành công');
    } else {
      Get.back();
      isSubmitting.value = false;
      isEnableSubmit.value = true;
      notify.error(message: response['msg'], title: 'Thất bại');
    }
  }
}
