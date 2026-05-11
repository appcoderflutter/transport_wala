import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatelessWidget {

  final String hint;

  final TextInputType? keyboardType;

  final TextEditingController? controller;

  final int? maxLength;

  const AuthTextField({
    super.key,
    required this.hint,
    this.keyboardType,
    this.controller,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 52.h,

      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(8.r),
      ),

      child: TextField(

        controller: controller,

        keyboardType: keyboardType,

        maxLength: maxLength,

        style: TextStyle(
          color: Colors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),

        inputFormatters:
        keyboardType == TextInputType.phone

            ? [
          FilteringTextInputFormatter.digitsOnly,
        ]

            : null,

        decoration: InputDecoration(

          counterText: "",

          hintText: hint,

          border: InputBorder.none,

          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),

          hintStyle: TextStyle(
            color: Colors.black45,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}