import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koshpendiler/model/card_model.dart';
import 'package:koshpendiler/model/profile_model.dart';

import '../../../../data/api_provider.dart';

part 'card_save_event.dart';
part 'card_save_state.dart';

class CardSaveBloc extends Bloc<CardSaveEvent, CardSaveState> {
  ApiProvider _apiProvider = ApiProvider();

  CardSaveBloc() : super(CardSaveInitial()) {
    on<GetMe>((event, emit) async {
      emit(CardSaveLoadingMe());
      print('ProfileMe BLOC');
      try {
        ProfileModel? me = await _apiProvider.getProfileMe();
        me != null
            ? emit(CardSaveSuccessGetMe(pm: me))
            : emit(CardSaveFailureGetMe());
      } catch (e) {
        print('ERROR IN CATCH Profile me');
        print(e);
        emit(CardSaveFailureGetMe());
      }
    });
    on<SaveCard>((event, emit) async {
      emit(CardSaveLoadingSave());
      print('SAVE CARD BLOC');
      print(event.cm.toString());
      try {
        await _apiProvider.cardSave(event.cm)
            ? emit(CardSaveSuccessSaveCard())
            : emit(CardSaveFailureSaveCard());
      } catch (e) {
        print('ERROR IN CATCH SAVE CARD');
        print(e);
        emit(CardSaveFailureSaveCard());
      }
    });
  }
}
