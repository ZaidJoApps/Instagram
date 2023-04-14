import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController textEditingController;
  String hintText;
  bool isPass;
  TextInputType textInputType;
  CustomTextField({
    super.key ,
    required this.textEditingController,
    required this.hintText,
    this.isPass = false,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        hintText: hintText,
        filled: true,
      ),
      obscureText: isPass,
      keyboardType: textInputType,
    );
  }
}