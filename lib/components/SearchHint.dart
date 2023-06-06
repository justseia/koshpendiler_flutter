import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/colors.dart';

class SearchHint extends StatefulWidget {
  const SearchHint({Key? key}) : super(key: key);

  @override
  State<SearchHint> createState() => _SearchHintState();
}

class _SearchHintState extends State<SearchHint> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 282.w,
      child: TextFormField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        cursorColor: ColorsApp.mainColor,
        style: TextStyle(
          color: ColorsApp.white.withOpacity(.5),
        ),
        decoration: InputDecoration(
          prefixIcon: SvgPicture.asset(
            'assets/icons/inputSearch.svg',
            fit: BoxFit.scaleDown,
            height: 20.h,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 10.w,
          ),
          fillColor: ColorsApp.grayInput.withOpacity(.7),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
