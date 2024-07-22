import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_friend/src/config/router_app.dart';
import 'package:todo_friend/src/config/theme_app.dart';
import 'package:todo_friend/src/providers/task_provider.dart';

class Material extends StatelessWidget {
  const Material({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return MaterialApp.router(
      title: 'Todo Friend',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: appRouter,
    );
  }
}
