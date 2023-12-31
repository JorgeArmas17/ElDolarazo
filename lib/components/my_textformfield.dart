import 'package:dgs/common/enums.dart';
import 'package:dgs/common/validate.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  bool obscureText;
  ValidateText? validateText;
  bool notRequire;
  MyTextFormField(
    this.controller,
    this.hintText,
    this.obscureText, {
    super.key,
    this.validateText,
    this.notRequire = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (String? value) {
          return validateStructure(value);
        },
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }

  validateMaxLength() {
    switch (validateText) {
      case ValidateText.password:
        return 6;
      default:
        return null;
    }
  }

  validateStructure(String? value) {
    if (!notRequire && value!.isEmpty) {
      return "El campo $hintText es requerido.";
    } else {
      switch (validateText) {
        case ValidateText.email:
          return validateEmail(value!) ? null : "Email incorrecto";
        case ValidateText.password:
          return value!.length >= 6 ? null : "Debe tener más de 6 caracteres";
        default:
          return null;
      }
    }
  }
}
