// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors.dart';
import '../../components/CustomButton.dart';
import '../../components/CustomText.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.black,
      body: SafeArea(
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
                text: 'Koshpendiler'.toUpperCase(),
                colorText: ColorsApp.mainColor,
                fontSize: 36.sp,
                fontWeight: FontWeight.w600,
              ),
              CustomButton(
                onTapp: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login',
                    (Route<dynamic> route) => false,
                  );
                },
                buttonText: 'Get Started',
                routeName: '/login',
                buttonColor: ColorsApp.mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
