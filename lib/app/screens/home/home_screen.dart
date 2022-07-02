import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ykapay/app/screens/charge/charge_screen.dart';
import 'package:ykapay/app/screens/history/history_screen.dart';
import 'package:ykapay/app/screens/info/info_screen.dart';
import 'package:ykapay/app/screens/notification/notification_screen.dart';
import 'package:ykapay/app/screens/withdraw/withdraw_screen.dart';
import 'package:ykapay/utils/shader_mask_custom.dart';
import './../../../app/controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BottomNavBar());
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 2;
  List<Widget> listWidget = [
    WithdrawScreen(),
    NotificationScreen(),
    ChargeScreen(),
    HistoryScreen(),
    InfoScreen(),
  ];
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 2,
            height: 50.0,
            items: <Widget>[
              ShaderMaskCustom(
                icon: Icons.attach_money,
                size: 30,
              ),
              ShaderMaskCustom(
                icon: Icons.phonelink_ring_sharp,
                size: 30,
              ),
              ShaderMaskCustom(
                icon: Icons.add,
                size: 50,
              ),
              ShaderMaskCustom(
                icon: Icons.history,
                size: 30,
              ),
              ShaderMaskCustom(
                icon: Icons.perm_identity,
                size: 30,
              ),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            letIndexChange: (index) => true,
          ),
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
              listWidget[_page],
            ],
          )),
    );
  }
}
