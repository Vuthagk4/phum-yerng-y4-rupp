import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //lazy put ort use ort jenh
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
