// import 'package:auto_like_1/models/bank_karta_model.dart';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'colors.dart';
import 'textStyles.dart';

bool isWritten = false;
// TextStyle ts = const TextStyle(
//   fontFamily: 'Gilroy',
//   fontStyle: FontStyle.normal,
//   fontWeight: FontWeight.w600,
//   fontSize: 16,
//   letterSpacing: 1,
//   color: Color(0xFF333333),
// );
// TextStyle tsHint = const TextStyle(
//   fontFamily: 'Gilroy',
//   fontStyle: FontStyle.normal,
//   fontWeight: FontWeight.w600,
//   fontSize: 16,
//   letterSpacing: 1,
//   color: Color(0xFFC3C3C3),
// );
// int? id;
// String? type; // visa ili mastercard
// String? numberKarta; // 4400 5500 00044 7788
// String? name_surname;
// int? month;
// int? year;
// int? cvc;
// TextEditingController nomerKartyController =
//     TextEditingController(text: '4400 - 4568 - 455|');
// TextEditingController imyaController = TextEditingController();
// TextEditingController timeController = TextEditingController();
// TextEditingController cvcController = TextEditingController();

BoxDecoration bd = BoxDecoration(
  color: white,
  borderRadius: BorderRadius.circular(5),
);
// Color color_green = const Color(0xff2DC36A);
// Color color_grey = const Color(0xff999999);

class AlertDialogBody extends StatefulWidget {
  const AlertDialogBody({
    required this.filePath,
    required this.sendImage,
  });
  // final BuildContext contextt;
  final String filePath;
  final Function sendImage;

  @override
  State<AlertDialogBody> createState() => _AlertDialogBodyState();
}

class _AlertDialogBodyState extends State<AlertDialogBody> {
  List<XFile> images = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // images.add(widget.file);
  }

  @override
  Widget build(BuildContext contextt) {
    double maxwidthAlert = MediaQuery.of(contextt).size.width;

    return AlertDialog(
      // backgroundColor: const Color(0xffF1F2F2),
      backgroundColor: whitef8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide.none,
      ),
      insetPadding: const EdgeInsets.all(8),
      titlePadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      // contentPadding: EdgeInsets.all(20),
      title: Container(
        padding: const EdgeInsets.all(20),
        width: maxwidthAlert - 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 14),
            topBody(contextt),
            Container(
              width: maxwidthAlert - 40,
              height: maxwidthAlert - 40,
              margin: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: FileImage(File(widget.filePath)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            button(maxwidthAlert, contextt),
          ],
        ),
      ),
    );
  }

  Row topBody(BuildContext contextt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Добавить публикацию',
          // style: TextStyle(
          //   fontSize: 20,
          //   fontWeight: FontWeight.w600,
          //   letterSpacing: 0.5,
          //   color: black11,
          // ),
          style: ts0c_20_600_30_06,
        ),
        closeIcon(contextt),
      ],
    );
  }

  InkWell button(double maxW, BuildContext contextt) {
    return InkWell(
      onTap: () {
        widget.sendImage();
        Navigator.of(contextt).pop();
      },
      child: Container(
        // margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: maxW - 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: blueDark,
        ),
        alignment: Alignment.center,
        child: Text(
          'Добавить публикацию',
          // style: TextStyle(
          //   fontSize: 18,
          //   fontWeight: FontWeight.w700,
          //   color: whitef4,
          // ),
          style: tswh_16_700,
        ),
      ),
    );
  }

  Widget closeIcon(BuildContext contextt) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: blueDark.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.clear,
          color: black0C,
          size: 24,
        ),
      ),
    );
  }
}
