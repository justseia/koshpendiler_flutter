// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors.dart';
import '../../components/CustomButton.dart';
import '../../components/CustomInkWell.dart';
import '../../components/CustomInput.dart';
import '../../components/AppleAuth.dart';
import '../../components/CustomText.dart';
import '../../components/GoogleAuth.dart';
import 'bloc/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameTextEditing = TextEditingController();
  final TextEditingController _emailTextEditing = TextEditingController();
  final TextEditingController _passwordTextEditing = TextEditingController();
  final TextEditingController _phoneTextEditing = TextEditingController();
  bool _clickButton = false;

  @override
  void initState() {
    super.initState();
    _nameTextEditing.addListener(() {
      setState(() {
        _clickButton = _nameTextEditing.text.isNotEmpty &&
                _emailTextEditing.text.isNotEmpty &&
                _passwordTextEditing.text.isNotEmpty
            ? true
            : false;
      });
    });
    _emailTextEditing.addListener(() {
      setState(() {
        _clickButton = _nameTextEditing.text.isNotEmpty &&
                _emailTextEditing.text.isNotEmpty &&
                _passwordTextEditing.text.isNotEmpty
            ? true
            : false;
      });
    });
    _passwordTextEditing.addListener(() {
      setState(() {
        _clickButton = _nameTextEditing.text.isNotEmpty &&
                _emailTextEditing.text.isNotEmpty &&
                _passwordTextEditing.text.isNotEmpty
            ? true
            : false;
      });
    });
  }

  @override
  void dispose() {
    _nameTextEditing.dispose();
    _emailTextEditing.dispose();
    _passwordTextEditing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        if (state is RegisterSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/login',
              (Route<dynamic> route) => false,
            );
          });
        }
        return Scaffold(
          backgroundColor: ColorsApp.black,
          resizeToAvoidBottomInset: true,
          body: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SafeArea(
              top: true,
              bottom: true,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        CustomText(
                          text: 'Create a new account',
                          colorText: ColorsApp.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomText(
                          text: 'Fill all forms to continue',
                          colorText: ColorsApp.grayText,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 45.h,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 388.h,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomInput(
                              controller: _nameTextEditing,
                              inputUpText: 'Name',
                              hintText: 'Enter your name',
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            CustomInput(
                              controller: _emailTextEditing,
                              inputUpText: 'Email',
                              hintText: 'Enter your email',
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 25.w,
                                    bottom: 5.h,
                                  ),
                                  child: CustomText(
                                    text: 'Phone number',
                                    colorText: ColorsApp.grayText,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextFormField(
                                  controller: _phoneTextEditing,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ColorsApp.mainColor,
                                  style: TextStyle(
                                    color: ColorsApp.grayText.withOpacity(.45),
                                  ),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.r),
                                      borderSide: BorderSide(
                                          width: 2, color: ColorsApp.grayInput),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.r),
                                      borderSide: BorderSide(
                                          width: 2, color: ColorsApp.grayInput),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 25.w,
                                      vertical: 18.h,
                                    ),
                                    hintText: 'Enter your phone number',
                                    hintStyle: TextStyle(
                                      color:
                                          ColorsApp.grayText.withOpacity(.45),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            CustomInput(
                              controller: _passwordTextEditing,
                              inputUpText: 'Password',
                              hintText: 'Enter your password',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        CustomButton(
                          onTapp: () {
                            // print(_nameTextEditing.text.isNotEmpty &&
                            //     _emailTextEditing.text.isNotEmpty &&
                            //     _passwordTextEditing.text.isNotEmpty);
                            _nameTextEditing.text.isNotEmpty &&
                                    _emailTextEditing.text.isNotEmpty &&
                                    _phoneTextEditing.text.isNotEmpty &&
                                    _passwordTextEditing.text.isNotEmpty
                                ? context.read<RegisterBloc>().add(
                                      RegisterEvent(
                                        _nameTextEditing.text,
                                        _emailTextEditing.text,
                                        _passwordTextEditing.text,
                                        _phoneTextEditing.text,
                                      ),
                                    )
                                : null;
                          },
                          clickButton: _nameTextEditing.text.isNotEmpty &&
                              _emailTextEditing.text.isNotEmpty &&
                              _phoneTextEditing.text.isNotEmpty &&
                              _passwordTextEditing.text.isNotEmpty,
                          buttonText: state is RegisterLoading
                              ? 'Signing...'
                              : state is RegisterFailure
                                  ? 'Failed'
                                  : 'Sign Up',
                          routeName: '/welcome',
                          buttonColor: ColorsApp.mainColor,
                        ),
                        SizedBox(
                          height: 17.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoogleAuth(),
                            SizedBox(
                              width: 35.h,
                            ),
                            AppleAuth(),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: 'Already have an account?',
                              colorText: ColorsApp.grayText,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            CustomInkWell(
                              width: 66.w,
                              height: 35.h,
                              inkWellText: 'Sign In',
                              colorText: ColorsApp.grayText,
                              sizeText: 12.sp,
                              fontWeight: FontWeight.w600,
                              routeName: '/login',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
