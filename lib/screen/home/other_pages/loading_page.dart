// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:koshpendiler/core/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

double percentage = 73; // from 0 to 100

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.whiteRozoviy,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacer(),
          SizedBox(
            height: 200,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  interval: 10,
                  startAngle: -90,
                  endAngle: 270,
                  showTicks: false,
                  showLabels: false,
                  axisLineStyle:
                      AxisLineStyle(thickness: 10, color: Colors.black),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: percentage,
                      width: 10,
                      color: ColorsApp.mainColor,
                      enableAnimation: true,
                      cornerStyle: CornerStyle.bothCurve,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 53),
          Text(
            'Total amount is counting ',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: ColorsApp.mainColor,
              height: 27 / 22,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'wait for few minutes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 19 / 16,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
