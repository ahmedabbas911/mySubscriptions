import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? suffixText;
  final int maxLines;
  final String? Function(String?)? validator;

  const AppTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.textInputAction,
    this.suffixText,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(
        color: Color(0xFFF5F7FA),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: const Color(0xFFFF8500),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF687581), fontSize: 13.5),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 12),
          child: Icon(prefixIcon, color: const Color(0xFF8996A3), size: 21),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 52,
          minHeight: 52,
        ),
        suffixText: suffixText,
        suffixStyle: const TextStyle(
          color: Color(0xFFFF8500),
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        filled: true,
        fillColor: const Color(0xFF10161C),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(color: Color(0xFF29333D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(color: Color(0xFF29333D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(color: Color(0xFFFF8500), width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(color: Color(0xFFE05252)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(color: Color(0xFFE05252), width: 1.4),
        ),
        errorStyle: const TextStyle(color: Color(0xFFE05252), fontSize: 11),
      ),
    );
  }
}
