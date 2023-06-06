// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors.dart';
import '../../components/CustomSearch.dart';
import '../../components/CustomText.dart';
import '../../components/FavoritePost.dart';
import '../../components/NotificationButton.dart';
import 'animal_bloc/animal_bloc.dart';

class CameraTrapScreen extends StatefulWidget {
  const CameraTrapScreen({Key? key}) : super(key: key);

  @override
  State<CameraTrapScreen> createState() => _CameraTrapScreenState();
}

class _CameraTrapScreenState extends State<CameraTrapScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('CameraTrapScreen');
    context.read<AnimalBloc>().add(AnimalEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimalBloc, AnimalState>(
      builder: (context, state) {
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
                        text: 'More searched cameras'.toUpperCase(),
                        colorText: ColorsApp.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    state is AnimalLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : state is AnimalFailure
                            ? Center(
                                child: Text(
                                  'ERROR',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            : state is AnimalSuccess
                                ? ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 30.w,
                                    ),
                                    shrinkWrap: true,
                                    itemCount: state.animals_list.length,
                                    scrollDirection: Axis.vertical,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(
                                      height: 20.w,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          print(state.animals_list[index].id);
                                          Navigator.of(context).pushNamed(
                                            '/camera_single_post',
                                            arguments:
                                                state.animals_list[index],
                                          );
                                        },
                                        customBorder: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: ColorsApp.grayInput,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 225.h,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        bottom:
                                                            Radius.circular(20),
                                                      ),
                                                      image: DecorationImage(
                                                        // image: AssetImage(
                                                        //     'assets/images/animals.png'),
                                                        image: NetworkImage(
                                                          state
                                                              .animals_list[
                                                                  index]
                                                              .images[0],
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    child: FavoritePost(),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 13.h,
                                                    horizontal: 15.w,
                                                  ),
                                                  child: CustomText(
                                                    // text:
                                                    //     'The pristine nature of Kok-Zhailau Kok-Zhailau',
                                                    text: state
                                                        .animals_list[index]
                                                        .name,
                                                    colorText: ColorsApp.white,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: ColorsApp.black,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30.w,
                ),
                CustomText(
                  text: 'Camera Trap',
                  colorText: ColorsApp.white.withOpacity(.8),
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
                NotificationButton(),
              ],
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
