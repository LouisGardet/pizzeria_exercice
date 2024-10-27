import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td_pizzeria/models/cart.dart';
import 'package:td_pizzeria/models/pizza.dart';
import 'package:td_pizzeria/ui/share/total_widget.dart';

class Panier extends StatefulWidget {
  const Panier({super.key});

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Panier"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cart.totalItems(),
              itemBuilder: (context, index) {
                return _buildItem(_cart.getCartItem(index));
              },
            ),
          ),
          TotalWidget(_cart.totalPrice()),
          Container(
            child: ElevatedButton(
              child: const Text("Valider"),
              onPressed: () {
                print("valider");
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildItem(CartItem cartItem) {
    final _cart = Provider.of<Cart>(context, listen: false);

    return Card(
      child: ListTile(
        leading: Image.network(cartItem.pizza.image),
        title: Text(cartItem.pizza.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${cartItem.pizza.total}€"),
            Text("Pâte: ${Pizza.pates[cartItem.pizza.pate].name}"),
            Text("Taille: ${Pizza.tailles[cartItem.pizza.taille].name}"),
            Text("Sauce: ${Pizza.sauces[cartItem.pizza.sauce].name}"),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                _cart.removeProduct(cartItem.pizza);
                setState(() {});
              },
            ),
            Text("${cartItem.quantity}"),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _cart.addProduct(cartItem.pizza);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

}
