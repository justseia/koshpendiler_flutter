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
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextEditing = TextEditingController();
  final TextEditingController _passwordTextEditing = TextEditingController();
  // bool _clickButton = false;

  @override
  void initState() {
    super.initState();
    // _emailTextEditing.addListener(() {
    //   setState(() {
    //     _clickButton = _emailTextEditing.text.isNotEmpty &&
    //             _passwordTextEditing.text.isNotEmpty
    //         ? true
    //         : false;
    //   });
    // });
    // _passwordTextEditing.addListener(() {
    //   setState(() {
    //     _clickButton = _passwordTextEditing.text.isNotEmpty &&
    //             _passwordTextEditing.text.isNotEmpty
    //         ? true
    //         : false;
    //   });
    // });
    _emailTextEditing.clear();
    _passwordTextEditing.clear();
  }

  @override
  void dispose() {
    _emailTextEditing.dispose();
    _passwordTextEditing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/welcome',
              (Route<dynamic> route) => false,
            );
          });
        }
        return Scaffold(
          backgroundColor: ColorsApp.black,
          body: SingleChildScrollView(
            child: ConstrainedBox(
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
                            text: 'Welcome back!',
                            colorText: ColorsApp.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomText(
                            text: 'Sign in to your account to get access',
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
                        height: 320.h,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomInput(
                                controller: _emailTextEditing,
                                inputUpText: 'Email',
                                hintText: 'Enter your email',
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              CustomInput(
                                controller: _passwordTextEditing,
                                inputUpText: 'Password',
                                hintText: 'Enter your password',
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomInkWell(
                                    width: 150.w,
                                    height: 30.h,
                                    inkWellText: 'Forget password?',
                                    colorText:
                                        ColorsApp.grayText.withOpacity(.6),
                                    sizeText: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    routeName: '/forgot',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 100.h,
                          ),
                          CustomButton(
                            onTapp: () {
                              print('LOGIN BUTTON');
                              _emailTextEditing.text.isNotEmpty &&
                                      _passwordTextEditing.text.isNotEmpty
                                  ? context.read<LoginBloc>().add(
                                        LoginEvent(
                                          _emailTextEditing.text,
                                          _passwordTextEditing.text,
                                        ),
                                      )
                                  : null;
                            },
                            clickButton: _emailTextEditing.text.isNotEmpty &&
                                _passwordTextEditing.text.isNotEmpty,
                            buttonText: state is LoginLoading
                                ? 'Signing...'
                                : state is LoginFailure
                                    ? 'Failed'
                                    : 'Sign In',
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
                                text: 'Don’t have an account?',
                                colorText: ColorsApp.grayText,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              CustomInkWell(
                                width: 66.w,
                                height: 35.h,
                                inkWellText: 'Sign Up',
                                colorText: ColorsApp.grayText,
                                sizeText: 12.sp,
                                fontWeight: FontWeight.w600,
                                routeName: '/register',
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
          ),
        );
      },
    );
  }
}
