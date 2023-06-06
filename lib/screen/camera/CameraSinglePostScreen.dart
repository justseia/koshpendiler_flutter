// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/CustomText.dart';
import '../../core/colors.dart';
import '../../model/animal.dart';

class CameraSinglePost extends StatefulWidget {
  const CameraSinglePost({Key? key, required this.animal}) : super(key: key);
  final Animal animal;

  @override
  State<CameraSinglePost> createState() => _CameraSinglePostState();
}

class _CameraSinglePostState extends State<CameraSinglePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: body(),
    );
  }

  Container body() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          // image: AssetImage('assets/images/animals_1.png'),
          image: NetworkImage(
            widget.animal.images[0],
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemCount: widget.animal.images.length,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 25.h,
            ),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  showPhoto(index);
                },
                child: SizedBox(
                  height: 64.w,
                  width: 64.h,
                  // child: Image.asset(
                  //   'assets/images/animals_2.png',
                  //   width: 64.w,
                  //   height: 64.h,
                  //   fit: BoxFit.scaleDown,
                  // ),
                  child: Image.network(widget.animal.images[index]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  showPhoto(int id) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.r),
          topRight: Radius.circular(50.r),
        ),
      ),
      builder: (builder) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.r),
            topRight: Radius.circular(50.r),
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                // image: AssetImage('assets/images/animals.png'),
                image: NetworkImage(widget.animal.images[id]),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 34.w,
                    vertical: 26.h,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset('assets/icons/close.svg'),
                  ),
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
      automaticallyImplyLeading: false,
      backgroundColor: ColorsApp.transparent,
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    height: 30.h,
                    width: 30.w,
                    child: SvgPicture.asset(
                      'assets/icons/back.svg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                CustomText(
                  text: 'Camera Trap',
                  colorText: ColorsApp.white.withOpacity(.8),
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
                SvgPicture.asset(
                  'assets/icons/infoPost.svg',
                  height: 22.h,
                  fit: BoxFit.scaleDown,
                ),
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
