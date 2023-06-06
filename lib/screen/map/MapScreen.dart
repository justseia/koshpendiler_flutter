// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../core/colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: YandexMap(),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: ColorsApp.transparent,
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: SvgPicture.asset(
                'assets/icons/back.svg',
                height: 22.h,
                color: ColorsApp.black.withOpacity(.7),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 282.w,
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                cursorColor: ColorsApp.mainColor,
                style: TextStyle(
                  color: ColorsApp.white.withOpacity(.5),
                ),
                decoration: InputDecoration(
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/inputSearch.svg',
                    fit: BoxFit.scaleDown,
                    height: 20.h,
                  ),
                  hintText: 'Where are you going to?',
                  hintStyle: TextStyle(
                    color: ColorsApp.white.withOpacity(.5),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 10.w,
                  ),
                  fillColor: ColorsApp.black.withOpacity(.7),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
