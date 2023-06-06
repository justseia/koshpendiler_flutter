import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koshpendiler/data/api_provider.dart';

import '../../../model/animal.dart';

part 'animal_event.dart';
part 'animal_state.dart';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  ApiProvider _apiProvider = ApiProvider();
  AnimalBloc() : super(AnimalInitial()) {
    on<AnimalEvent>((event, emit) async {
      emit(AnimalLoading());
      print('ANIMALS BLOC');
      try {
        List<Animal>? animals_list = await _apiProvider.getAllAnimals();
        print(animals_list);
        animals_list != null
            ? emit(AnimalSuccess(animals_list: animals_list))
            : emit(AnimalFailure());
      } catch (e) {
        print('ERROR IN CATCH');
        emit(AnimalFailure());
        print(e);
      }
    });
  }
}
