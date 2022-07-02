import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ykapay/app/controllers/login_controller.dart';
import 'package:ykapay/app/screens/login/components/row_appbar.dart';
import 'package:ykapay/config/palette.dart';
import 'package:ykapay/utils/button_submit.dart';
import 'package:ykapay/utils/common.dart';
import 'package:ykapay/utils/text_input.dart';

class LoginScreen extends GetView<LoginController> {
  final focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: Get.size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: Get.size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: Get.size.width * 0.3,
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.transparent),
            ),
            // Positioned(
            //   left: 10,
            //   top: Get.height * .05,
            //   child: Image.asset(
            //     'assets/money.png',
            //     height: Get.height * .05,
            //   ),
            // ),
            Positioned(
              right: 0,
              top: Get.height * .065,
              child: RowAppBar(),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              //padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              padding:
                  EdgeInsets.only(top: Get.height * .15, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      image: AssetImage('assets/money.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${'login_sign_in'.tr} YKAPAY",
                      style: Palette.textTitle1(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MyTextInput(
                      hintText: 'login_username'.tr,
                      iconData: Icons.account_circle,
                      controller: controller.usernameController,
                      validateCallback: (v) {
                        controller.isValidateUsername.value = v;
                        controller.formValidate();
                      },
                      rules: {
                        'minLength': 6,
                        'required': 'Vui lòng nhập tài khoản',
                        'username': 'xxxx',
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                      hintText: 'login_password'.tr,
                      iconData: Icons.lock,
                      controller: controller.passwordController,
                      textInputType: TextInputType.visiblePassword,
                      validateCallback: (v) {
                        controller.isValidatePassword.value = v;
                        controller.formValidate();
                      },
                      rules: {
                        'minLength': 6,
                        'required': 'login_please_enter_your_password'.tr,
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => MyButtonSubmit(
                        label: 'login_sign_in'.tr.toUpperCase(),
                        submiting: controller.isSubmitting.value,
                        onPressed: !controller.isEnableSubmit.value
                            ? null
                            : () {
                                CommonWidget.progressIndicator();
                                controller.handleLogin();
                              },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyButtonSubmit(
                      label: 'login_sign_up'.tr.toUpperCase(),
                      backgroundColor: Palette.secondColor,
                      onPressed: () {
                        Get.offAllNamed('register');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
