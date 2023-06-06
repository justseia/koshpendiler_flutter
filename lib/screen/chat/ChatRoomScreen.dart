// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/CustomText.dart';
import '../../core/colors.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.black,
      appBar: appBar(),
      body: body(),
    );
  }

  Stack body() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 20.h,
            bottom: 115.h,
          ),
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            shrinkWrap: true,
            itemCount: 4,
            scrollDirection: Axis.vertical,
            separatorBuilder: (BuildContext context, int index) => Divider(
              height: 20.h,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        child: Image.asset(
                          'assets/images/bgSuccessAuth.png',
                          width: 45.w,
                          height: 45.h,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 11.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorsApp.mainColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.r),
                              topRight: Radius.circular(25.r),
                              bottomLeft: Radius.circular(25.r),
                              bottomRight: Radius.circular(25.r),
                            ),
                          ),
                          child: CustomText(
                            text:
                                'What’s great! I enjoy to go in forest areas. Do you want to go there ?I know place with so incredible nature that you haven’t see ever before.',
                            colorText: ColorsApp.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 11.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorsApp.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(5.r),
                              bottomLeft: Radius.circular(25.r),
                              bottomRight: Radius.circular(25.r),
                            ),
                          ),
                          child: CustomText(
                            text:
                                'What’s great! I enjoy to go in forest areas. Do you want to go there ?I know place with so incredible nature that you haven’t see ever before.',
                            colorText: ColorsApp.grayText,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      CircleAvatar(
                        child: Image.asset(
                          'assets/images/bgSuccessAuth.png',
                          width: 45.w,
                          height: 45.h,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                cursorColor: ColorsApp.mainColor,
                style: TextStyle(
                  color: ColorsApp.black,
                ),
                decoration: InputDecoration(
                  prefixIcon: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(100),
                    child: SvgPicture.asset(
                      'assets/icons/inputFile.svg',
                      fit: BoxFit.scaleDown,
                      height: 45.h,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(100),
                      child: SvgPicture.asset(
                        'assets/icons/buttonSend.svg',
                        fit: BoxFit.scaleDown,
                        height: 45.h,
                      ),
                    ),
                  ),
                  hintText: 'Write a message',
                  hintStyle: TextStyle(
                    color: ColorsApp.grayText,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 10.w,
                  ),
                  fillColor: ColorsApp.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: ColorsApp.black,
      toolbarHeight: 60.h,
      elevation: 0,
      title: CustomText(
        text: 'Alisher Kamal',
        colorText: ColorsApp.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
