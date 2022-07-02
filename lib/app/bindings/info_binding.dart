import 'package:get/get.dart';
import './../../app/controllers/info_controller.dart';

class InfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InfoController());
  }
}
