import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koshpendiler/model/profile_model.dart';

import '../../../data/api_provider.dart';

part 'profile_me_event.dart';
part 'profile_me_state.dart';

class ProfileMeBloc extends Bloc<ProfileMeEvent, ProfileMeState> {
  ApiProvider _apiProvider = ApiProvider();

  ProfileMeBloc() : super(ProfileMeInitial()) {
    on<ProfileMeEvent>((event, emit) async {
      emit(ProfileMeLoading());
      print('ProfileMe BLOC');
      try {
        ProfileModel? me = await _apiProvider.getProfileMe();
        me != null ? emit(ProfileMeSuccess(me: me)) : emit(ProfileMeFailure());
      } catch (e) {
        print('ERROR IN CATCH Profile me');
        print(e);
        emit(ProfileMeFailure());
      }
    });
  }
}
