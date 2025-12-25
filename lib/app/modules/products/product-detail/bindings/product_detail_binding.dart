import 'package:get/get.dart';
import 'package:phumyerng_ecommerce_rupp/app/data/models/product.model.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  final Products product; // Pass product to binding

  ProductDetailBinding({required this.product});

  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailController(product: product));
  }
}