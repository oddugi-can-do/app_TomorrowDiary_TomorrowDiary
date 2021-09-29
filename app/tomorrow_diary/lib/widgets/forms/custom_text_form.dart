import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/tdcolor.dart';
import 'package:tomorrow_diary/utils/tdsize.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  FormFieldValidator<String>? validation;
  CustomTextFormField({
    Key? key,
    this.hint, this.controller, this.validation, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TdSize.s),
      child: TextFormField(
        autofocus: true,
         textInputAction: TextInputAction.next,
        obscureText: hint!.contains("Password") ? true: false,
        controller: controller,
        decoration: InputDecoration(
          hintText: "$hint",
          enabledBorder: _enabledBorder(),
          focusedBorder: _focusedBorder(),
          focusedErrorBorder:_focusedErrorBorder(), 
          errorBorder: _errorBorder(),
          filled: true,
          fillColor: TdColor.darkGray,
        ),
        validator: validation,
      ),
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
          borderSide: BorderSide(
            color: TdColor.lightRed,
          ),
        );
  }

  OutlineInputBorder _focusedErrorBorder() {
    return OutlineInputBorder(
          borderSide: BorderSide(
            color: TdColor.lightRed,
          ),
        );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
          borderSide: BorderSide(
            color: TdColor.blue,
          ),
        );
  }

  OutlineInputBorder _enabledBorder() {
    return OutlineInputBorder(
          borderSide: BorderSide(
            color: TdColor.gray,
          ),
        );
  }
}