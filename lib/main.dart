import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_friend/firebase_options.dart';
import 'package:todo_friend/src/config/router_app.dart';
import 'package:todo_friend/src/config/theme_app.dart';
import 'package:todo_friend/src/providers/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TaskProvider())],
      child: MaterialApp.router(
        title: 'Todo Friend',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        // home: const MainScreen(),
        routerConfig: appRouter,
      ),
    );
  }
}
