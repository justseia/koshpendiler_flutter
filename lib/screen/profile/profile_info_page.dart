// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/foundation.dart';
import 'package:iconify_flutter/icons/teenyicons.dart';
import 'package:koshpendiler/model/profile_model.dart';

import '../../core/colors.dart';
import 'update_profile_bloc/update_profile_bloc.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key, required this.me});
  final ProfileModel me;

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

bool _isEditing = false;
TextEditingController _nameContr = TextEditingController();
TextEditingController _emailContr = TextEditingController();
TextEditingController _phoneContr = TextEditingController();
TextEditingController _genderContr = TextEditingController();
TextEditingController _dateContr = TextEditingController();
TextEditingController _passwordContr = TextEditingController();
String _name = 'Rose Saldana';
String _email = 'rosesaldana@gmail.com';
String _phone = '+845316589231';
String _gender = 'Female';
String _dateB = '09/05/1997';
DateTime? _choosedDt;
String _password = 'qwerty';
bool _isObscured = true;

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isEditing = false;
    // _nameContr = TextEditingController(text: _name);
    // _emailContr = TextEditingController(text: _email);
    // _phoneContr = TextEditingController(text: _phone);
    // _genderContr = TextEditingController(text: _gender);
    // _dateContr = TextEditingController(text: _dateB);
    // _passwordContr = TextEditingController(text: _password);
    _name = widget.me.full_name ?? 'Empty';
    _email = widget.me.email ?? 'Empty';
    _phone = widget.me.phone ?? 'Empty';
    _gender = widget.me.gender ?? 'Empty';
    _password = '••••••••';
    _dateB = widget.me.birth != null
        ? '${widget.me.birth!.day}/${widget.me.birth!.month}/${widget.me.birth!.year}'
        : 'Empty';
    _nameContr = TextEditingController(text: widget.me.full_name);
    _emailContr = TextEditingController(text: widget.me.email);
    _phoneContr = TextEditingController(text: widget.me.phone);
    _genderContr = TextEditingController(text: widget.me.gender);
    _dateContr = TextEditingController(
      text: widget.me.birth != null
          ? '${widget.me.birth!.day}/${widget.me.birth!.month}/${widget.me.birth!.year}'
          : null,
    );
    _passwordContr = TextEditingController(text: 'XXXXXXXX');
    _choosedDt = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: appBar(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: button(context, state),
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width - 44,
                    color: ColorsApp.yellowbd,
                  ),
                  SizedBox(height: 30),
                  _isEditing ? edit_body(state) : profile_info(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Column edit_body(UpdateProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        name_input(),
        SizedBox(height: 35),
        email_input(),
        SizedBox(height: 35),
        phone_input(),
        SizedBox(height: 35),
        gender_input(),
        SizedBox(height: 35),
        date_input(),
        SizedBox(height: 35),
        password_input(),
      ],
    );
  }

  Column password_input() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: tsyl_14_500_17(),
        ),
        // SizedBox(height: 12),
        TextField(
          style: tswh_16_400_19(),
          keyboardType: TextInputType.visiblePassword,
          controller: _passwordContr,
          obscureText: _isObscured,
          // inputFormatters: [numberFormatter],
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            // labelText: 'Inline Decoration',
            hintText: 'Enter at least 8 digits',
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
                _isObscured ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget date_input() {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime(2001), //get today's date
          firstDate: DateTime(
              1900), //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2010),
        );
        print(pickedDate.toString());
        if (pickedDate != null) {
          setState(() {
            // _dateB = '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
            _choosedDt = pickedDate;
            _dateContr = TextEditingController(
              text: '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}',
            );
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date of birth',
            style: tsyl_14_500_17(),
          ),
          // SizedBox(height: 12),
          TextField(
            style: tswh_16_400_19(),
            keyboardType: TextInputType.datetime,
            readOnly: true,
            controller: _dateContr,
            // inputFormatters: [numberFormatter],
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              // labelText: 'Inline Decoration',
              hintText: 'dd/MM/yyyy',
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
              // setState(() {});
            },
            onTap: () async {
              // DateTime? pickedDate = await showDatePicker(
              //   context: context,
              //   initialDate: DateTime(2013), //get today's date
              //   firstDate: DateTime(
              //       2000), //DateTime.now() - not to allow to choose before today.
              //   lastDate: DateTime(2010),
              // );
              // print(pickedDate.toString());
              // if (pickedDate != null) {
              //   setState(() {
              //     _dateB =
              //         '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
              //     _dateContr = TextEditingController(
              //       text:
              //           '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}',
              //     );
              //   });
              // }
            },
          ),
        ],
      ),
    );
  }

  Column gender_input() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: tsyl_14_500_17(),
        ),
        // SizedBox(height: 12),
        TextField(
          style: tswh_16_400_19(),
          keyboardType: TextInputType.name,
          controller: _genderContr,
          // inputFormatters: [numberFormatter],
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            // labelText: 'Inline Decoration',
            hintText: 'Male ? Female',
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

  Column phone_input() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone number',
          style: tsyl_14_500_17(),
        ),
        // SizedBox(height: 12),
        TextField(
          style: tswh_16_400_19(),
          keyboardType: TextInputType.number,
          controller: _phoneContr,
          // inputFormatters: [numberFormatter],
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            // labelText: 'Inline Decoration',
            hintText: 'Write your phone number',
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

  Column email_input() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: tsyl_14_500_17(),
        ),
        // SizedBox(height: 12),
        TextField(
          style: tswh_16_400_19(),
          keyboardType: TextInputType.emailAddress,
          controller: _emailContr,
          // inputFormatters: [numberFormatter],
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            // labelText: 'Inline Decoration',
            hintText: 'Write your email',
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

  Column name_input() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: tsyl_14_500_17(),
        ),
        // SizedBox(height: 12),
        TextField(
          style: tswh_16_400_19(),
          keyboardType: TextInputType.name,
          controller: _nameContr,
          // inputFormatters: [numberFormatter],
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            // labelText: 'Inline Decoration',
            hintText: 'Write your name',
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

  TextStyle tsyl_14_500_17() {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: ColorsApp.yellowbd,
      height: 16.94 / 16,
    );
  }

  TextStyle tswh_16_400_19() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      height: 19.36 / 16,
    );
  }

  Column profile_info(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        name_body(context),
        SizedBox(height: 30),
        email_body(context),
        SizedBox(height: 30),
        phone_body(context),
        SizedBox(height: 30),
        gender_body(context),
        SizedBox(height: 30),
        date_body(context),
        SizedBox(height: 30),
        password_body(context),
      ],
    );
  }

  Widget password_body(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 14),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: ColorsApp.grayInput,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Iconify(
            Teenyicons.password_solid,
            size: 26,
            color: ColorsApp.yellowbd,
          ),
        ),
        SizedBox(width: 15),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorsApp.grayText,
                height: 16.94 / 14,
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width - 123,
              child: Text(
                _password,
                maxLines: 2,
                style: TextStyle(
                  decorationStyle: TextDecorationStyle.dashed,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 19.36 / 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget date_body(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 14),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: ColorsApp.grayInput,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Iconify(
            MaterialSymbols.date_range_sharp,
            size: 26,
            color: ColorsApp.yellowbd,
          ),
        ),
        SizedBox(width: 15),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date of birth',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorsApp.grayText,
                height: 16.94 / 14,
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width - 123,
              child: Text(
                _dateB,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 19.36 / 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget gender_body(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 14),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: ColorsApp.grayInput,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Iconify(
            Foundation.male_female,
            size: 26,
            color: ColorsApp.yellowbd,
          ),
        ),
        SizedBox(width: 15),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gender',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorsApp.grayText,
                height: 16.94 / 14,
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width - 123,
              child: Text(
                _gender,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 19.36 / 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget phone_body(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 14),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: ColorsApp.grayInput,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Iconify(
            Ph.phone_bold,
            size: 26,
            color: ColorsApp.yellowbd,
          ),
        ),
        SizedBox(width: 15),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone number',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorsApp.grayText,
                height: 16.94 / 14,
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width - 123,
              child: Text(
                _phone,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 19.36 / 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget email_body(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 14),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: ColorsApp.grayInput,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Iconify(
            MaterialSymbols.mail_outline,
            size: 26,
            color: ColorsApp.yellowbd,
          ),
        ),
        SizedBox(width: 15),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorsApp.grayText,
                height: 16.94 / 14,
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width - 123,
              child: Text(
                _email,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 19.36 / 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget name_body(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 14),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: ColorsApp.grayInput,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Iconify(
            Majesticons.contact_line,
            size: 26,
            color: ColorsApp.yellowbd,
          ),
        ),
        SizedBox(width: 15),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorsApp.grayText,
                height: 16.94 / 14,
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width - 123,
              child: Text(
                _name,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 19.36 / 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget button(BuildContext context, UpdateProfileState state) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed('/map_success_page');
        // setState(() {
        //   _isEditing = !_isEditing;
        // });
        if (!_isEditing) {
          setState(() {
            _isEditing = true;
          });
        }
        if (_nameContr.text.isNotEmpty &&
            _emailContr.text.isNotEmpty &&
            _genderContr.text.isNotEmpty &&
            _dateContr.text.isNotEmpty &&
            _passwordContr.text.isNotEmpty &&
            _phoneContr.text.isNotEmpty) {
          ProfileModel me = ProfileModel(
            id: 0,
            full_name: _nameContr.text,
            email: _emailContr.text,
            gender: _genderContr.text,
            birth: _choosedDt,
            phone: _phoneContr.text,
          );
          context.read<UpdateProfileBloc>().add(
                UpdateProfileEvent(
                  me,
                  _passwordContr.text,
                ),
              );
        }
      },
      child: Container(
        width: double.infinity,
        height: 56,
        margin: EdgeInsets.only(bottom: 30, left: 22, right: 22),
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: ColorsApp.yellowbd,
          borderRadius: BorderRadius.circular(53),
        ),
        alignment: Alignment.center,
        child: Text(
          _isEditing
              ? state is UpdateProfileLoading
                  ? 'Updating ...'
                  : state is UpdateProfileSuccess
                      ? 'Success ;)'
                      : state is UpdateProfileFailure
                          ? 'Failed :('
                          : 'Update Profile'
              : 'Edit Profile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 19.36 / 16,
            color: Colors.white,
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
        _isEditing ? 'Edit' : 'Profile',
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
