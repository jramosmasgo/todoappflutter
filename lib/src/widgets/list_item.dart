import 'package:flutter/material.dart';
import 'package:todo_friend/src/entities/task_entity.dart';
import 'package:todo_friend/src/widgets/update_task.dart';

class ListItem extends StatelessWidget {
  final TaskEntity task;

  const ListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              width: 1,
              color: task.level == 1
                  ? Colors.green
                  : task.level == 2
                      ? Colors.blue
                      : Colors.red)),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return PopScope(
                    child: UpdateTask(
                  taksToEdit: task,
                ));
              });
        },
        tileColor: Theme.of(context).secondaryHeaderColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        title: Text(
          task.title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
        subtitle: Text(
          '${task.durationMinutes.toString()} min | ${task.startDate.hour}:${task.startDate.minute}',
        ),
        // leading: Icon(
        //   color: Theme.of(context).primaryColor,
        //   Icons.today,
        // ),
        trailing: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Chip(
              backgroundColor: task.level == 1
                  ? Colors.green
                  : task.level == 2
                      ? Colors.blue
                      : Colors.red,
              label: Text(
                task.level == 1
                    ? 'Bajo'
                    : task.level == 2
                        ? 'Medio'
                        : 'Alto',
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: const Icon(Icons.arrow_forward_ios)),
          ],
        ),
      ),
    );
  }
}
