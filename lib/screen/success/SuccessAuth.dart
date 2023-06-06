// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors.dart';
import '../../components/CustomButton.dart';
import '../../components/CustomText.dart';

class SuccessAuth extends StatefulWidget {
  const SuccessAuth({Key? key}) : super(key: key);

  @override
  State<SuccessAuth> createState() => _SuccessAuthState();
}

class _SuccessAuthState extends State<SuccessAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgSuccessAuth.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          top: true,
          bottom: true,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 28.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                CustomText(
                  text: 'You did it,\nYou are in!',
                  colorText: ColorsApp.mainColor,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w500,
                ),
                CustomButton(
                  onTapp: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (Route<dynamic> route) => false,
                    );
                  },
                  buttonText: 'Let’s Start',
                  routeName: '/',
                  buttonColor: ColorsApp.mainColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
