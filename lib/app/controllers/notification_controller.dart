import 'package:ykapay/utils/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ykapay/app/services/notification_services.dart';

class NotificationController extends GetxController with GetTool {
  // handle here
  RxList posts = [].obs;
  RxBool isLoading = true.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    await getPosts();
    refreshController..refreshCompleted();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getPosts();
    isLoading.value = false;
  }

  Future getPosts() async {
    var res = await NotificationService().news();
    print(res);
    if (res != null) {
      List<String> post = List.from([res]);
      posts.assignAll(post);
    }
  }
}
