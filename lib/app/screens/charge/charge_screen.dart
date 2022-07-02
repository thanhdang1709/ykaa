import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ykapay/config/palette.dart';
import 'package:ykapay/utils/fade_in.dart';
import 'package:ykapay/utils/number.dart';
import 'package:ykapay/utils/smart_refresher_success.dart';
import './../../../app/controllers/charge_controller.dart';

class ChargeScreen extends GetView<ChargeController> {
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
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeIn(
                  delay: 0.2,
                  child: Obx(() => BalanceContainer(
                        balance: controller.balance.value,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                FadeIn(
                  delay: 0.3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          'Chọn mệnh giá nạp tiền:',
                          style: Palette.textStyle().copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //...listItem(listData: [5000, 10000, 20000, 50000, 100000, 200000, 500000]),
                SizedBox(
                  height: 20,
                ),
                for (var prod in controller.products.toList()) ...[
                  FadeIn(
                    delay: 0.3,
                    child: ItemChargeContainer(
                        balance: prod.price,
                        gradient: [Color(0xFF1488CC), Color(0xFF2B32B2)],
                        onClick: () {
                          //controller.handleDeposit(5000);
                          controller.buyProduct(prod);
                        }),
                  ),
//                   Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
// // If you want to change description change it from google console in-app products section
//                           "${prod.description}",
//                           style: TextStyle(fontSize: 22, color: Colors.black54),
//                           textAlign: TextAlign.center,
//                         ),
//                         Text(
// // If you want to change price change it from google console in-app products section
//                           "${prod.price}",
//                           style: TextStyle(fontSize: 22, color: Colors.black54),
//                           textAlign: TextAlign.center,
//                         ),
//                         FlatButton(
//                           onPressed: () => controller.buyProduct(prod),
//                           child: Text('Mua'),
//                           color: Colors.green,
//                         ),
//                       ],
//                     ),
//                   ),
                ]
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
                balance: e,
                gradient: [Color(0xFF1488CC), Color(0xFF2B32B2)],
                onClick: () {
                  //controller.handleDeposit();
                }),
          )),
          index++
        });
    return lists;
  }
}

class BalanceContainer extends StatelessWidget {
  const BalanceContainer({Key key, this.balance = 0}) : super(key: key);
  final int balance;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 5, left: 5),
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.amber,
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF5433FF),
              const Color(0xFF20BDFF),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${'common.balance'.tr}: ",
                style: Palette.textStyle()
                    .copyWith(color: Colors.white, fontSize: 25),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "${$Number.numberFormat(balance)} Ycoin",
                style: Palette.textStyle().copyWith(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemChargeContainer extends StatelessWidget {
  const ItemChargeContainer({
    Key key,
    this.gradient,
    this.balance,
    this.onClick,
  }) : super(key: key);
  final String balance;
  final List<Color> gradient;
  final Function onClick;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.only(top: 20, right: 5, left: 5),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.green.shade500,
          gradient: new LinearGradient(
              colors: gradient ??
                  [
                    Color(0xFF3366FF),
                    Color(0xFF00CCFF),
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
                  //"${$Number.numberFormat(balance)}",
                  "${balance.substring(0, balance.length - 1)}",
                  style: Palette.textStyle().copyWith(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "  Ycoin",
                  style: Palette.textStyle().copyWith(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
