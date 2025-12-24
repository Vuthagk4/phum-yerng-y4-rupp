import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:phumyerng_ecommerce_rupp/app/global_binding/api_binding.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: ApiBinding(),
    ),
  );
}
