import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
  });
  var controller = TextEditingController();
  var hintText;
  Icon prefixIcon;
  IconButton? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: Colors.grey,
        ),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: prefixIcon,
          hintText: hintText,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}