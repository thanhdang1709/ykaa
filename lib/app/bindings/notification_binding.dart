import 'package:get/get.dart';
import './../../app/controllers/notification_controller.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
  }
}
