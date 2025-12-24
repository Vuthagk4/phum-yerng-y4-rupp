import 'package:get/get.dart';
import 'package:phumyerng_ecommerce_rupp/app/data/provider/api_provider.dart';
class ApiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiProvider());
  }

}