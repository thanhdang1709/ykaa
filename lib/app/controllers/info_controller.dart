import 'package:flutter/cupertino.dart';
import 'package:ykapay/utils/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InfoController extends GetxController with GetTool {
  GetStorage box = GetStorage();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController accountController = TextEditingController();
  TextEditingController atmController = TextEditingController();
  TextEditingController momoController = TextEditingController();
  TextEditingController zaloController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController rePwController = TextEditingController();
  String version = "1.4.0";
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    accountController.text = box.read('account');
    atmController.text = box.read('atm');
    momoController.text = box.read('momo');
    zaloController.text = box.read('zalo');
    pwController.text = box.read('password');
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController..refreshCompleted();
  }
}
