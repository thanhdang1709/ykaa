import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ykapay/utils/get_tool/get_tool.dart';

class WithdrawController extends GetxController with GetTool {
  // handle here
  GetStorage box = GetStorage();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  RxInt balance = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    balance.value = int.tryParse(box.read('money'));
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController..refreshCompleted();
  }
}
