import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_friend/src/providers/task_provider.dart';
import 'package:todo_friend/src/services/auth_firebase_service.dart';
import 'package:todo_friend/src/services/user_service.dart';
import 'package:todo_friend/src/widgets/input_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  register() async {
    if (passwordController.text != repeatPasswordController.text) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'))
                ],
                title: const Text('Los passwords no coinciden.'),
              ));
    }

    var result = await UserService()
        .createUser(emailController.text, passwordController.text);

    if (result != null) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.addUser(result);
    }

    print(result);
  }

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
                'Crear Cuenta',
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
                  'Crea una cuenta y empieza a organizar tu tiempo',
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
                inputType: TextInputType.emailAddress,
              ),
              InputField(
                controller: passwordController,
                label: 'Contrasenia',
                icon: Icons.password_outlined,
                inputType: TextInputType.visiblePassword,
                isVisible: true,
              ),
              InputField(
                isVisible: true,
                controller: repeatPasswordController,
                label: 'Repita su Contrasenia',
                icon: Icons.password,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    register();
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
                    'Registrarme',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Ya tengo una Cuenta',
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
                  var authService = AuthFirebaseService();
                  authService.signInWithGoogle();
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
