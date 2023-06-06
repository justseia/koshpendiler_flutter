part of 'order_bloc.dart';

class OrderEvent extends Equatable {
  const OrderEvent(this.idOfPlace);
  final int idOfPlace;

  @override
  List<Object> get props => [idOfPlace];
}
