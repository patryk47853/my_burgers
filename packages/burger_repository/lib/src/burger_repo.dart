import 'models/models.dart';

abstract class BurgerRepo {
    Future<List<Burger>> getBurgers();

}