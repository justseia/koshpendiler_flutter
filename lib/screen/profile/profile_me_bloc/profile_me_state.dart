// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_me_bloc.dart';

abstract class ProfileMeState extends Equatable {
  const ProfileMeState();

  @override
  List<Object> get props => [];
}

class ProfileMeInitial extends ProfileMeState {}

class ProfileMeLoading extends ProfileMeState {}

class ProfileMeSuccess extends ProfileMeState {
  final ProfileModel me;
  ProfileMeSuccess({
    required this.me,
  });

  @override
  List<Object> get props => [me];
}

class ProfileMeFailure extends ProfileMeState {}
