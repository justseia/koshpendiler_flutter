// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/colors.dart';
import './CustomText.dart';

class CustomInput extends StatefulWidget {
  const CustomInput({
    Key? key,
    this.controller,
    required this.inputUpText,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController? controller;
  final String inputUpText;
  final String hintText;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 25.w,
            bottom: 5.h,
          ),
          child: CustomText(
            text: widget.inputUpText,
            colorText: ColorsApp.grayText,
            fontSize: 9.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          cursorColor: ColorsApp.mainColor,
          style: TextStyle(
            color: ColorsApp.grayText.withOpacity(.45),
          ),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(width: 2, color: ColorsApp.grayInput),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(width: 2, color: ColorsApp.grayInput),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 25.w,
              vertical: 18.h,
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: ColorsApp.grayText.withOpacity(.45),
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }
}
