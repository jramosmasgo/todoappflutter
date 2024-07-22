import 'package:flutter/material.dart';

class ItemDate extends StatefulWidget {
  DateTime date;
  bool selected;

  ItemDate({super.key, required this.date, required this.selected});

  @override
  State<ItemDate> createState() => _ItemDateState();
}

class _ItemDateState extends State<ItemDate> {
  final List<String> months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Noviembre',
    'Diciembre'
  ];

  @override
  Widget build(BuildContext context) {
    bool selected = widget.selected;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).primaryColor : Colors.white,
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        height: 91,
        width: 71,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.date.day.toString(),
              style: TextStyle(
                  fontSize: 30,
                  color: selected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              months[widget.date.month - 1],
              style: TextStyle(
                fontSize: 15,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
