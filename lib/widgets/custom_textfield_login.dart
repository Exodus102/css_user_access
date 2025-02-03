import 'package:flutter/material.dart';

class CustomTextfieldLogin extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool isObscure;
  const CustomTextfieldLogin({
    super.key,
    required this.label,
    this.controller,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        obscureText: isObscure,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Color(0xFF064089),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Color(0xFF064089),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color(0xFF064089),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF064089),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF064089),
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
