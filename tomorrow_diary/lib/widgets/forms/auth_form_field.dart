import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validation;
  final bool isRegister;
  const AuthFormField({this.hint, this.controller, this.validation, this.isRegister = true});

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    );
    return TextFormField(
      obscureText: hint!.contains("Password") ? true : false,
      controller: controller,
      cursorColor: this.isRegister == true? Colors.white : Colors.transparent,
      cursorWidth: this.isRegister == true? 2.0 : 0.0,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white30,
        label: Text("$hint"),
        labelStyle: TextStyle(color: Colors.white),
        border: _border,
        enabledBorder: _border,
        focusedBorder: _border,
        errorBorder: hint != "Confirm Password"
            ? _border
            : OutlineInputBorder(borderSide: BorderSide.none),
      ),
      validator: validation == null ? null : validation,
    );
  }
}
