import 'package:burger_repository/burger_repository.dart';
import 'package:collection/collection.dart';

import 'cart_item.dart';

class Cart{
  final List<CartItem> _cart = [];

  void addToCart(Burger burger) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameBurger = item.burger == burger;

      return isSameBurger;
    });

    if(cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(burger: burger));
    }
  }

  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if(cartIndex != -1) {
      if(_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
  }

  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      total = cartItem.burger.price * cartItem.quantity;
    }

    return total;
  }

  double getTotalItemCount() {
    double totalItemCount = 0.0;

    for(CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  void clearCart() {
    _cart.clear();
  }
}