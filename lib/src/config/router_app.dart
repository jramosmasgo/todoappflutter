import 'package:go_router/go_router.dart';
import 'package:todo_friend/src/screens/add_todo_screen.dart';
import 'package:todo_friend/src/screens/init_screen.dart';
import 'package:todo_friend/src/screens/login_screen.dart';
import 'package:todo_friend/src/screens/main_screen.dart';
import 'package:todo_friend/src/screens/register_screen.dart';

final appRouter = GoRouter(initialLocation: '/init', routes: [
  GoRoute(
    path: '/home',
    builder: (context, state) => const MainScreen(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: '/add',
    builder: (context, state) => const AddTodoScreen(),
  ),
  GoRoute(
    path: '/init',
    builder: (context, state) => const InitScreen(),
  ),
]);
