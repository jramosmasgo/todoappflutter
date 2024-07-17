import 'package:flutter/material.dart';
import 'package:todo_friend/src/entities/task_entity.dart';

class ListItem extends StatelessWidget {
  final TaskEntity task;

  const ListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).primaryColor)),
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        tileColor: task.level == 3
            ? Colors.red
            : task.level == 2
                ? Colors.orange
                : Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        title: Text(
          task.title,
          style:
              const TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        subtitle: Text(
          '${task.durationMinutes.toString()} min | ${task.startDate.hour}:${task.startDate.minute}',
          style: const TextStyle(color: Colors.white),
        ),
        leading: const Icon(
          color: Colors.white,
          Icons.today,
        ),
        trailing: RichText(
          text: const TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(
                    Icons.alarm,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
