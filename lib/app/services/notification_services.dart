import 'package:get_storage/get_storage.dart';
import 'package:ykapay/utils/http_service.dart';

class NotificationService extends HttpService {
  GetStorage box = GetStorage();
  Future news() async {
    final res = await fetch(
      url: '/new.php',
      method: GET,
    );

    if ([res.isConnectError, res.isResponseError].contains(true)) {
      return null;
    } else {
      return res.body;
    }
  }
}
