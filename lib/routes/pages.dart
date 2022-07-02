import './../app/screens/info/info_screen.dart';
import './../app/bindings/info_binding.dart';
import './../app/screens/history/history_screen.dart';
import './../app/bindings/history_binding.dart';
import './../app/screens/withdraw/withdraw_screen.dart';
import './../app/bindings/withdraw_binding.dart';
import './../app/screens/notification/notification_screen.dart';
import './../app/bindings/notification_binding.dart';
import './../app/screens/charge/charge_screen.dart';
import './../app/bindings/charge_binding.dart';
import './../app/screens/home/home_screen.dart';
import './../app/bindings/home_binding.dart';
import './../app/screens/register/register_screen.dart';
import './../app/bindings/register_binding.dart';
import './../app/screens/login/login_screen.dart';
import './../app/bindings/login_binding.dart';
import './../app/screens/splash/splash_screen.dart';
import './../app/bindings/splash_binding.dart';
import 'package:get/get.dart';
part './routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      transition: Transition.cupertino,
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      transition: Transition.cupertino,
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterScreen(),
      transition: Transition.cupertino,
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      transition: Transition.cupertino,
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.CHARGE,
      page: () => ChargeScreen(),
      transition: Transition.cupertino,
      binding: ChargeBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => NotificationScreen(),
      transition: Transition.cupertino,
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.WITHDRAW,
      page: () => WithdrawScreen(),
      transition: Transition.cupertino,
      binding: WithdrawBinding(),
    ),
    GetPage(
      name: Routes.HISTORY,
      page: () => HistoryScreen(),
      transition: Transition.cupertino,
      binding: HistoryBinding(),
    ),
    GetPage(
      name: Routes.INFO,
      page: () => InfoScreen(),
      transition: Transition.cupertino,
      binding: InfoBinding(),
    ),
  ];
}
