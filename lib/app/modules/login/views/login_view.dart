import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../auth/forms/sign_in_form.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final emailController = controller.emailController;
    final passwordController = controller.passwordController;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login'.toUpperCase(),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            //e-commerce app
            Text(
              "Welcome back! Please login to your account.",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            SignInForm(
              emailController: emailController,
              passwordController: passwordController,
              onCreateAccount: () async {
                final result = await Get.toNamed(Routes.REGISTER);
                if (result != null) {
                  emailController.text = result['email'];
                  passwordController.text = result['password'];
                }
              },
              onSignIn: () {
                controller.login(
                  email: emailController.text,
                  password: passwordController.text,
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
