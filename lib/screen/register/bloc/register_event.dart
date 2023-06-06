// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent(
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
  );
  final String name;
  final String email;
  final String password;
  final String phoneNumber;

  @override
  List<Object> get props => [name, email, password];
}
