// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koshpendiler/data/api_provider.dart';
import 'package:koshpendiler/screen/login/LoginScreen.dart';
import '../../core/colors.dart';
import '../../components/CustomText.dart';
import '../../components/FavoritePost.dart';
import '../../components/CustomSearch.dart';
import '../bottom/BottomBar.dart';
import 'places_bloc/places_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PlacesBloc>().add(PlacesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (context, state) {
        if (state is PlacesFailure && tokenBox.isEmpty) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
              return LoginScreen();
            }),
            (route) => false,
          );
        }
        return Scaffold(
          backgroundColor: ColorsApp.black,
          appBar: appBar(),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 20.h,
              bottom: 135.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                  ),
                  child: CustomSearch(),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                      ),
                      child: CustomText(
                        text: 'Explore'.toUpperCase(),
                        colorText: ColorsApp.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    SizedBox(
                      height: 475.h,
                      child: state is PlacesLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : state is PlacesFailure
                              ? Center(
                                  child: Text(
                                    'ERROR',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              : state is PlacesSuccess
                                  ? ListView.separated(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 30.w,
                                      ),
                                      shrinkWrap: true,
                                      itemCount: state.listPlaces.length,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              SizedBox(
                                        width: 22.w,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            print(state.listPlaces[index].id);
                                            Navigator.of(context).pushNamed(
                                              '/home_single',
                                              arguments:
                                                  state.listPlaces[index],
                                            );
                                          },
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                          ),
                                          child: place_tile(state, index),
                                        );
                                      },
                                    )
                                  : SizedBox(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ClipRRect place_tile(PlacesSuccess state, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        height: 475.h,
        width: 293.w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              state.listPlaces[index].image,
            ),
            // AssetImage(
            //     'assets/images/place.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorsApp.black.withOpacity(.2),
                ColorsApp.black.withOpacity(.9),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FavoritePost(),
              Padding(
                padding: EdgeInsets.only(
                  left: 21.w,
                  right: 33.w,
                  bottom: 18.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text:
                          // 'The pristine nature of Kok-Zhailau',
                          state.listPlaces[index].name,
                      colorText: ColorsApp.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomText(
                      text:
                          // 'Here you can have a great rest,'
                          //' enjoy the endless freedom of the '
                          //'lake: fishing, boat trips on a motor boat, '
                          //'fish soup right from the fire.',
                          state.listPlaces[index].body,
                      colorText: ColorsApp.grayText,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 75.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: ColorsApp.mainColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: CustomText(
                              // text: '\$ 1000',
                              text: '\$ ${state.listPlaces[index].cost}',
                              colorText: ColorsApp.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: ColorsApp.black,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Hello, Rose',
              colorText: ColorsApp.white.withOpacity(.8),
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
            ),
            Divider(
              thickness: 2,
              color: ColorsApp.white.withOpacity(.8),
            ),
          ],
        ),
      ),
    );
  }
}
