// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/colors.dart';
import '../chat_page/chats_list_page.dart';
import '../home/HomeScreen.dart';
import '../camera/CameraTrapScreen.dart';
import '../map/MapScreen.dart';
import '../chat/ChatScreen.dart';
import '../profile/ProfileScreen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var _currentIndex = 0;
  List<Widget> _pages = [
    HomeScreen(),
    CameraTrapScreen(),
    MapScreen(),
    // ChatScreen(),
    ChatsListPage(),
    ProfileScreen(),
  ];
  List _icons = [
    'assets/icons/home.svg',
    'assets/icons/camera.svg',
    'assets/icons/map.svg',
    'assets/icons/chat.svg',
    'assets/icons/profile.svg',
  ];
  List _dotMove = [
    60.w,
    126.w,
    192.w,
    258.w,
    324.w,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: ColorsApp.black,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
                width: 6.h,
                margin: EdgeInsets.only(
                  left: _dotMove[_currentIndex].toDouble(),
                ),
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: ColorsApp.mainColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Container(
              height: 65.h,
              decoration: BoxDecoration(
                color: ColorsApp.navBar,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorsApp.mainColor.withOpacity(.2),
                    offset: Offset(0, -5),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: ListView.separated(
                itemCount: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                      HapticFeedback.lightImpact();
                    });
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        width: 66.w,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          _icons[index],
                          color: index == _currentIndex
                              ? ColorsApp.mainColor
                              : ColorsApp.grayText,
                          height: 22.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
