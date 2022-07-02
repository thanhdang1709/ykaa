import 'package:get/get.dart';
import './../../app/controllers/withdraw_controller.dart';

class WithdrawBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(WithdrawController(), permanent: true);
  }
}
