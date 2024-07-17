import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

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
                    'https://www.prosoftly.com/wp-content/uploads/2020/01/task.png'),
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
