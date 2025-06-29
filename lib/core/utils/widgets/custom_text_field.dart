import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_hub/core/helper/app_validator.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final AppValidator? validator;
  final String hintText;
  final Function(String)? onsubment;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.onsubment,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      validator: validator?.validate,
      keyboardType: keyboardType,
      onChanged: onsubment,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.grayColor,
        prefix: const SizedBox(width: 20),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 20,
          fontFamily: AppTextStyles.fontFamily,
          color: AppColors.darkGrayColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
