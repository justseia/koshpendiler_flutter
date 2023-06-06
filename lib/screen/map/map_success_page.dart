// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/CustomButtonWithBack.dart';
import '../../../core/colors.dart';

class MapSuccessPage extends StatefulWidget {
  const MapSuccessPage({super.key});

  @override
  State<MapSuccessPage> createState() => _MapSuccessPageState();
}

class _MapSuccessPageState extends State<MapSuccessPage> {
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
                      'You received 1 coin, which you '
                      'can use when paying for the transfer',
                      textAlign: TextAlign.center,
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
          margin: EdgeInsets.only(bottom: 30),
          alignment: Alignment.bottomCenter,
          child: CustomButtonWithBack(
            buttonText: 'Go to Profile',
            routeName: '/',
            buttonColor: ColorsApp.yellowbd,
          ),
        ),
      ),
    );
  }
}
