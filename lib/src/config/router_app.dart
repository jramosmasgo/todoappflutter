import 'package:go_router/go_router.dart';
import 'package:todo_friend/src/screens/add_todo_screen.dart';
import 'package:todo_friend/src/screens/main_screen.dart';

final appRouter = GoRouter(initialLocation: '/home', routes: [
  GoRoute(
    path: '/home',
    builder: (context, state) => const MainScreen(),
  ),
  GoRoute(
    path: '/add',
    builder: (context, state) => const AddTodoScreen(),
  ),
]);
