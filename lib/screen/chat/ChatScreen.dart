// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors.dart';
import '../../components/NotificationButton.dart';
import '../../components/CustomText.dart';
import '../../components/SearchHint.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.black,
      appBar: appBar(),
      body: body(),
    );
  }

  DefaultTabController body() {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 20.h,
          bottom: 135.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 30.w,
                    left: 30.w,
                    bottom: 28.h,
                  ),
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: ColorsApp.grayInput,
                      borderRadius: BorderRadius.circular(40.h),
                    ),
                    child: TabBar(
                      labelColor: ColorsApp.white,
                      unselectedLabelColor: ColorsApp.white,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                      indicator: BoxDecoration(
                        color: ColorsApp.mainColor,
                        borderRadius: BorderRadius.circular(40.h),
                      ),
                      tabs: [
                        Tab(text: 'Friends'),
                        Tab(text: 'Chats'),
                        Tab(text: 'Groups'),
                      ],
                    ),
                  ),
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                  ),
                  shrinkWrap: true,
                  itemCount: 5,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    thickness: 2,
                    height: 25.h,
                    color: ColorsApp.white.withOpacity(.6),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/chat_room',
                        );
                      },
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 16.w),
                              width: 45.w,
                              height: 45.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://loremflickr.com/50/50'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 180.w,
                                        child: CustomText(
                                          text: 'Ivan Redkin',
                                          colorText: ColorsApp.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          textOverflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      CustomText(
                                        text: '3 days ago',
                                        colorText: ColorsApp.white,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    width: 210.w,
                                    child: CustomText(
                                      text:
                                          'The pristine nature of Kok-Zhailau Kok Zhailau',
                                      colorText: ColorsApp.white,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: ColorsApp.black,
      toolbarHeight: 60.h,
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SearchHint(),
            NotificationButton(),
          ],
        ),
      ),
    );
  }
}
