// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koshpendiler/core/colors.dart';

bool _messageNotif = false;
bool _groupNotif = false;

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
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
              message_notif(context),
              SizedBox(height: 30),
              group_notif(context),
              SizedBox(height: 40),
              all_notif(context),
              SizedBox(height: 10),
              SizedBox(
                width: maxWidth(context) - 56,
                child: Text(
                  'Viewing the message text in the notification window',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: ColorsApp.grayText,
                    height: 14.52 / 12,
                  ),
                ),
              ),
              SizedBox(height: 28),
              reset_button(context),
              SizedBox(height: 10),
              SizedBox(
                width: maxWidth(context) - 56,
                child: Text(
                  'Reset all notification settings, '
                  'including individual notification settings for chats',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: ColorsApp.grayText,
                    height: 14.52 / 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget reset_button(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
      },
      child: Container(
        width: maxWidth(context) - 30,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: ColorsApp.grayInput,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Reset Notification Settings',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.red,
            height: 19.36 / 16,
          ),
        ),
      ),
    );
  }

  Widget all_notif(BuildContext context) {
    return Container(
      width: maxWidth(context) - 30,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: ColorsApp.grayInput,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Show notifications',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 19.36 / 16,
            ),
          ),
          CupertinoSwitch(
            value: _groupNotif,
            onChanged: (val) {
              setState(() {
                _groupNotif = val;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget group_notif(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: maxWidth(context) - 64,
          child: Text(
            'Group Notification',
            style: tsgr_16_500_19(),
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: maxWidth(context) - 30,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: ColorsApp.grayInput,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Show notifications',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 19.36 / 16,
                    ),
                  ),
                  CupertinoSwitch(
                    value: _groupNotif,
                    onChanged: (val) {
                      setState(() {
                        _groupNotif = val;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Sound',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 19.36 / 16,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Note',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorsApp.grayText,
                      height: 19.36 / 16,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: ColorsApp.grayText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column message_notif(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: maxWidth(context) - 64,
          child: Text(
            'Message Notification',
            style: tsgr_16_500_19(),
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: maxWidth(context) - 30,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: ColorsApp.grayInput,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Show notifications',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 19.36 / 16,
                    ),
                  ),
                  CupertinoSwitch(
                    value: _messageNotif,
                    onChanged: (val) {
                      setState(() {
                        _messageNotif = val;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Sound',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 19.36 / 16,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Note',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorsApp.grayText,
                      height: 19.36 / 16,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: ColorsApp.grayText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextStyle tsgr_16_500_19() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: ColorsApp.grayText,
      height: 19.36 / 16,
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
        'Notifications',
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
