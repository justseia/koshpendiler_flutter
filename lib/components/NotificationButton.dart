import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koshpendiler/screen/bottom/BottomBar.dart';

class NotificationButton extends StatefulWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // setState(() {});
        Navigator.of(context).pushNamed('/notifications');
      },
      borderRadius: BorderRadius.circular(100),
      child: SizedBox(
        height: 30,
        width: 30,
        child: SvgPicture.asset(
          'assets/icons/notification.svg',
          height: 16.h,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
