// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/colors.dart';
import './CustomText.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    this.clickButton = true,
    required this.buttonText,
    required this.routeName,
    required this.buttonColor,
    required this.onTapp,
  }) : super(key: key);

  final bool clickButton;
  final String buttonText;
  final String routeName;
  final Color buttonColor;
  final Function onTapp;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // onPressed: null,
      onPressed: () {
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //   widget.routeName,
        //   (Route<dynamic> route) => false,
        // );
        // widget.clickButton ?
        widget.onTapp();
        // : null;
      },
      // : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.buttonColor,
        disabledBackgroundColor: ColorsApp.disableButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(53.r),
        ),
        minimumSize: Size(double.infinity, 50.h),
      ),
      child: CustomText(
        text: widget.buttonText,
        colorText: ColorsApp.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
