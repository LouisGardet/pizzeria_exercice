import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:td_pizzeria/ui/share/pizzeria_style.dart';

class TotalWidget extends StatelessWidget {
  final double total;

  const TotalWidget(this.total, {super.key});

  @override
  Widget build(BuildContext context) {
    var format = NumberFormat("###.00 €");
    String totalAffiche = format.format(total);

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Row(
        children: [
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(left: 12.0),
            child: Text(
              "TOTAL",
              style: PizzeriaStyle.priceTotalTextStyle,
              textAlign: TextAlign.end,
            ),
          )),
          Expanded(
              child: Text(
            totalAffiche,
            style: PizzeriaStyle.priceTotalTextStyle,
            textAlign: TextAlign.end,
          ))
        ],
      ),
    );
  }
}
