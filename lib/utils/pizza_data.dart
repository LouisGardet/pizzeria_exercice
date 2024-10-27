import '../models/pizza.dart';

class PizzaData {
  static List<Pizza> buildList() {
    List<Pizza> pizzas = [];
    pizzas.add(Pizza(
      id: 1,
      title: 'Margherita',
      garniture: 'Tomato sauce, mozzarella, fresh basil',
      image: 'assets/img/pizza/pizza1.jpeg',
      price: 8.99,
    ));
    pizzas.add(Pizza(
      id: 2,
      title: 'Capricciosa',
      garniture:
          'Tomato sauce, mozzarella, ham, mushrooms, artichokes, black olives, fresh oregano',
      image: 'assets/img/pizza/pizza2.png',
      price: 10.99,
    ));
    pizzas.add(Pizza(
      id: 3,
      title: 'Diavola',
      garniture: 'Tomato sauce, mozzarella, spicy salami, hot pepper',
      image: 'assets/img/pizza/pizza3.png',
      price: 11.99,
    ));
    pizzas.add(Pizza(
      id: 4,
      title: 'Quattro Formaggi',
      garniture:
          'Tomato sauce, mozzarella, gorgonzola cheese, emmental, parmesan',
      image: 'assets/img/pizza/pizza4.png',
      price: 9.99,
    ));

    return pizzas;
  }
}
