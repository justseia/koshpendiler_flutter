import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  const CustomText({
    Key? key,
    required this.text,
    required this.colorText,
    required this.fontSize,
    required this.fontWeight,
    this.textOverflow = TextOverflow.visible,
  }) : super(key: key);



  final String text;
  final Color colorText;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow textOverflow;

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      overflow: widget.textOverflow,
      style: TextStyle(
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
        color: widget.colorText,
      ),
    );
  }
}
