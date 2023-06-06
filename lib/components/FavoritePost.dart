import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/colors.dart';

class FavoritePost extends StatefulWidget {
  const FavoritePost({Key? key}) : super(key: key);

  @override
  State<FavoritePost> createState() => _FavoritePostState();
}

class _FavoritePostState extends State<FavoritePost> {
  late bool selectedFavorite = false;

  @override
  void initState() {
    super.initState();
    selectedFavorite = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 33.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                selectedFavorite = !selectedFavorite;
              });
            },
            child: SvgPicture.asset(
              'assets/icons/favorite.svg',
              fit: BoxFit.fitHeight,
              color: selectedFavorite ? ColorsApp.mainColor : ColorsApp.white,
              height: 60.h,
            ),
          ),
        ],
      ),
    );
  }
}
