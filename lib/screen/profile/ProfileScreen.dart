// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:koshpendiler/model/profile_model.dart';
import 'package:koshpendiler/screen/login/LoginScreen.dart';
import '../../core/colors.dart';
import '../../components/FavoritePost.dart';
import '../../components/NotificationButton.dart';
import '../../components/CustomText.dart';
import '../../components/SearchHint.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/clarity.dart';
import 'package:iconify_flutter/icons/wpf.dart';

import 'profile_me_bloc/profile_me_bloc.dart';

Map<String, List> tripsListPerMonth = {
  'March': ['', ''],
  'April': [''],
  'May': ['', '', '', ''],
};
int _tabIndex = 1;

List<String> _navPages = [
  '/profile_info_page',
  '/notifications',
  '/faq_page',
  '/terms_page',
  '/privacy_page',
  '/app_info',
];

Map<String, Iconify> _infoBody = {
  'Profile': Iconify(
    MaterialSymbols.person_outline,
    color: ColorsApp.grayText,
    size: 22,
  ),
  'Notifications': Iconify(
    MaterialSymbols.person_outline,
    color: ColorsApp.grayText,
    size: 22,
  ),
  'FAQ': Iconify(
    Wpf.faq,
    color: ColorsApp.grayText,
    size: 22,
  ),
  'Terms&Conditions': Iconify(
    MaterialSymbols.docs,
    color: ColorsApp.grayText,
    size: 22,
  ),
  'Private Policy': Iconify(
    MaterialSymbols.privacy_tip,
    color: ColorsApp.grayText,
    size: 22,
  ),
  'App Info': Iconify(
    MaterialSymbols.info_outline,
    color: ColorsApp.grayText,
    size: 22,
  ),
  'Log Out': Iconify(
    MaterialSymbols.logout,
    color: ColorsApp.yellowbd,
    size: 22,
  ),
};

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('PRFILE SCREEN');
    context.read<ProfileMeBloc>().add(ProfileMeEvent());
  }

  double maxWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileMeBloc, ProfileMeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsApp.black,
          appBar: appBar(),
          body: state is ProfileMeLoading
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              : state is ProfileMeSuccess
                  ? body(state)
                  : state is ProfileMeFailure
                      ? SizedBox(
                          child: Text(
                            'ERROR',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : SizedBox(
                          child: Text(
                            'UNKNOWN ERROR',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ),
        );
      },
    );
  }

  Widget image_body(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: 180.w,
        height: 180.h,
        margin: EdgeInsets.only(
          top: 20.h,
          bottom: 40.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30.h),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: ColorsApp.mainColor,
              blurRadius: 16,
              offset: Offset(-8, 0),
            ),
          ],
        ),
      ),
      placeholder: (context, url) => Container(
        width: 180.w,
        height: 180.h,
        margin: EdgeInsets.only(
          top: 20.h,
          bottom: 40.h,
        ),
        alignment: Alignment.center,
        // decoration: bd_wh_12,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30.h),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: ColorsApp.mainColor,
              blurRadius: 16,
              offset: Offset(-8, 0),
            ),
          ],
        ),
        child: url == ''
            ? Iconify(
                Ion.person_circle_outline,
                color: Colors.black,
                size: 100,
              )
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
      errorWidget: (context, url, error) => Container(
        width: 180.w,
        height: 180.h,
        margin: EdgeInsets.only(
          top: 20.h,
          bottom: 40.h,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30.h),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: ColorsApp.mainColor,
              blurRadius: 16,
              offset: Offset(-8, 0),
            ),
          ],
        ),
        child: Iconify(
          Ion.person_circle_outline,
          color: Colors.black,
          size: 100,
        ),
      ),
    );
  }

  DefaultTabController body(ProfileMeSuccess state) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image_body(state.me.image ?? ''),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 25.w,
                    left: 25.w,
                    bottom: 28.h,
                  ),
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: ColorsApp.white,
                      borderRadius: BorderRadius.circular(40.h),
                    ),
                    child: TabBar(
                      onTap: (value) {
                        setState(() {
                          _tabIndex = value;
                        });
                      },
                      labelColor: ColorsApp.mainColor,
                      unselectedLabelColor: ColorsApp.grayText,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                      indicator: BoxDecoration(
                        color: ColorsApp.white,
                        borderRadius: BorderRadius.circular(40.h),
                        border: Border.all(
                          color: ColorsApp.mainColor,
                          width: 1.5.w,
                        ),
                      ),
                      tabs: [
                        Tab(text: 'My Trips'),
                        Tab(text: 'Preferences'),
                        Tab(text: 'Info'),
                      ],
                    ),
                  ),
                ),
                _tabIndex == 0
                    ? my_trips()
                    : _tabIndex == 1
                        ? _preferncies_body()
                        : infos_body(state.me),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget infos_body(ProfileModel me) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width - 44,
            color: ColorsApp.yellowbd,
          ),
          SizedBox(height: 23),
          buildInfosWithMap(_infoBody, me),
        ],
      ),
    );
  }

  Widget my_trips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: buildColumnWithMap(tripsListPerMonth),
    );
  }

  Widget buildInfosWithMap(Map<String, Iconify> map, ProfileModel me) {
    List<Widget> columnChildren = [];

    map.forEach((key, value) {
      // Create a Text widget to display the key
      Widget keyWidget = Column(
        children: [
          GestureDetector(
            onTap: () {
              key != 'Log Out'
                  ? Navigator.of(context).pushNamed(
                      _navPages[_infoBody.keys.toList().indexOf(key)],
                      arguments: key == 'Profile' ? me : null)
                  : showModalBottomSheet<dynamic>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: ColorsApp.grayInput,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(40)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 20),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 44,
                                child: Text(
                                  'Are you sure you want to log out?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    height: 16.94 / 14,
                                  ),
                                ),
                              ),
                              SizedBox(height: 37),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  56) /
                                              2,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 17),
                                      decoration: BoxDecoration(
                                        color: ColorsApp.grayInput,
                                        border: Border.all(
                                            color: ColorsApp.yellowbd,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(53),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: ColorsApp.yellowbd,
                                          height: 16.94 / 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () {
                                      var tokenBox = Hive.box('tokens');
                                      tokenBox.clear();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (context) {
                                        return LoginScreen();
                                      }), (route) => false);
                                    },
                                    child: Container(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  56) /
                                              2,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 17),
                                      decoration: BoxDecoration(
                                        color: ColorsApp.yellowbd,
                                        border: Border.all(
                                            color: ColorsApp.yellowbd,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(53),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Yes, Logout',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          height: 16.94 / 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
              ;
            },
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorsApp.grayInput,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  // child: Iconify(
                  //   MaterialSymbols.person_outline,
                  //   color: ColorsApp.grayText,
                  //   size: 22,
                  // ),
                  child: value,
                ),
                SizedBox(width: 15),
                Text(
                  // 'Profile',
                  key,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: key != 'Log Out' ? Colors.white : ColorsApp.yellowbd,
                    height: 19.36 / 16,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  shadows: [
                    BoxShadow(blurRadius: 10, color: ColorsApp.yellowbd)
                  ],
                  color: ColorsApp.yellowbd,
                ),
              ],
            ),
          ),
          // SizedBox(height: 19),
        ],
      );

      // Create a ListView to display the list values
      // Widget listWidget = ListView.builder(
      //   shrinkWrap: true,
      //   physics: NeverScrollableScrollPhysics(),
      //   itemCount: value.length,
      //   itemBuilder: (context, index) {
      //     return card_tile();
      //   },
      // );

      // Add key and list widgets to columnChildren
      // columnChildren.add(listWidget);
      columnChildren.add(keyWidget);
      key != 'Log Out'
          ? columnChildren.add(
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(vertical: 18),
                width: MediaQuery.of(context).size.width - 44,
                color: ColorsApp.yellowbd.withOpacity(0.2),
              ),
            )
          : null;
    });

    // Return the Column widget with all the children
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnChildren,
    );
  }

  Widget buildColumnWithMap(Map<String, List<dynamic>> map) {
    List<Widget> columnChildren = [];

    map.forEach((key, value) {
      // Create a Text widget to display the key
      Widget keyWidget = Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          key,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: ColorsApp.grayText,
            height: 19.94 / 16,
          ),
        ),
      );

      // Create a ListView to display the list values
      // Widget listWidget = ListView.builder(
      //   shrinkWrap: true,
      //   physics: NeverScrollableScrollPhysics(),
      //   itemCount: value.length,
      //   itemBuilder: (context, index) {
      //     return card_tile();
      //   },
      // );
      Widget listWidget = Column(
        children: List.generate(value.length, (index) => card_tile()),
      );

      // Add key and list widgets to columnChildren
      columnChildren.add(listWidget);
      columnChildren.add(keyWidget);
    });

    // Return the Column widget with all the children
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: columnChildren,
    );
  }

  Row card_tile() {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Column(
                    children: List.generate(
                      45,
                      (index) => SizedBox(
                        height: 3,
                        child: CircleAvatar(
                          radius: 1,
                          backgroundColor: ColorsApp.grayText,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 15,
                  height: 15,
                  margin: EdgeInsets.only(top: 48),
                  decoration: BoxDecoration(
                    color: ColorsApp.yellowbd,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorsApp.yellowbd,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        card_tile_body(),
      ],
    );
  }

  Container card_tile_body() {
    return Container(
      width: MediaQuery.of(context).size.width - 50 - 80,
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: ColorsApp.grayInput,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('assets/images/place.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 7),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 248,
                height: 34,
                child: Text(
                  'The pristine nature of Kok-Zhailau',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 16.94 / 14,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width - 248,
                height: 15,
                child: Text(
                  'Almaty',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 14.52 / 12,
                    color: ColorsApp.grayText,
                  ),
                ),
              ),
              SizedBox(height: 85 - 34 - 4 - 15 - 15),
              SizedBox(
                width: MediaQuery.of(context).size.width - 248,
                height: 15,
                child: Text(
                  '\$ 1000',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 14.52 / 12,
                    color: ColorsApp.yellowbd,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _preferncies_body() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
      ),
      shrinkWrap: true,
      itemCount: 5,
      scrollDirection: Axis.vertical,
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 20.h,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {},
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              decoration: BoxDecoration(
                color: ColorsApp.grayInput,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 125.h,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/profile_1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FavoritePost(),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 11.w,
                              bottom: 11.h,
                              right: 20.w,
                            ),
                            child: CustomText(
                              text:
                                  'The pristine nature of Kok-Zhailau Kok-Zhailau',
                              colorText: ColorsApp.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 18.h,
                      horizontal: 15.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Duration',
                              colorText: ColorsApp.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            CustomText(
                              text: '10 - 12 h',
                              colorText: ColorsApp.mainColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Distance',
                              colorText: ColorsApp.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            CustomText(
                              text: '28 km',
                              colorText: ColorsApp.mainColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Level',
                              colorText: ColorsApp.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            CustomText(
                              text: 'Expert',
                              colorText: ColorsApp.mainColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: ColorsApp.black,
      toolbarHeight: 60.h,
      elevation: 0,
      automaticallyImplyLeading: false,
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
