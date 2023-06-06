// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/colors.dart';

class GoogleAuth extends StatefulWidget {
  const GoogleAuth({Key? key}) : super(key: key);

  @override
  State<GoogleAuth> createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            width: 45.h,
            height: 45.h,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: ColorsApp.grayInput,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/googleAuth.svg',
                height: 26.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
