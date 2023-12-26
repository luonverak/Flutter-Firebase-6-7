import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/auth/controller/user_controller.dart';
import 'package:flutter_firebase/auth/model/user_model.dart';
import 'package:flutter_firebase/auth/view/register_screen.dart';
import 'package:get/get.dart';

import '../widget/buttons.dart';
import '../../widget/input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final email = TextEditingController();
  final password = TextEditingController();
  final controller = Get.put(UserController());
  RxBool check = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 233, 240),
              Color.fromARGB(255, 206, 232, 255),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.9, 0.2),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Welcome to DMS',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 70,
              ),
              InputField(
                controller: email,
                hintText: 'Enter email address',
                prefixIcon: const Icon(Icons.email),
                obscureText: false,
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(
                () => InputField(
                  controller: password,
                  hintText: 'Enter password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      check.value = !check.value;
                    },
                    icon: Icon(
                      (check.value == false)
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                    ),
                  ),
                  obscureText: check.value,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () async {
                  await controller.loginUser(
                    UserModel(
                      email: email.text,
                      password: password.text.trim(),
                    ),
                  );
                },
                child: Obx(
                  () => Visibility(
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    visible: controller.check.value,
                    child: const Buttons(
                      title: 'Login',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'or',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async => controller.signInWithGoogle(),
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset('asset/icon/new.png'),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset('asset/icon/facebook (1).png'),
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset('asset/icon/twitter.png'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 206, 232, 255),
              Color.fromARGB(255, 206, 232, 255),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.9, 0.2),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 15),
        child: CupertinoButton(
          child: const Text(
            'Register Account',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () async => Get.to(RegisterScreen()),
        ),
      ),
    );
  }
}
