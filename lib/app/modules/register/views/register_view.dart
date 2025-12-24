import 'package:faker/faker.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../auth/forms/sign_up_form.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Register",
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              const Text(
                "Welcome! Please register to create an account.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              SignUpForm(
                onClosed: (v) {},
                emailController: controller.emailController,
                passwordController: controller.passController,
                onSignIn: () {
                  final email = controller.emailController.text;
                  final password = controller.passController.text;
                  final name = controller.faker.person.name();
                  controller.register(
                    email: email,
                    password: password,
                    name: name,
                  );
                },
              ),
            ],
          ),
        ));
  }
}
