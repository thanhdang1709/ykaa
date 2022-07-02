import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ykapay/app/controllers/notification_controller.dart';
import 'package:ykapay/config/palette.dart';
import 'package:ykapay/utils/common.dart';
import 'package:ykapay/utils/fade_in.dart';
import 'package:ykapay/utils/smart_refresher_success.dart';
import './../../../app/controllers/charge_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    NotificationController controller = Get.put(NotificationController());
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: SmartRefresherSuccess(
          message: 'common.reload_success'.tr,
        ),
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        child: SingleChildScrollView(
          child: Obx(
            () => controller.isLoading.value
                ? Center(
                    child: CupertinoActivityIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      FadeIn(
                        delay: 0.3,
                        child: Row(
                          children: [
                            Text(
                              'Thông báo từ YKAPAY:',
                              style: Palette.textStyle().copyWith(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      ...listItem(listData: controller.posts),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  List<Widget> listItem({listData}) {
    List<Widget> lists = [];
    int index = 1;
    listData.forEach((e) => {
          lists.add(FadeIn(
            delay: index * .1 + .3,
            child: ItemChargeContainer(
              content: e,
            ),
          )),
          index++
        });
    return lists;
  }
}

class ItemChargeContainer extends StatelessWidget {
  const ItemChargeContainer({
    Key key,
    this.gradient,
    this.content = '',
  }) : super(key: key);
  final String content;
  final List<Color> gradient;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 5, left: 5),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.green.shade500,
        gradient: new LinearGradient(
            colors: gradient ??
                [
                  Color(0xFF2193b0),
                  Color(0xFF6dd5ed),
                ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 3,
            offset: Offset(4, 6), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  content,
                  style: Palette.textStyle().copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
