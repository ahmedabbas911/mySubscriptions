import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;

  final TextInputType? keyboardType;
  final bool obscureText;

  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      keyboardType: keyboardType,
      obscureText: obscureText,

      validator: validator,

      style: const TextStyle(
        color: Color(0xFFF5F5F5),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),

      cursorColor: const Color(0xFFFF8A00),

      decoration: InputDecoration(
        hintText: hintText,

        hintStyle: const TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),

        prefixIcon: Icon(prefixIcon, color: const Color(0xFF9CA3AF), size: 21),

        suffixIcon: suffixIcon,

        filled: true,
        fillColor: const Color(0xFF272B35),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: const BorderSide(color: Color(0xFFFF8A00), width: 1.2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
        ),

        errorStyle: const TextStyle(color: Color(0xFFFF6B6B), fontSize: 11),
      ),
    );
  }
}
