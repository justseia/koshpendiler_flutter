// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koshpendiler/model/card_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../components/CustomButtonWithBack.dart';
import '../../../components/CustomText.dart';
import '../../../core/colors.dart';
import '../../profile/profile_me_bloc/profile_me_bloc.dart';
import 'bloc/card_save_bloc.dart';

TextEditingController _nameContr = TextEditingController();
TextEditingController _numberContr = TextEditingController();
TextEditingController _dateContr = TextEditingController();
TextEditingController _cvcContr = TextEditingController();

var numberFormatter = MaskTextInputFormatter(
  mask: '#### #### #### ####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);
var dateFormatter = MaskTextInputFormatter(
  mask: '##/####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

bool _hide = true;

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CardSaveBloc>().add(GetMe());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardSaveBloc, CardSaveState>(
      builder: (context, state) {
        if (state is CardSaveSuccessSaveCard) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/success_page',
              (Route<dynamic> route) => false,
            );
          });
        }
        return Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: true,
          appBar: appBar(),
          body: state is CardSaveLoadingMe
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: Colors.white),
                    ],
                  ),
                )
              : state is CardSaveFailureGetMe
                  ? Center(
                      child: Text(
                        'ERROR in getting profile info',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : state is CardSaveSuccessGetMe ||
                          state is CardSaveFailureSaveCard ||
                          state is CardSaveLoadingSave
                      ? GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 22),
                                        card_widget(),
                                        SizedBox(height: 32),
                                        card_name(),
                                        SizedBox(height: 20),
                                        card_number(),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Expanded(child: card_date()),
                                            SizedBox(width: 40),
                                            Expanded(child: card_cvc()),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              button(state)
                            ],
                          ),
                        )
                      : SizedBox(
                          child: Text(
                            'INITIAL STATE',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
        );
      },
    );
  }

  Column card_number() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card number',
          style: tswh_12_300_14(),
        ),
        // SizedBox(height: 12),
        TextField(
          style: tswh_12_300_14(),
          keyboardType: TextInputType.number,
          controller: _numberContr,
          inputFormatters: [numberFormatter],
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            // labelText: 'Inline Decoration',
            hintText: 'Write card number',
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              height: 19.36 / 16,
              color: Colors.white38,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ],
    );
  }

  Column card_cvc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CVC',
          style: tswh_12_300_14(),
        ),
        // SizedBox(height: 12),
        TextField(
          style: tswh_12_300_14(),
          keyboardType: TextInputType.number,
          controller: _cvcContr,
          obscureText: _hide,
          maxLength: 3,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            // labelText: 'Inline Decoration',
            counter: SizedBox(),
            hintText: 'CVC',
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              height: 19.36 / 16,
              color: Colors.white38,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _hide ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _hide = !_hide;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Column card_date() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expire date',
          style: tswh_12_300_14(),
        ),
        // SizedBox(height: 12),
        TextField(
          style: tswh_12_300_14(),
          keyboardType: TextInputType.datetime,
          controller: _dateContr,
          inputFormatters: [dateFormatter],
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            // labelText: 'Inline Decoration',
            hintText: 'month/year',
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              height: 19.36 / 16,
              color: Colors.white38,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ],
    );
  }

  Column card_name() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card holder',
          style: tswh_12_300_14(),
        ),
        // SizedBox(height: 12),
        TextField(
          style: tswh_12_300_14(),
          keyboardType: TextInputType.name,
          controller: _nameContr,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            // labelText: 'Inline Decoration',
            hintText: 'Write card holder\'s name',
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              height: 19.36 / 16,
              color: Colors.white38,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle tswh_12_300_14() {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      height: 14.52 / 12,
      color: Colors.white,
    );
  }

  Container card_widget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 34),
      decoration: BoxDecoration(
        color: ColorsApp.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/card_chip.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 33),
          Text(
            _numberContr.text.isEmpty
                ? 'XXXX XXXX XXXX XXXX'
                : _numberContr.text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 19.36 / 16,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _dateContr.text.isEmpty ? 'mm/yyyy' : _dateContr.text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 19.36 / 16,
                  fontFamily: 'Inter',
                ),
              ),
              Container(
                width: 52,
                height: 16,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/visa.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  SafeArea button(CardSaveState state) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30.w,
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pushNamed(
              //   widget.routeName,
              // );
              FocusManager.instance.primaryFocus?.unfocus();

              if (_nameContr.text.isNotEmpty &&
                  _numberContr.text.isNotEmpty &&
                  _dateContr.text.isNotEmpty &&
                  _cvcContr.text.isNotEmpty) {
                context.read<CardSaveBloc>().add(
                      SaveCard(
                        cm: CardModel(
                          user_id: _nameContr.text,
                          full_name: state is CardSaveSuccessGetMe
                              ? state.pm.email!
                              : _nameContr.text,
                          number: _numberContr.text,
                          date: _dateContr.text,
                          cvc: _cvcContr.text,
                        ),
                      ),
                    );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsApp.disableButton,
              disabledBackgroundColor: ColorsApp.disableButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(53.r),
              ),
              minimumSize: Size(double.infinity, 50.h),
            ),
            child: CustomText(
              text: state is CardSaveLoadingSave
                  ? 'Saving ...'
                  : state is CardSaveFailureSaveCard
                      ? 'Failed :('
                      : 'Save',
              colorText: ColorsApp.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          //  CustomButtonWithBack(
          //   buttonText: 'Save',
          //   routeName: '/success_page',
          //   buttonColor: ColorsApp.disableButton,
          //   clickButton: _nameContr.text.isNotEmpty &&
          //       _dateContr.text.isNotEmpty &&
          //       _numberContr.text.isNotEmpty &&
          //       _cvcContr.text.isNotEmpty,
          // ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leading: Container(
        margin: EdgeInsets.only(left: 20),
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: 28,
        ),
      ),
      centerTitle: true,
      title: Text(
        'Add card',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
