// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'animal_bloc.dart';

abstract class AnimalState extends Equatable {
  const AnimalState();

  @override
  List<Object> get props => [];
}

class AnimalInitial extends AnimalState {}

class AnimalLoading extends AnimalState {}

class AnimalFailure extends AnimalState {}

class AnimalSuccess extends AnimalState {
  final List<Animal> animals_list;
  AnimalSuccess({
    required this.animals_list,
  });

  @override
  List<Object> get props => [animals_list];
}
