import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koshpendiler/data/api_provider.dart';

import '../../../model/Place.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  ApiProvider _apiProvider = ApiProvider();
  PlacesBloc() : super(PlacesInitial()) {
    on<PlacesEvent>((event, emit) async {
      emit(PlacesLoading());
      print('PLACES BLOC');
      try {
        List<Place>? listPlaces = await _apiProvider.getAllPLaces();
        listPlaces != null
            ? emit(PlacesSuccess(listPlaces: listPlaces))
            : emit(PlacesFailure());
      } catch (e) {
        emit(PlacesFailure());
        print('ERROR IN CATCH');
      }
    });
  }
}
