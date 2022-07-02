import 'package:get_storage/get_storage.dart';
import 'package:ykapay/utils/http_service.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ykapay/utils/utils.dart';

class BalanceService extends HttpService {
  GetStorage box = GetStorage();
  Future addMoney({
    Map<String, dynamic> data,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final res = await fetch(
      url: '/AddMoney.php',
      method: POST,
      body: {
        'account': box.read('account') ?? '',
        'password': box.read('password') ?? '',
        'pwMD5': md5
            .convert(utf8.encode(box.read('password') + 'youngerx'))
            .toString(),
        "token": generateTokenMd5(timestamp),
        "timestamp": timestamp,
        "key": box.read('androidId') ?? '',
        'phone': '0339888746',
        'bank': data['purchaseId'],
        'money': data['money'],
      },
    );

    if ([res.isConnectError, res.isResponseError].contains(true)) {
      return null;
    } else {
      return res.body;
    }
  }

  Future<List<String>> getProducts() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final res = await fetch(
      url: '/API/SanPham.txt',
      method: GET,
    );

    if ([res.isConnectError, res.isResponseError].contains(true)) {
      return null;
    } else {
      return (res.body.toString().replaceAll('\n', '|')).split('|');
    }
  }
}



  // Future<void> getProductIds() async {
  //   Response response = await http
  //       .get(Uri.parse('https://ykapay.khanhlinh.pro/API/SanPham.txt'));
  //   listProduct = (response.body.toString().replaceAll('\n', '|')).split('|');
  // }
