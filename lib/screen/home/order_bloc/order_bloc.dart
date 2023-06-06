import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koshpendiler/data/api_provider.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  ApiProvider _apiProvider = ApiProvider();

  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) async {
      emit(OrderLoading());
      print('ORDER BLOC');
      try {
        await _apiProvider.orderPlace(event.idOfPlace)
            ? emit(OrderSuccess())
            : emit(OrderFailure());
      } catch (e) {
        print('ERROR IN CATCH');
        emit(OrderFailure());
      }
    });
  }
}
