import 'package:flutter/material.dart';

class FieldsSignUp extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? validationMessage;
  const FieldsSignUp(
      {super.key,
      required this.controller,
      this.labelText,
      this.validationMessage});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage ?? 'Please enter some text';
        }
      },
    );
  }
}
