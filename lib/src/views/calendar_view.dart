import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_friend/src/entities/task_entity.dart';
import 'package:todo_friend/src/providers/task_provider.dart';
import 'package:todo_friend/src/widgets/list_item.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<TaskEntity> myTasks = [];

  List<TaskEntity> filterTasksByDate(
      List<TaskEntity> tasks, DateTime daySelected) {
    var dayEntry =
        DateTime(daySelected.year, daySelected.month, daySelected.day);

    var onceTaks = tasks
        .where((x) =>
            x.repeatType == "once" &&
            DateTime(x.startDate.year, x.startDate.month, x.startDate.day) ==
                dayEntry)
        .toList();

    var repeatEveryDay = tasks
        .where((x) =>
            x.repeatType == "diary" &&
            (dayEntry.isAfter(DateTime(
                    x.startDate.year, x.startDate.month, x.startDate.day)) ||
                dayEntry.isAtSameMomentAs(DateTime(
                    x.startDate.year, x.startDate.month, x.startDate.day))))
        .toList();

    var repearWeekly = tasks
        .where((x) =>
            x.repeatType == "weekly" && x.startDate.weekday == dayEntry.weekday)
        .toList();

    List<TaskEntity> allList =
        {...onceTaks, ...repeatEveryDay, ...repearWeekly}.toList();

    if (allList.isNotEmpty) {
      allList.sort((a, b) => a.startDate.compareTo(b.startDate));
    }

    return allList;
  }

  @override
  Widget build(BuildContext context) {
    final taskprovider = context.watch<TaskProvider>();
    // setState(() {
    //   myTasks = filterTasksByDate(taskprovider.tasks, DateTime.now());
    // });

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Center(
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  "Mi Calendario",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TableCalendar(
                firstDay: DateTime(2020, 3, 14),
                lastDay: DateTime(2025, 12, 31),
                onCalendarCreated: (pageController) {},
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      myTasks =
                          filterTasksByDate(taskprovider.tasks, selectedDay);
                    });
                  }
                },
                calendarFormat: _calendarFormat,
                availableGestures: AvailableGestures.none,
                headerStyle: const HeaderStyle(
                    headerPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    titleTextStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    leftChevronVisible: false,
                    rightChevronVisible: false,
                    formatButtonVisible: false,
                    formatButtonShowsNext: false),
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                focusedDay: _focusedDay,
                calendarStyle: const CalendarStyle(
                    tableBorder: TableBorder(),
                    markerDecoration: BoxDecoration(color: Colors.green))),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  'Mis Tareas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: myTasks.length,
                itemBuilder: (context, index) {
                  final tasks = myTasks;

                  return Material(
                    color: Colors.transparent,
                    child: ListItem(
                      task: tasks[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
