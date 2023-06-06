import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koshpendiler/model/profile_model.dart';

import '../../../data/api_provider.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  ApiProvider _apiProvider = ApiProvider();

  UpdateProfileBloc() : super(UpdateProfileInitial()) {
    on<UpdateProfileEvent>((event, emit) async {
      emit(UpdateProfileLoading());
      print('UpdateProfile BLOC');
      try {
        await _apiProvider.updateProfile(event.me, event.password)
            ? emit(UpdateProfileSuccess())
            : emit(UpdateProfileFailure());
      } catch (e) {
        print('ERROR IN CATCH Profile me');
        print(e);
        emit(UpdateProfileFailure());
      }
    });
  }
}
