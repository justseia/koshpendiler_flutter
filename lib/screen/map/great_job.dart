// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:koshpendiler/core/colors.dart';

class GreatJobPage extends StatefulWidget {
  const GreatJobPage({super.key});

  @override
  State<GreatJobPage> createState() => _GreatJobPageState();
}

class _GreatJobPageState extends State<GreatJobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Container(
                    height: 220,
                    width: 220,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/mountains.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 42),
                  Text(
                    'Great job !',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 31.47 / 26,
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 96,
                    child: Text(
                      'You have reached your goal \n'
                      'May you have more trips to the mountains',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: ColorsApp.grayText,
                        height: 16.94 / 14,
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/satisfy');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: ColorsApp.yellowbd,
                        borderRadius: BorderRadius.circular(53),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Take the Survey',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 19.36 / 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 144,
                    child: Text(
                      'By completing this survey, you not only help'
                      ' us to improve our application, but also get 1 coin',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: ColorsApp.grayText,
                        height: 1.21,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/satisfy');
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
                  'Finish Trip',
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
}
