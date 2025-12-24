import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phumyerng_ecommerce_rupp/app/routes/app_pages.dart';
import 'package:phumyerng_ecommerce_rupp/app/services/storage_service.dart';

import '../../../data/provider/api_provider.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _provider = Get.find<ApiProvider>();

  void login({required String email,required String password}) async{
    try{
      final response = await _provider.login(email: email, password: password);
      if(response.statusCode == 200){
        //success go to homeview
        final token = response.data['token'];
        StorageService.write(key: 'token',value:token);
        // Save User
        final user = response.data['user'];
        await StorageService.write(key: 'token', value: token);
        await StorageService.write(key: 'user', value: jsonEncode(user));
        Get.offNamed(Routes.HOME);
      }
      else{
        Get.defaultDialog(
          title: "Error ",
          content:  Text("Failed to login")
        );
      }
    }
    catch(e){
      Get.defaultDialog(
        title: "Error",
        content: Text(e.toString())
      );
    }
  }
}
