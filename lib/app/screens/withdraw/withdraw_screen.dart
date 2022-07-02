import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ykapay/app/controllers/withdraw_controller.dart';
import 'package:ykapay/config/palette.dart';
import 'package:ykapay/utils/button_submit.dart';
import 'package:ykapay/utils/fade_in.dart';
import 'package:ykapay/utils/number.dart';
import 'package:ykapay/utils/smart_refresher_success.dart';
import 'package:ykapay/utils/text_input.dart';
import './../../../app/controllers/charge_controller.dart';

class WithdrawScreen extends GetView<WithdrawController> {
  @override
  Widget build(BuildContext context) {
    WithdrawController controller = Get.put(WithdrawController());
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
                height: 40,
              ),
              FadeIn(
                delay: 0.3,
                child: Row(
                  children: [
                    Text(
                      'Chọn phương thức thanh toán:',
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
                delay: 0.4,
                child: Container(
                  height: 50,
                  width: Get.width,
                  child: DropdownButtonFormField2<StatusModel>(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    isExpanded: true,
                    // hint: Text(
                    //   // 'status'.tr,
                    //   style: TextStyle(fontSize: 14),
                    // ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // items: controller.status.map((e) => )
                    items: controller.status
                        .map((item) => DropdownMenuItem<StatusModel>(
                              value: item,
                              child: Text(
                                '${item.label}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                      controller.isStatus?.value = value.status;
                      controller.payment(value.id);
                      // print(value.status);
                    },
                    onSaved: (value) {
                      controller.selectedPayment?.value = value.toString();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeIn(
                delay: 0.5,
                child: Row(
                  children: [
                    Text(
                      'Nhập số tiền muốn rút:',
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
                child: Obx(
                  () => controller.isSubmitting.value
                      ? CircularProgressIndicator()
                      : MyTextInput(
                          controller: controller.amountController,
                          iconData: Icons.money_sharp,
                          hintText: 'Nhập số dư của bạn',
                          background: Colors.white,
                          textInputType: TextInputType.number,
                          rules: {
                            'maxAmount': controller.balance.value,
                            'minAmount': 50000,
                          },
                          validateCallback: (value) {
                            controller.isValidateAmount.value = value;
                            controller.formValidate();
                          },
                        ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FadeIn(
                delay: 0.7,
                child: MyButtonSubmit(
                  backgroundColor: Colors.blueAccent,
                  label: 'common.withdraw'.tr,
                  onPressed: () {
                    controller.submitButton();
                  },
                ),
              )
            ],
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
