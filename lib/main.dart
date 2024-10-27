import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td_pizzeria/ui/pizza_list.dart';
import 'package:td_pizzeria/ui/share/appbar_widget.dart';

import 'models/cart.dart';
import 'models/menu.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzeria',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Notre pizzeria'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  String title;

  MyHomePage({super.key, required this.title});

  final _menus = [
    const Menu(
      type: 1,
      title: 'Pizza',
      image: 'assets/img/menu/pizza.png',
      color: Colors.red,
    ),
    const Menu(
      type: 2,
      title: 'Pasta',
      image: 'assets/img/menu/pasta.png',
      color: Colors.green,
    ),
    const Menu(
      type: 3,
      title: 'Salad',
      image: 'assets/img/menu/salad.png',
      color: Colors.lightBlueAccent,
    ),
    const Menu(
      type: 4,
      title: 'Dessert',
      image: 'assets/img/menu/dessert.png',
      color: Colors.yellow,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
        appBar: AppbarWidget(title),
        body: Center(
            child: ListView.builder(
          itemCount: _menus.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              switch (_menus[index].type) {
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PizzaList()),
                  );
                  break;
                default:
              }
            },
            child: _buildRow(_menus[index]),
          ),
          itemExtent: 180,
        )));
  }
}

_buildRow(Menu menu) {
  return Container(
      height: 180,
      decoration: BoxDecoration(
        color: menu.color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.all(4.0),
      child: Column(children: <Widget>[
        Expanded(
            child: Image.asset(
          menu.image,
          fit: BoxFit.fitWidth,
        )),
        SizedBox(
          height: 50,
          child: Center(
            child: Text(
              menu.title,
              style: const TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ]));
}
