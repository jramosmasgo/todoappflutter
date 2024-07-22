import 'package:go_router/go_router.dart';
import 'package:todo_friend/src/screens/init_screen.dart';
import 'package:todo_friend/src/screens/login_screen.dart';
import 'package:todo_friend/src/screens/main_screen.dart';
import 'package:todo_friend/src/screens/register_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/init',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainScreen(),
      // routes: [
      //   GoRoute(
      //     path: 'profile',
      //     builder: (context, state) => const ProfileView(),
      //   ),
      //   GoRoute(
      //     path: 'settings',
      //     builder: (context, state) => const SettingsView(),
      //   ),
      //   GoRoute(
      //     path: 'calendar',
      //     builder: (context, state) => const CalendarView(),
      //   ),
      //   GoRoute(
      //     path: 'main',
      //     builder: (context, state) => const HomeView(),
      //   ),
      // ],
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
      path: '/init',
      builder: (context, state) => const InitScreen(),
    ),
  ],
);
