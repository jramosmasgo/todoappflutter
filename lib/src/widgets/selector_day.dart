import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_friend/src/providers/task_provider.dart';

class SelectorDay extends StatefulWidget {
  const SelectorDay({super.key});

  @override
  State<SelectorDay> createState() => _SelectorDayState();
}

class _SelectorDayState extends State<SelectorDay> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final today = DateTime.now();

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
      'Octubre', // Corregir "Noviembre" a "Octubre"
      'Noviembre',
      'Diciembre'
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            DateTime selectedDate =
                DateTime(today.year, today.month, today.day + index);
            taskProvider.filterTasksByDate(selectedDate);
            taskProvider.selectedDate = selectedDate;
            setState(() {
              selectedIndex = index;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            decoration: BoxDecoration(
              color: index == selectedIndex
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
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
                    DateTime(today.year, today.month, today.day + index)
                        .day
                        .toString(),
                    style: TextStyle(
                        fontSize: 30,
                        color: index == selectedIndex
                            ? Theme.of(context)
                                .textSelectionTheme
                                .selectionColor
                            : Theme.of(context).textSelectionTheme.cursorColor,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    months[DateTime(today.year, today.month, today.day + index)
                            .month -
                        1],
                    style: TextStyle(
                      fontSize: 15,
                      color: index == selectedIndex
                          ? Theme.of(context).textSelectionTheme.selectionColor
                          : Theme.of(context).textSelectionTheme.cursorColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
