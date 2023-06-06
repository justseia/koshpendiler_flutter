import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/colors.dart';
import './CustomText.dart';

class CustomButtonWithBack extends StatefulWidget {
  const CustomButtonWithBack({
    Key? key,
    this.clickButton = true,
    required this.buttonText,
    required this.routeName,
    required this.buttonColor,
  }) : super(key: key);

  final bool clickButton;
  final String buttonText;
  final String routeName;
  final Color buttonColor;

  @override
  State<CustomButtonWithBack> createState() => _CustomButtonWithBackState();
}

class _CustomButtonWithBackState extends State<CustomButtonWithBack> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.clickButton
          ? () {
              Navigator.of(context).pushNamed(
                widget.routeName,
              );
            }
          : null,
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
