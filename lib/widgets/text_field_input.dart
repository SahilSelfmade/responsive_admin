import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final int? maxLength;
  final String? labelText;
  final void Function(String)? onChanged;
  final bool enabled;
  final String? hintText;
  final TextInputType textInputType;
  TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.maxLength,
    this.enabled = true,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      enabled: enabled,
      maxLength: maxLength,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      controller: textEditingController,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: hintText,
        labelText: labelText,
        focusColor: Colors.black,
        hintStyle: const TextStyle(color: Colors.black),
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
