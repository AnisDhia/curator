import 'package:curator/core/themes/pallete.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String hintText;
  final bool? obscure;
  const SearchField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator,
      this.obscure});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallete.subtleGreyColor,
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure ?? false,
        decoration: InputDecoration(
          fillColor: Pallete.blackColor,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Pallete.blueGrey,
            fontSize: 18,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(22),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }
}
