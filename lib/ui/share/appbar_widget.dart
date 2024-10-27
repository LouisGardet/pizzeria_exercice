import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td_pizzeria/models/cart.dart';

import '../panier.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppbarWidget(this.title, {super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context, listen: false);

    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Panier(),
              ),
            );
          },
        ),
        Consumer<Cart>(
          builder: (context, cart, child) {
            return Container(
              margin: const EdgeInsets.only(right: 16.0),
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red, // Couleur du cercle
              ),
              child: Text(
                cart.allItems().toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
