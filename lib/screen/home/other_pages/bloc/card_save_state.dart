// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'card_save_bloc.dart';

abstract class CardSaveState extends Equatable {
  const CardSaveState();

  @override
  List<Object> get props => [];
}

class CardSaveInitial extends CardSaveState {}

class CardSaveLoadingMe extends CardSaveState {}

class CardSaveLoadingSave extends CardSaveState {}

class CardSaveSuccessGetMe extends CardSaveState {
  final ProfileModel pm;
  CardSaveSuccessGetMe({
    required this.pm,
  });

  @override
  List<Object> get props => [pm];
}

class CardSaveSuccessSaveCard extends CardSaveState {}

class CardSaveFailureGetMe extends CardSaveState {}

class CardSaveFailureSaveCard extends CardSaveState {}
