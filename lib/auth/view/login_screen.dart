import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/auth/view/register_screen.dart';
import 'package:get/get.dart';

import '../widget/buttons.dart';
import '../widget/input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final email = TextEditingController();
  final password = TextEditingController();
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
              ),
              const SizedBox(
                height: 30,
              ),
              InputField(
                controller: password,
                hintText: 'Enter password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_off),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Buttons(
                title: 'Login',
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
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset('asset/icon/new.png'),
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
