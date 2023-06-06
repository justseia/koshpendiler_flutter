// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/CustomButtonWithBack.dart';
import '../../../core/colors.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 82),
                    child: Icon(
                      Icons.check_circle_outline,
                      color: ColorsApp.mainColor,
                      size: MediaQuery.of(context).size.width - 164,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    child: Text(
                      'Your card has been successfully'
                      ' added! Enjoy traveling with us!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xffA5AaA6),
                        height: 16.94 / 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          button(),
        ],
      ),
    );
  }

  SafeArea button() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30.w,
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.bottomCenter,
          child: CustomButtonWithBack(
            buttonText: 'Continue',
            routeName: '/',
            buttonColor: ColorsApp.disableButton,
          ),
        ),
      ),
    );
  }
}
