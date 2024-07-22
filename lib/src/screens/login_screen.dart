import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_friend/src/providers/task_provider.dart';
import 'package:todo_friend/src/services/auth_firebase_service.dart';
import 'package:todo_friend/src/services/user_service.dart';
import 'package:todo_friend/src/widgets/alerts_app.dart';
import 'package:todo_friend/src/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  login() async {
    AlertsApp.showLoading(context);

    var result = await UserService()
        .loginUserFirebase(emailController.text, passowordController.text);

    if (result != null) {
      if (!mounted) return;
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.addUser(result);
      Navigator.of(context).pop();
      GoRouter.of(context).go('/home');
    } else {
      if (!mounted) return;
      Navigator.of(context).pop();
      return AlertsApp.showMessage(context, 'Error', 'Cerrar',
          'La contrasena o el correo no existen!', () {});
    }
  }

  loginGoogle() async {
    var resultGoogle = await AuthFirebaseService().signInWithGoogle();
    if (!mounted) return;
    AlertsApp.showLoading(context);

    var result = await UserService().loginWithButtonGoogle(resultGoogle);

    if (result != null) {
      if (!mounted) return;
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.addUser(result);
      if (!mounted) return;
      Navigator.of(context).pop();
      GoRouter.of(context).go('/home');
    } else {
      if (!mounted) return;
      Navigator.of(context).pop();
      return AlertsApp.showMessage(context, 'Error', 'Cerrar',
          'Ocurrio un error intentalo de nuevo!', () {});
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passowordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Iniciar Sesion',
                style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                child: Text(
                  'Bienvenido de vuelta, ingresa tus datos para continuar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InputField(
                controller: emailController,
                label: 'Email',
                icon: Icons.email_outlined,
              ),
              InputField(
                controller: passowordController,
                label: 'Contrasenia',
                icon: Icons.password_outlined,
                isVisible: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Olvide mi contrasena',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    login();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Sin border radius
                    ),
                    side: BorderSide(
                        color:
                            Theme.of(context).primaryColor), // Color del borde
                  ),
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Crear nueva Cuenta',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'O continua con',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes agregar la lógica para iniciar sesión con Google
                  loginGoogle();
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      'https://cdn4.iconfinder.com/data/icons/logos-brands-7/512/google_logo-google_icongoogle-512.png', // Asegúrate de tener el logo de Google en la carpeta assets
                      height: 24.0,
                      width: 24.0,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Iniciar sesión con Google',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
