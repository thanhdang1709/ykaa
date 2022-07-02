import 'package:get/get.dart';
import './../../app/controllers/history_controller.dart';

class HistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HistoryController());
  }
}
