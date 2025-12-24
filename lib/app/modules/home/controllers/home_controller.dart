import 'package:get/get.dart';
import 'package:phumyerng_ecommerce_rupp/app/services/storage_service.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var curentUser;
  final count = 0.obs;
  @override
  void onInit() {
    getCurrentUserLogin();
    super.onInit();
  }

  void getCurrentUserLogin() async {
    final user = await StorageService.read(key: 'user');
    curentUser = user;
    print("user $user");
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
