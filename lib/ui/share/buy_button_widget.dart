import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td_pizzeria/models/cart.dart';
import 'package:td_pizzeria/models/pizza.dart';

class BuyButtonWidget extends StatelessWidget {
  final Pizza _pizza;

  const BuyButtonWidget(this._pizza, {super.key});

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.red.shade800),
            ),
            onPressed: () => {
                  _cart.addProduct(_pizza),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "La pizza ${_pizza.title} a été ajoutée au panier"),
                      duration: const Duration(seconds: 2),
                    ),
                  )
                },
            child: const Row(
              children: [
                Icon(Icons.shopping_cart),
                SizedBox(width: 5),
                Text("Commander")
              ],
            ))
      ],
    );
  }
}
