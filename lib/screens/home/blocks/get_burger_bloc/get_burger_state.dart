part of 'get_burger_bloc.dart';

sealed class GetBurgerState extends Equatable {
  const GetBurgerState();
  
  @override
  List<Object> get props => [];
}

final class GetBurgerInitial extends GetBurgerState {}

final class GetBurgerFailure extends GetBurgerState {}
final class GetBurgerLoading extends GetBurgerState {}
final class GetBurgerSuccess extends GetBurgerState {
  final List<Burger> burgers;

  const GetBurgerSuccess(this.burgers);

  @override
  List<Object> get props => [burgers];
}