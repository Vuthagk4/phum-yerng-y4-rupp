import 'package:flutter/material.dart'; // Added for Color import
import 'package:get/get.dart';
import 'package:phumyerng_ecommerce_rupp/app/data/models/product.model.dart';

class ProductDetailController extends GetxController {
  final Products? product; // Optional: Pass product for init logic

  final count = 0.obs;

  // Observable for selected size (dynamic selection)
  var selectedSize = 'M'.obs; // Default to 'M'

  // Observable for selected color (dynamic selection)
  var selectedColor = Colors.blue[300].obs; // Default to Blue

  ProductDetailController({this.product}); // Constructor

  @override
  void onInit() {
    super.onInit();
    if (product != null) {
      // e.g., If product has sizes: selectedSize.value = product!.sizes?.first ?? 'M';
      // If product has colors: selectedColor.value = product!.colors?.first ?? Colors.blue[300];
      // Or load dynamic data here
    }
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

  // Method to update selected size
  void selectSize(String size) {
    selectedSize.value = size;
    // Optional: Add logic like updating price based on size or validation
    print('Selected size: $size'); // For debugging; replace with actual logic
  }

  // Method to update selected color
  void selectColor(Color color) {
    selectedColor.value = color;
    // Optional: Add logic like updating image based on color or validation
    print('Selected color: $color'); // For debugging; replace with actual logic
  }

  // Add to cart (uses selected size and color)
  void addToCart(Products product) {
    // Example: Get.find<CartController>().addItem(product, size: selectedSize.value, color: selectedColor.value);
    // Or use a simple observable list for demo:
    // cartItems.add({...product, 'size': selectedSize.value, 'color': selectedColor.value});
    Get.snackbar(
      'Success',
      'Added to cart! Size: ${selectedSize.value}, Color: ${selectedColor.value.toString().split('(0x')[1].split(')')[0].toUpperCase()}',
    );
  }

  // Buy now (uses selected size and color)
  void buyNow(Products product) {
    // Example: Get.toNamed('/checkout', arguments: {...product, 'size': selectedSize.value, 'color': selectedColor.value});
    Get.snackbar(
      'Checkout',
      'Proceeding to buy now! Size: ${selectedSize.value}, Color: ${selectedColor.value.toString().split('(0x')[1].split(')')[0].toUpperCase()}',
    );
  }
}