// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/colors.dart';
import '../../components/CustomText.dart';
import '../../components/FavoritePost.dart';
import '../../components/CustomButtonWithBack.dart';

class HomePaymentScreen extends StatefulWidget {
  const HomePaymentScreen({Key? key}) : super(key: key);

  @override
  State<HomePaymentScreen> createState() => _HomePaymentScreenState();
}

class _HomePaymentScreenState extends State<HomePaymentScreen> {
  bool discount = false;
  bool location = false;

  final TextEditingController _discountPromocode = TextEditingController();
  // bool _clickPromocode = false;

  @override
  void initState() {
    super.initState();
    // _discountPromocode.addListener(() {
    //   setState(() {
    //     _clickPromocode = _discountPromocode.text.isNotEmpty ? true : false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ColorsApp.black,
      appBar: appBar(),
      body: body(),
    );
  }

  SafeArea body() {
    return SafeArea(
      top: false,
      child: Stack(
        children: [
          SingleChildScrollView(
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
                          height: 125.h,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                image: AssetImage('assets/images/place.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 26.h,
                            horizontal: 15.w,
                          ),
                          child: Column(
                            children: [
                              CustomText(
                                text:
                                    'The pristine nature of Kok-Zhailau Kok-Zhailau',
                                colorText: ColorsApp.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        colorText: ColorsApp.white,
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
                                        colorText: ColorsApp.white,
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
                                        colorText: ColorsApp.white,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w300,
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                    ],
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
                  height: 45.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoSwitch(
                      activeColor: ColorsApp.mainColor,
                      trackColor: ColorsApp.grayInput,
                      value: discount,
                      onChanged: (value) => setState(
                        () => discount = !discount,
                      ),
                    ),
                    CustomText(
                      text: 'I have discount',
                      colorText: ColorsApp.grayText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                Visibility(
                  visible: discount,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'Promocode',
                              colorText: ColorsApp.grayText,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: _discountPromocode,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                cursorColor: ColorsApp.mainColor,
                                style: TextStyle(
                                  color: ColorsApp.grayText,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorsApp.grayInput,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.r),
                                    borderSide: BorderSide(
                                        width: 1, color: ColorsApp.grayText),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.r),
                                    borderSide: BorderSide(
                                        width: 1, color: ColorsApp.grayText),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 13.w,
                                    vertical: 9.h,
                                  ),
                                  hintText: 'Type your promocode here',
                                  hintStyle: TextStyle(
                                    color: ColorsApp.grayText.withOpacity(.45),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ElevatedButton(
                          onPressed:
                              _discountPromocode.text.isNotEmpty ? () {} : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsApp.mainColor,
                            disabledBackgroundColor: ColorsApp.disableButton,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            minimumSize: Size(double.infinity, 36.h),
                          ),
                          child: CustomText(
                            text: 'Accept promocode',
                            colorText: ColorsApp.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoSwitch(
                      activeColor: ColorsApp.mainColor,
                      trackColor: ColorsApp.grayInput,
                      value: location,
                      onChanged: (value) => setState(
                        () => location = !location,
                      ),
                    ),
                    CustomText(
                      text: 'I need a transfer from my home',
                      colorText: ColorsApp.grayText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(
                  height: 45.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Subtotal',
                      colorText: ColorsApp.grayText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: '\$${1000}',
                      colorText: ColorsApp.grayText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Discount',
                      colorText: ColorsApp.grayText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: '\$${0}',
                      colorText: ColorsApp.grayText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Total',
                      colorText: ColorsApp.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: '\$${1000}',
                      colorText: ColorsApp.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButtonWithBack(
                buttonText: 'Buy for \$1000',
                routeName: 'routeName',
                buttonColor: ColorsApp.mainColor,
              ),
            ),
          )
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
        text: 'Payment',
        colorText: ColorsApp.white,
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
