import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ykapay/config/palette.dart';
import 'package:ykapay/utils/fade_in.dart';
import 'package:ykapay/utils/number.dart';
import 'package:ykapay/utils/smart_refresher_success.dart';
import './../../../app/controllers/charge_controller.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends GetView<ChargeController> {
  @override
  Widget build(BuildContext context) {
    ChargeController controller = Get.put(ChargeController());
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
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              FadeIn(
                delay: 0.3,
                child: Row(
                  children: [
                    Text(
                      'Lịch sử giao dịch:',
                      style: Palette.textStyle().copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FadeIn(
                delay: 0.4,
                child: Row(
                  children: [
                    Text(
                      'Tính năng đang cập nhật',
                      style: Palette.textStyle().copyWith(
                        fontSize: 20,
                        color: Palette.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              ...listItem(listData: [
                {'value': 0, 'prefix': '-'},
                {'value': 0, 'prefix': '+'}
              ]),
              SizedBox(
                height: 20,
              ),
            ],
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
              balance: e['value'] * 1000,
              prefix: e['prefix'],
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
    this.balance = 0,
    this.prefix = '+',
  }) : super(key: key);
  final int balance;
  final List<Color> gradient;
  final String prefix;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 5, left: 5),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.green.shade500,
        gradient: new LinearGradient(
            colors: prefix == '+'
                ? [
                    Color(0xFF2193b0),
                    Color(0xFF6dd5ed),
                  ]
                : [
                    Color(0xFFFF416C),
                    Color(0xFFFF4B2B),
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
            children: [
              Image.asset(
                'assets/icon/cash.png',
                height: 50,
                width: 50,
                color: Colors.white,
              ),
              Spacer(),
              Text(
                "$prefix${$Number.numberFormat(balance)}",
                style: Palette.textStyle().copyWith(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "  Ycoin",
                style: Palette.textStyle().copyWith(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Spacer(),
              Text(
                "${DateFormat('dd-MM-yyyy - hh:mm').format(DateTime.now())}",
                style: Palette.textStyle().copyWith(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
