// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/CustomButtonWithBack.dart';
import '../../../components/CustomText.dart';
import '../../../core/colors.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 20.h,
                bottom: 50.h,
                left: 27.w,
                right: 27.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  top_widget(),
                  SizedBox(height: 27),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 16.94 / 14,
                          color: ColorsApp.grayText,
                        ),
                      ),
                      Text(
                        '\$ 1000',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 16.94 / 14,
                          color: ColorsApp.grayText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 16.94 / 14,
                          color: ColorsApp.grayText,
                        ),
                      ),
                      Text(
                        '\$ 0',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 16.94 / 14,
                          color: ColorsApp.grayText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 16.94 / 14,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '\$ 1000',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 16.94 / 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 27),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: ColorsApp.grayText,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Payment method',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white,
                      height: 16.96 / 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                    decoration: BoxDecoration(
                      color: ColorsApp.grayInput,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Visa •••• 6620',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 14.52 / 12,
                              ),
                            ),
                            Container(
                              height: 10,
                              width: 33,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/icons/visa_grey.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Charged from the selected card',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: ColorsApp.grayText,
                            height: 1.21,
                          ),
                        ),
                      ],
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

  ClipRRect top_widget() {
    return ClipRRect(
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
                    text: 'The pristine nature of Kok-Zhailau Kok-Zhailau',
                    colorText: ColorsApp.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Column(
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceBetween,
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
                            fontWeight: FontWeight.w500,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
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
                            fontWeight: FontWeight.w500,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
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
                            fontWeight: FontWeight.w500,
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
            buttonText: 'Buy for \$1000',
            routeName: '/payment_page',
            buttonColor: ColorsApp.disableButton,
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.arrow_back_ios,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        'Payment',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          height: 26.63 / 22,
        ),
      ),
      centerTitle: true,
    );
  }
}
