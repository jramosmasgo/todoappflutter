import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_friend/src/config/user_database.dart';
import 'package:todo_friend/src/entities/user_entity.dart';
import 'package:todo_friend/src/providers/task_provider.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      var userLogged = await UserHelper().getUserLogged();

      if (userLogged != null) {
        UserEntity user = UserEntity(
            id: userLogged.userId,
            name: userLogged.name,
            email: userLogged.email,
            firebaseId: userLogged.firebaseId,
            profileImage: userLogged.profileImage,
            phone: userLogged.phone);
        taskProvider.addUser(user);
        if (mounted) {
          GoRouter.of(context).go('/home');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 370,
              width: 370,
              child: ClipRect(
                child: Image.network(
                    'https://res.cloudinary.com/musica-reservation/image/upload/v1721250868/task_c29wb6.png'),
              ),
            ),
            Text(
              'My ToDo Friend',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Simplifica, planifica, logra.',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 45,
                  width: 170,
                  child: OutlinedButton(
                    onPressed: () {
                      GoRouter.of(context).go('/login');
                      // Define the action that happens when the button is pressed
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Sin border radius
                      ),
                      side: const BorderSide(
                          color: Colors.blue), // Color del borde
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 45,
                  width: 170,
                  child: OutlinedButton(
                    onPressed: () {
                      GoRouter.of(context).go('/register');
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Sin border radius
                      ),
                      side: BorderSide(
                          color: Theme.of(context)
                              .primaryColor), // Color del borde
                    ),
                    child: const Text(
                      'Registrate',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
