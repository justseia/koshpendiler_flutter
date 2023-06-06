// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'card_save_bloc.dart';

abstract class CardSaveEvent extends Equatable {
  const CardSaveEvent();

  @override
  List<Object> get props => [];
}

class GetMe extends CardSaveEvent {}

class SaveCard extends CardSaveEvent {
  final CardModel cm;
  SaveCard({
    required this.cm,
  });

  @override
  List<Object> get props => [cm];
}
