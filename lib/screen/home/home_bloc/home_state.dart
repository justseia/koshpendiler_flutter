part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  // List<Book> books;
  //
  // HomeLoaded({
  //   required this.books,
  // });

  @override
  List<Object> get props => [];
}

class HomeError extends HomeState {
  @override
  List<Object> get props => [];
}
