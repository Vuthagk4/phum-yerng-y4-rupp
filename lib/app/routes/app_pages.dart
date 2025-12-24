import 'package:get/get.dart';
import 'package:phumyerng_ecommerce_rupp/app/modules/home/bindings/home_binding.dart';
import 'package:phumyerng_ecommerce_rupp/app/modules/main/bindings/main_binding.dart';
import 'package:phumyerng_ecommerce_rupp/app/modules/main/views/main_view.dart';
import 'package:phumyerng_ecommerce_rupp/app/modules/register/bindings/register_binding.dart';
import 'package:phumyerng_ecommerce_rupp/app/modules/register/views/register_view.dart';

import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    )
  ];
}
