import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ykapay/app/controllers/info_controller.dart';
import 'package:ykapay/config/palette.dart';
import 'package:ykapay/utils/button_submit.dart';
import 'package:ykapay/utils/fade_in.dart';
import 'package:ykapay/utils/number.dart';
import 'package:ykapay/utils/smart_refresher_success.dart';
import 'package:ykapay/utils/text_input.dart';

class InfoScreen extends GetView<InfoController> {
  @override
  Widget build(BuildContext context) {
    InfoController controller = Get.put(InfoController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Padding(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * .03,
                ),
                FadeIn(
                  delay: 0.3,
                  child: Row(
                    children: [
                      Text(
                        'Tên tài khoản:',
                        style: Palette.textStyle().copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FadeIn(
                  delay: 0.6,
                  child: MyTextInput(
                    readOnly: true,
                    iconData: Icons.account_balance,
                    controller: controller.accountController,
                    hintText: controller.box.read('account') ?? 'dangcao',
                    background: Colors.white,
                    textInputType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FadeIn(
                  delay: 0.5,
                  child: Row(
                    children: [
                      Text(
                        'ATM:',
                        style: Palette.textStyle().copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FadeIn(
                  delay: 0.6,
                  child: MyTextInput(
                    iconData: Icons.atm,
                    controller: controller.atmController,
                    hintText: 'Số tài khoản ATM',
                    background: Colors.white,
                    textInputType: TextInputType.number,
                    rules: {
                      'required': 'Vui lòng nhập số tài khoản ATM',
                    },
                    validateCallback: (value) {
                      controller.isValidateATM.value = value;
                      controller.formValidate();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FadeIn(
                  delay: 0.5,
                  child: Row(
                    children: [
                      Text(
                        'MoMo:',
                        style: Palette.textStyle().copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FadeIn(
                  delay: 0.6,
                  child: MyTextInput(
                    controller: controller.momoController,
                    iconData: Icons.attach_money,
                    hintText: 'Số điện thoại MoMo',
                    background: Colors.white,
                    textInputType: TextInputType.number,
                    rules: {
                      'phone': true,
                      'required': 'Vui lòng nhập số điện thoại',
                    },
                    validateCallback: (value) {
                      controller.isValidateMoMo.value = value;
                      controller.formValidate();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FadeIn(
                  delay: 0.5,
                  child: Row(
                    children: [
                      Text(
                        'ZaloPay:',
                        style: Palette.textStyle().copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FadeIn(
                  delay: 0.6,
                  child: MyTextInput(
                    controller: controller.zaloController,
                    iconData: Icons.attach_money,
                    hintText: 'Số điện thoại Zalo',
                    background: Colors.white,
                    textInputType: TextInputType.number,
                    rules: {
                      'phone': true,
                      'required': 'Vui lòng nhập số điện thoại',
                    },
                    validateCallback: (value) {
                      controller.isValidateZaloPay.value = value;
                      controller.formValidate();
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FadeIn(
                  delay: 0.7,
                  child: MyButtonSubmit(
                    backgroundColor: Colors.blueAccent,
                    label: 'common.saveInfo'.tr,
                    onPressed: () {
                      controller.submitButton();
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Đổi mật khẩu',
                //       style: Palette.textStyle().copyWith(fontSize: 20, color: Colors.blue),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Center(
                  child: Text(
                    "v" + controller.version ?? '',
                    style: Palette.textStyle().copyWith(fontSize: 12, color: Colors.grey),
                  ),
                ),
                InkWell(
                  onTap: () {
                    GetStorage().erase();
                    Get.offAllNamed('login');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Đăng xuất',
                        style: Palette.textStyle().copyWith(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BalanceContainer extends StatelessWidget {
  const BalanceContainer({
    Key key,
    this.balance = 0,
  }) : super(key: key);
  final int balance;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
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
                style: Palette.textStyle().copyWith(color: Colors.white, fontSize: 25),
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
                style: Palette.textStyle().copyWith(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
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
    this.balance = 0,
  }) : super(key: key);
  final int balance;
  final List<Color> gradient;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
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
                "${$Number.numberFormat(balance)}",
                style: Palette.textStyle().copyWith(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "  Ycoin",
                style: Palette.textStyle().copyWith(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
