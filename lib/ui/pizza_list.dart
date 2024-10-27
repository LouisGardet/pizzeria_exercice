import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td_pizzeria/models/cart.dart';
import 'package:td_pizzeria/services/pizzeria_service.dart';
import 'package:td_pizzeria/ui/pizza_details.dart';
import 'package:td_pizzeria/ui/share/appbar_widget.dart';
import 'package:td_pizzeria/ui/share/buy_button_widget.dart';
import 'package:td_pizzeria/ui/share/pizzeria_style.dart';

import '../models/pizza.dart';
import '../utils/pizza_data.dart';

class PizzaList extends StatefulWidget {
  const PizzaList({super.key});

  @override
  State<PizzaList> createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
  late Future<List<Pizza>> _pizzas;
  final PizzeriaService _pizzeriaService = PizzeriaService();

  @override
  void initState() {
    super.initState();
    _pizzas = _pizzeriaService.fetchPizzas();
  }

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context, listen: false);
  /**
    return Scaffold(
      appBar: const AppbarWidget("Notre pizzas"),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _pizzas.length,
        itemBuilder: (context, index) => _buildRow(_pizzas[index], context),
      ),
    );
    **/

    return Scaffold(
      appBar: const AppbarWidget("Notre pizzas"),
      body: FutureBuilder<List<Pizza>>(
        future: _pizzas,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildListView(snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Impossible de récupèrer les données : ${snapshot.error}",
                style: PizzeriaStyle.errorTextStyle,
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      )
    );
  }

  _buildListView(List<Pizza> pizzas) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: pizzas.length,
      itemBuilder: (context, index) => _buildRow(pizzas[index], context),
    );
  }

  _buildRow(Pizza pizza, BuildContext context) {
    final _cart = Provider.of<Cart>(context, listen: false);

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
          top: Radius.circular(2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PizzaDetails(pizza),
                ),
              );
            },
            child: _buildPizzaDetails(pizza, context),
          ),
          BuyButtonWidget(pizza)
        ],
      ),
    );
  }

  _buildPizzaDetails(Pizza pizza, BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListTile(
        title: Text(pizza.title),
        subtitle: Text(pizza.garniture),
        leading: const Icon(Icons.local_pizza),
      ),
      Image.network(
        pizza.image,
        height: 120,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fitWidth,
      ),
      Container(
        padding: const EdgeInsets.all(4.0),
        child: Text(pizza.garniture),
      ),
    ]);
  }
}
