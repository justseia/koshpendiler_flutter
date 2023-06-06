// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/colors.dart';
import '../../components/CustomText.dart';
import '../../components/FavoritePost.dart';
import '../../components/CustomButtonWithBack.dart';
import '../../model/Place.dart';

class HomeSingleScreen extends StatefulWidget {
  const HomeSingleScreen({Key? key, required this.place}) : super(key: key);
  final Place place;

  @override
  State<HomeSingleScreen> createState() => _HomeSingleScreenState();
}

class _HomeSingleScreenState extends State<HomeSingleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ColorsApp.black,
      appBar: appBar(),
      body: body(),
    );
  }

  SingleChildScrollView body() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 135.h,
        bottom: 50.h,
        left: 30.w,
        right: 30.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              decoration: BoxDecoration(
                color: ColorsApp.grayInput,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 330.h,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          // image: AssetImage('assets/images/place.png'),
                          image: NetworkImage(widget.place.image),
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
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: ColorsApp.black.withOpacity(.6),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/location.svg',
                                    fit: BoxFit.scaleDown,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  CustomText(
                                    // text: 'Eastern Kazakhstan',
                                    text: widget.place.location_short,
                                    colorText: ColorsApp.white.withOpacity(.8),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
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
                            SvgPicture.asset(
                              'assets/icons/clock.svg',
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            CustomText(
                              // text: '10 - 12 h',
                              text: widget.place.duration,
                              colorText: ColorsApp.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/way.svg',
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            CustomText(
                              // text: '28 km',
                              text: widget.place.distance,
                              colorText: ColorsApp.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/star.svg',
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            CustomText(
                              // text: 'Expert',
                              text: widget.place.level,
                              colorText: ColorsApp.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
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
          SizedBox(
            height: 20.h,
          ),
          CustomText(
            text: 'Clear Filters',
            colorText: ColorsApp.mainColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 25.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    // text: 'The pristine nature of Kok-Zhailau',
                    text: widget.place.name,
                    colorText: ColorsApp.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    // text: 'Altai | Eastern Kazakhstan ',
                    text: widget.place.location_short,
                    colorText: ColorsApp.grayText,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          CustomText(
            // text: 'Kok-Zhailau is a tract on the territory of the '
            //     'Ile-Alatau National Park. Kok-Zhailau will appeal '
            //     'to lovers of hiking. Difficulty level: medium. To '
            //     'hike in the mountains, you need to arm yourself with '
            //     'alpenstocks. Going a little further, you can climb to '
            //     'the top called "Three Brothers" or "Kumbel" peak. ',
            text: widget.place.body,
            colorText: ColorsApp.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomText(
            text: 'To destination:',
            colorText: ColorsApp.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 6.h,
          ),
          CustomText(
            // text: 'Depends on the rate of ascent. On average - 2.5 - 3 hours',
            text: widget.place.to_destination,
            colorText: ColorsApp.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomText(
            text: 'With you:',
            colorText: ColorsApp.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 6.h,
          ),
          CustomText(
            // text:
            //     'Trekking shoes, insect repellant spray, hat, sunscreen and goggles, water, snack',
            text: widget.place.with_you,
            colorText: ColorsApp.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomText(
            text: 'Location:',
            colorText: ColorsApp.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 6.h,
          ),
          CustomText(
            // text:
            //     '10 km from the city of Almaty. Height - 1740 m above sea level',
            text: widget.place.location,
            colorText: ColorsApp.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomButtonWithBack(
            // buttonText: 'Buy for \$1000',
            buttonText: 'Buy for \$${widget.place.cost}',
            routeName: '/home_payment',
            buttonColor: ColorsApp.mainColor,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomButtonWithBack(
            buttonText: 'Book a trip',
            routeName: '/',
            buttonColor: ColorsApp.grayInput,
            clickButton: false,
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: ColorsApp.transparent,
      elevation: 0,
      toolbarHeight: 60.h,
      title: CustomText(
        text: 'Kok-Zhailau',
        colorText: ColorsApp.white,
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
