part of 'get_burger_bloc.dart';

sealed class GetBurgerEvent extends Equatable {
  const GetBurgerEvent();

  @override
  List<Object> get props => [];
}

class GetBurger extends GetBurgerEvent{}