import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/colors.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({Key? key}) : super(key: key);

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        suffixIcon: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(100),
          child: SvgPicture.asset(
            'assets/icons/inputFilter.svg',
            fit: BoxFit.scaleDown,
            height: 20.h,
          ),
        ),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: ColorsApp.white.withOpacity(.5),
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 10.w,
        ),
        fillColor: ColorsApp.grayText.withOpacity(.2),
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
    );
  }
}
