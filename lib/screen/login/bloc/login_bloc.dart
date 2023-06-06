import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/api_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ApiProvider _apiProvider = ApiProvider();
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      print('Login BLOC');
      print('${event.email} ${event.password}');
      try {
        await _apiProvider.login(event.email, event.password)
            ? emit(LoginSuccess())
            : emit(LoginFailure());
      } catch (e) {
        print('ERROR IN CATCH');
        emit(LoginFailure());
      }
    });
  }
}
