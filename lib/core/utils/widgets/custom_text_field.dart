import 'package:flutter/material.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String hintText;
  Function(String)? onsubment;
  bool? obscureText;
  CustomTextField({
    super.key,
    required this.hintText,
    this.onsubment,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        obscureText: obscureText!,
        validator: (data) {
          if (data!.isEmpty) {
            return 'field is requierd';
          }
          return null;
        },
        onChanged: onsubment,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.grayColor,
          prefix: SizedBox(width: 20),
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 20,
            fontFamily: AppTextStyles.fontFamily,
            color: AppColors.darkGrayColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
