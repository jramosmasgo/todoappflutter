import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_friend/src/providers/task_provider.dart';
import 'package:todo_friend/src/widgets/list_item.dart';
import 'package:todo_friend/src/widgets/selector_day.dart';

class ListTasksView extends StatelessWidget {
  const ListTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskprovider = context.watch<TaskProvider>();

    return Stack(
      children: [
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SelectorDay(),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mis Tareas',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: taskprovider.tasksFiltered.length,
                  itemBuilder: (context, index) {
                    final tasks = taskprovider.tasksFiltered;

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
        )
      ],
    );
  }
}
