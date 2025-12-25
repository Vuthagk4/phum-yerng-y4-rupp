import 'package:get/get.dart';
import 'package:phumyerng_ecommerce_rupp/app/data/models/product.model.dart';
import 'package:phumyerng_ecommerce_rupp/app/data/provider/api_provider.dart';
import 'package:phumyerng_ecommerce_rupp/app/modules/products/product-detail/views/product_detail_view.dart';
import 'package:phumyerng_ecommerce_rupp/app/services/storage_service.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var isLoading = false.obs;
  //Global varaible
  Rx<Product> products = Product().obs;

  final _apiProvider = Get.find<ApiProvider>();
  var curentUser;
  final count = 0.obs;
  @override
  void onInit() {
    getCurrentUserLogin();
    fetchProduct();
    super.onInit();
  }

  void getCurrentUserLogin() async {
    final user = await StorageService.read(key: 'user');
    curentUser = user;
    print("user $user");
  }


  void fetchProduct()async{
    try{
      final response = await _apiProvider.getProducts();
      if(response.statusCode != 200){
        Get.defaultDialog(
          title: "Error",
          middleText: "Failed to get product"
        );
      }
      products.value = Product.fromJson(response.data);
    }catch(e) {
      Get.defaultDialog(
          title: "Error",
        middleText: e.toString()
      );
    }
  }

  void goToDetail(Products product){
    Get.to(()=> ProductDetailView(product: product ,));
  }

}
