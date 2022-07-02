import 'package:get/get.dart';
import './../../app/controllers/charge_controller.dart';

class ChargeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ChargeController());
  }
}
