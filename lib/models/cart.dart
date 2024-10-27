import 'package:flutter/foundation.dart';
import 'package:td_pizzeria/models/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem(this.pizza, [this.quantity = 1]);
}


class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  int totalItems() {
    return _items.length;
  }

  List<CartItem> items() {
    return _items;
  }

  int allItems() {
    int total = 0;

    for (var item in _items) {
      total += item.quantity;
    }

    return total;
  }

  CartItem getCartItem(int index) {
    return _items[index];
  }

  double totalPrice() {
    double total = 0;

    for (var item in _items) {
      total += item.pizza.total * item.quantity;
    }

    return total;
  }

  void addProduct(Pizza pizza) {
    int index = findCartItemIndex(pizza);

    if (index == -1) {
      _items.add(CartItem(pizza));
    } else {
      _items[index].quantity++;
    }

    notifyListeners();
  }

  void removeProduct(Pizza pizza) {
    int index = findCartItemIndex(pizza);

    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
    }

    notifyListeners();
  }

  int findCartItemIndex(Pizza pizza) {
    return _items.indexWhere((element) => element.pizza.id == pizza.id);
  }
}
