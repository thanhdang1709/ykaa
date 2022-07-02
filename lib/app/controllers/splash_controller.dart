import 'package:device_info/device_info.dart';
import 'package:ykapay/utils/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ykapay/app/services/auth_services.dart';

class SplashController extends GetxController with GetTool {
  GetStorage box = GetStorage();
  @override
  void onInit() async {
    print(box.read('androidId'));
    if (!box.hasData('androidId')) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      box.write('androidId', androidInfo.androidId);
    }

    if (!box.hasData('account')) {
      await Future.delayed(Duration(seconds: 2), () {
        Get.offAllNamed('login');
      });
    } else {
      var res = await AuthService().refreshInfo();
      if (res) {
        await Future.delayed(Duration(seconds: 1), () {
          Get.offAllNamed('home');
        });
        return;
      }
      await Future.delayed(Duration(seconds: 1), () {
        Get.offAllNamed('login');
      });
    }
    super.onInit();
  }
}
