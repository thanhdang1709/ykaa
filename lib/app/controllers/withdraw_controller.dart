import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ykapay/app/services/balance_service.dart';
import 'package:ykapay/utils/get_tool/get_tool.dart';

class WithdrawController extends GetxController with GetTool {
  // handle here
  GetStorage box = GetStorage();
  RefreshController refreshController = RefreshController(initialRefresh: false);

  TextEditingController amountController = TextEditingController();

  RxInt balance = 0.obs;
  RxInt isStatus = 0.obs;
  RxString selectedPayment = ''.obs;
  RxBool isValidateAmount = false.obs;
  RxBool isEnableSubmit = false.obs;
  RxBool isSubmitting = false.obs;

  List<StatusModel> status = [
    StatusModel(id: 1, label: 'ATM', status: 0),
    StatusModel(id: 2, label: 'MoMo', status: 1),
    StatusModel(id: 3, label: 'ZaloPay', status: 2),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    balance.value = int.tryParse(box.read('money'));
  }

  formValidate() {
    if (isValidateAmount.value) {
      isEnableSubmit.value = true;
      return true;
    }
    isEnableSubmit.value = false;
    return false;
  }

  payment(id) async {
    var get = await status.firstWhere((element) => element.id == id);
    selectedPayment.value = get.label;
    print(selectedPayment.value);
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController..refreshCompleted();
    balance.value = int.tryParse(box.read('money'));
  }

  Future submitButton() async {
    isSubmitting.value = true;
    isEnableSubmit.value = false;
    Map<String, String> data = {
      'payment': selectedPayment.value.trim().toString(),
      'amount': amountController.text.trim().toString(),
    };
    var response = await BalanceService().withdraw(data: data);
    if (response != null && response['error'] == 0) {
      isEnableSubmit.value = true;
      notify.success(message: response['msg'], title: 'Thành công');
    } else {
      Get.back();
      isEnableSubmit.value = true;
      notify.error(message: response['msg'], title: 'Thất bại');
    }
    amountController.clear();
    isSubmitting.value = false;
  }
}

class StatusModel {
  int id;
  String label;
  int status;
  StatusModel({this.id, this.status, this.label});
}
