import 'dart:convert';

import 'package:td_pizzeria/models/pizza.dart';
import 'package:http/http.dart' as http;

class PizzeriaService {
  static const String uri = 'http://localhost:8888';

  Future<List<Pizza>> fetchPizzas() async {
    final response = await http.get(Uri.parse('$uri/api/pizzas'));

    if (response.statusCode == 200) {
      final List<dynamic> pizzas = jsonDecode(response.body);
      return pizzas.map((json) => Pizza.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pizzas');
    }
  }
}