import 'package:flutter/material.dart';

import '../widget/input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final email = TextEditingController();
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
            children: [
              const SizedBox(
                height: 130,
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
                height: 50,
              ),
              InputField(
                controller: email,
                hintText: 'Enter email address',
                prefixIcon: Icon(Icons.email),
              ),
              const SizedBox(
                height: 30,
              ),
              InputField(
                controller: email,
                hintText: 'Enter password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.visibility_off),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
