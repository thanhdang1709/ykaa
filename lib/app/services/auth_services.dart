import 'package:get_storage/get_storage.dart';
import 'package:ykapay/utils/http_service.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ykapay/utils/utils.dart';

class AuthService extends HttpService {
  GetStorage box = GetStorage();
  Future login({
    Map<String, dynamic> data,
  }) async {
    final res = await fetch(
      url: '/Login.php',
      method: POST,
      body: {
        'account': data['username'],
        'password': data['password'],
        'pwMD5':
            md5.convert(utf8.encode(data['password'] + 'youngerx')).toString(),
      },
    );

    if ([res.isConnectError, res.isResponseError].contains(true)) {
      return null;
    } else {
      return res.body;
    }
  }

  Future register({
    Map<String, dynamic> data,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final res = await fetch(
      url: '/Regis.php',
      method: POST,
      body: {
        "account": data['account'],
        "password": data['password'],
        "repassword": data['repassword'],
        "key": box.read('androidId'),
        "token": generateTokenMd5(timestamp),
        "timestamp": timestamp,
      },
    );
    if ([res.isConnectError, res.isResponseError].contains(true)) {
      return null;
    } else {
      return res.body;
    }
  }

  Future info({
    Map<String, dynamic> data,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final res = await fetch(
      url: '/Info.php',
      method: POST,
      body: {
        "account": data['account'],
        "password": data['password'],
        "repassword": data['repassword'],
        "key": box.read('androidId'),
        "token": generateTokenMd5(timestamp),
        "timestamp": timestamp,
      },
    );
    if ([res.isConnectError, res.isResponseError].contains(true)) {
      return null;
    } else {
      return res.body;
    }
  }

  Future<bool> refreshInfo() async {
    Map<String, String> data = {
      'username': box.read('account'),
      'password': box.read('password')
    };
    var response = await AuthService().login(data: data);
    if (response != null && response['error'] == 0) {
      box.write('account', box.read('account'));
      box.write('password', box.read('password'));
      box.write('money', response['money']);
      box.write('atm', response['atm']);
      box.write('momo', response['momo']);
      box.write('zalo', response['zalo']);
      // box.writeInMemory('accountMemory', box.read('account'));
      return true;
    } else {
      return false;
    }
  }
}
