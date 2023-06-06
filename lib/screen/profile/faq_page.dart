// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koshpendiler/core/colors.dart';

List<String> _keys = [
  'General',
  'Login',
  'Account',
  'Message',
  'Tour',
];
int _keyIndex = 0;

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  double maxWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                height: 1,
                width: maxWidth(context) - 44,
                margin: EdgeInsets.symmetric(vertical: 20),
                color: ColorsApp.yellowbd,
              ),
              keys_body(),
              SizedBox(height: 35),
              // question_tile(context),
              Column(
                children: List.generate(8, (index) => question_tile(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container question_tile(BuildContext context) {
    return Container(
      width: maxWidth(context) - 44,
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      margin: EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(
        color: ColorsApp.grayInput,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(
            width: maxWidth(context) - 44 - 40 - 24,
            child: Text(
              'What is Koshpendiler?',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 14.52 / 12,
              ),
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: ColorsApp.yellowbd,
            shadows: [
              BoxShadow(
                color: ColorsApp.yellowbd,
                blurRadius: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  SingleChildScrollView keys_body() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          _keys.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _keyIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(vertical: 9, horizontal: 16),
              decoration: BoxDecoration(
                color: _keyIndex == index ? ColorsApp.yellowbd : Colors.black,
                borderRadius: BorderRadius.circular(53),
                border: Border.all(color: ColorsApp.yellowbd, width: 1),
              ),
              child: Text(
                _keys[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _keyIndex == index ? Colors.white : ColorsApp.yellowbd,
                  height: 14.52 / 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      title: Text(
        'FAQ',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          height: 25.63 / 22,
        ),
      ),
    );
  }
}
