import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:burger_repository/burger_repository.dart';

part 'get_burger_event.dart';
part 'get_burger_state.dart';

class GetBurgerBloc extends Bloc<GetBurgerEvent, GetBurgerState> {
  final BurgerRepo _burgerRepo;

  GetBurgerBloc(this._burgerRepo) : super(GetBurgerInitial()) {
    on<GetBurger>((event, emit) async {
      emit(GetBurgerLoading());
      try {
        List<Burger> burgers = await _burgerRepo.getBurgers();
        emit(GetBurgerSuccess(burgers));
      } catch (e) {
        emit(GetBurgerFailure());
      }
    });
  }
}