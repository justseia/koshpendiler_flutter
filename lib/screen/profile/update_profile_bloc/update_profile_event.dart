// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_profile_bloc.dart';

class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent(
    this.me,
    this.password,
  );
  final ProfileModel me;
  final String password;

  @override
  List<Object> get props => [me, password];
}
