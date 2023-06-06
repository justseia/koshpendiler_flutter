// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'places_bloc.dart';

abstract class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object> get props => [];
}

class PlacesInitial extends PlacesState {}

class PlacesLoading extends PlacesState {}

class PlacesFailure extends PlacesState {}

class PlacesSuccess extends PlacesState {
  final List<Place> listPlaces;
  PlacesSuccess({
    required this.listPlaces,
  });

  @override
  List<Object> get props => [listPlaces];
}
