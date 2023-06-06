import 'package:flutter/material.dart';
import './CustomText.dart';

class CustomInkWell extends StatefulWidget {
  const CustomInkWell({
    Key? key,
    required this.width,
    required this.height,
    required this.inkWellText,
    required this.colorText,
    required this.sizeText,
    required this.fontWeight,
    required this.routeName,
  }) : super(key: key);

  final double width;
  final double height;
  final String inkWellText;
  final Color colorText;
  final double sizeText;
  final FontWeight fontWeight;
  final String routeName;

  @override
  State<CustomInkWell> createState() => _CustomInkWellState();
}

class _CustomInkWellState extends State<CustomInkWell> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          widget.routeName,
          (Route<dynamic> route) => false,
        );
      },
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Center(
          child: CustomText(
            text: widget.inkWellText,
            colorText: widget.colorText,
            fontSize: widget.sizeText,
            fontWeight: widget.fontWeight,
          ),
        ),
      ),
    );
  }
}
