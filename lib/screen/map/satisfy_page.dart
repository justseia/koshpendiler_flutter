// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:koshpendiler/core/colors.dart';

TextEditingController _contr = TextEditingController();
int _indexSat = -1;
List<String> _wordsFirst = [
  'Interesting routes',
  'Clear Application',
  'Map features',
  'Smart filters',
  'Experienced guides',
  'Camera traps',
];
List<String> _wordsSecond = [
  'Mandatory registration',
  'High price',
  'Poor route planning',
  'Little choice',
];

class SatisfyPage extends StatefulWidget {
  const SatisfyPage({super.key});

  @override
  State<SatisfyPage> createState() => _SatisfyPageState();
}

class _SatisfyPageState extends State<SatisfyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 128,
                    child: Text(
                      'Are you satisfied with this trip ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 31.47 / 26,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  emojies_body(context),
                  Expanded(
                    child: _indexSat != -1
                        ? Center(
                            child: Wrap(
                              spacing: 20,
                              runSpacing: 13,
                              children: List.generate(
                                _indexSat == 0
                                    ? _wordsFirst.length
                                    : _wordsSecond.length,
                                (index) => Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 18),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(53),
                                    color: ColorsApp.grayInput,
                                  ),
                                  child: Text(
                                    _indexSat == 0
                                        ? _wordsFirst[index]
                                        : _wordsSecond[index],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      height: 16.94 / 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
                  input_widget()
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/map_success_page');
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 30),
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: ColorsApp.yellowbd,
                  borderRadius: BorderRadius.circular(53),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 19.36 / 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row emojies_body(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _indexSat = 0;
            });
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - 56 - 34) / 2,
            padding: EdgeInsets.symmetric(vertical: 19),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: _indexSat == 0 ? ColorsApp.yellowbd : ColorsApp.grayText,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Satisfied',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: _indexSat == 0
                        ? ColorsApp.yellowbd
                        : ColorsApp.grayText,
                  ),
                ),
                SizedBox(height: 12),
                Iconify(
                  Bi.emoji_heart_eyes,
                  size: 45,
                  color:
                      _indexSat == 0 ? ColorsApp.yellowbd : ColorsApp.grayText,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 34),
        GestureDetector(
          onTap: () {
            setState(() {
              _indexSat = 1;
            });
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - 56 - 34) / 2,
            padding: EdgeInsets.symmetric(vertical: 19),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: _indexSat == 1 ? ColorsApp.yellowbd : ColorsApp.grayText,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Dissatisfied',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: _indexSat == 1
                        ? ColorsApp.yellowbd
                        : ColorsApp.grayText,
                  ),
                ),
                SizedBox(height: 12),
                Iconify(
                  Mdi.emoticon_cry_outline,
                  color:
                      _indexSat == 1 ? ColorsApp.yellowbd : ColorsApp.grayText,
                  size: 45,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column input_widget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leave a review',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Colors.white,
            height: 16.94 / 14,
          ),
        ),
        SizedBox(height: 10),
        TextField(
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 14.54 / 12,
          ),
          controller: _contr,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: ColorsApp.grayText,
                width: 1.0,
              ),
            ),
            hintText: 'Type here',
            hintStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ColorsApp.grayText,
              height: 14.54 / 12,
            ),
          ),
        ),
        SizedBox(height: 80),
      ],
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leadingWidth: 30,
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: 50,
          height: 50,
          constraints: BoxConstraints(maxHeight: 50),
          // margin: EdgeInsets.only(left: 30),
          decoration: BoxDecoration(
            color: ColorsApp.black2c.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.close,
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
