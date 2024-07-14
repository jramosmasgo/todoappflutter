import 'package:flutter/material.dart';
import 'package:todo_friend/src/config/router_app.dart';
import 'package:todo_friend/src/config/theme_app.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Todo Friend',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      // home: const MainScreen(),
      routerConfig: appRouter,
    );
  }
}
