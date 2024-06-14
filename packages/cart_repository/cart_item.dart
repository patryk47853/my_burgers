import 'package:burger_repository/burger_repository.dart';

class CartItem{
  Burger burger;
  double quantity;

  CartItem({
    required this.burger,
    this.quantity = 1
  });

  double get totalPrice {
    return (burger.price * quantity);
  }
}