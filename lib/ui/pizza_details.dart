import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td_pizzeria/models/cart.dart';
import 'package:td_pizzeria/models/option_item.dart';
import 'package:td_pizzeria/models/pizza.dart';
import 'package:td_pizzeria/ui/share/appbar_widget.dart';
import 'package:td_pizzeria/ui/share/buy_button_widget.dart';
import 'package:td_pizzeria/ui/share/pizzeria_style.dart';
import 'package:td_pizzeria/ui/share/total_widget.dart';

class PizzaDetails extends StatefulWidget {
  final Pizza _pizza;

  const PizzaDetails(this._pizza, {super.key});

  @override
  State<PizzaDetails> createState() => _PizzaDetailsState();
}

class _PizzaDetailsState extends State<PizzaDetails> {
  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: AppbarWidget(widget._pizza.title),
      body: ListView(
        padding: const EdgeInsets.all(4.0),
        children: [
          Text(
            widget._pizza.title,
            style: PizzeriaStyle.pageTitleTextStyle,
          ),
          Image.network(
            widget._pizza.image,
            height: 180,
            //width: MediaQuery.of(context).size.width,
          ),
          Text(
            "Recette",
            style: PizzeriaStyle.headerTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
            child: Text(widget._pizza.garniture),
          ),
          Text(
            "Pâtes et taille sélectionnées",
            style: PizzeriaStyle.headerTextStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _buildDropDownPates()),
              Expanded(child: _buildDropDownTailles())
            ],
          ),
          Text(
            "Sauce sélectionnée",
            style: PizzeriaStyle.headerTextStyle,
          ),
          const Text("Les sauces"),
          _buildDropDownSauces(),
          Text('${widget._pizza.price} €'),
          TotalWidget(widget._pizza.total),
          BuyButtonWidget(widget._pizza)
        ],
      ),
    );
  }

  _buildDropDownPates() {
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.pates[widget._pizza.pate],
      items: _buildDropDownItem(Pizza.pates),
      onChanged: (item) {
        setState(() {
          widget._pizza.pate = item!.value;
        });
      },
    );
  }

  _buildDropDownTailles() {
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.tailles[widget._pizza.taille],
      items: _buildDropDownItem(Pizza.tailles),
      onChanged: (item) {
        setState(() {
          widget._pizza.taille = item!.value;
        });
      },
    );
  }

  _buildDropDownSauces() {
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.sauces[widget._pizza.sauce],
      items: _buildDropDownItem(Pizza.sauces),
      onChanged: (item) {
        setState(() {
          widget._pizza.sauce = item!.value;
        });
      },
    );
  }

  _buildDropDownItem(List<OptionItem> list) {
    return Iterable.generate(
      list.length,
      (index) => DropdownMenuItem<OptionItem>(
        value: list[index],
        child: Text(list[index].name),
      ),
    ).toList();
  }
}
