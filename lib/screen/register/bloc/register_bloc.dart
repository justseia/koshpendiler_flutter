import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koshpendiler/data/api_provider.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  ApiProvider _apiProvider = ApiProvider();
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      print('REGISTER BLOC');
      print('${event.name} ${event.email} ${event.password}');
      try {
        await _apiProvider.register(
                event.email, event.password, event.name, event.phoneNumber)
            ? emit(RegisterSuccess())
            : emit(RegisterFailure());
      } catch (e) {
        print('ERROR IN CATCH');
        emit(RegisterFailure());
      }
    });
  }
}
