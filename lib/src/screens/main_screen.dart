import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_friend/src/config/user_database.dart';
import 'package:todo_friend/src/entities/user_entity.dart';
import 'package:todo_friend/src/providers/task_provider.dart';
import 'package:todo_friend/src/services/task_service.dart';
import 'package:todo_friend/src/views/home_view.dart';
import 'package:todo_friend/src/views/profile_view.dart';
import 'package:todo_friend/src/views/settings_view.dart';
import 'package:todo_friend/src/widgets/alerts_app.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  int selectedIndexSidebar = 0;

  exitApp() async {
    AlertsApp.showMessageOptions(context, "Alerta", "Cancelar", "Salir",
        "Esta seguro que desea eliminar salir de la sesion?", () {}, () async {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      await UserHelper().deleteUser('');
      taskProvider.resetStatus();
      if (mounted) context.go("/init");
    });
  }

  @override
  void initState() {
    super.initState();
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    Future.delayed(Duration.zero, () async {
      if (taskProvider.userlogued != null) {
        var result = await TaskService().getTasks(taskProvider.userlogued!.id);
        taskProvider.addListTask(result);
        if (result.isNotEmpty) taskProvider.filterTasksByDate(DateTime.now());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    final views = [const HomeView(), const ProfileView(), const SettingsView()];

    return Scaffold(
      appBar: _buildAppBar(taskProvider.userlogued!.profileImage),
      body: SafeArea(
          child: IndexedStack(
        index: selectedIndex,
        children: views,
      )),
      drawer: _buildDrawer(
          taskProvider.userlogued ??
              UserEntity(
                  id: '',
                  name: '',
                  email: '',
                  firebaseId: '',
                  profileImage: '',
                  phone: ''),
          selectedIndex),
    );
  }

  AppBar _buildAppBar(String image) {
    return AppBar(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      toolbarHeight: 70,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(image),
          ),
        ),
      ]),
    );
  }

  Drawer _buildDrawer(UserEntity user, int activeRoute) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        children: [
          const SizedBox(
            height: 70,
          ),
          ListTile(
            subtitle: Text(
              user.email,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            leading: SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(user.profileImage),
              ),
            ),
            title: Text(
              user.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
              Navigator.of(context).pop();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: activeRoute == 0
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            leading: Icon(
              Icons.home,
              color: activeRoute == 0
                  ? Theme.of(context).textSelectionTheme.selectionColor
                  : Theme.of(context).textSelectionTheme.selectionHandleColor,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                  color: activeRoute == 0
                      ? Theme.of(context).textSelectionTheme.selectionColor
                      : Theme.of(context)
                          .textSelectionTheme
                          .selectionHandleColor),
            ),
          ),
          ListTile(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
                Navigator.of(context).pop();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: activeRoute == 1
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              leading: Icon(
                Icons.account_circle,
                color: activeRoute == 1
                    ? Theme.of(context).textSelectionTheme.selectionColor
                    : Theme.of(context).textSelectionTheme.selectionHandleColor,
              ),
              title: Text(
                'Mi perfil',
                style: TextStyle(
                    color: activeRoute == 1
                        ? Theme.of(context).textSelectionTheme.selectionColor
                        : Theme.of(context)
                            .textSelectionTheme
                            .selectionHandleColor),
              )),
          ListTile(
            onTap: () {
              setState(() {
                selectedIndex = 2;
              });
              Navigator.of(context).pop();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: activeRoute == 2
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            leading: Icon(
              Icons.settings,
              color: activeRoute == 2
                  ? Theme.of(context).textSelectionTheme.selectionColor
                  : Theme.of(context).textSelectionTheme.selectionHandleColor,
            ),
            title: Text(
              'Configuracion',
              style: TextStyle(
                  color: activeRoute == 2
                      ? Theme.of(context).textSelectionTheme.selectionColor
                      : Theme.of(context)
                          .textSelectionTheme
                          .selectionHandleColor),
            ),
          ),
          ListTile(
            onTap: () {
              exitApp();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Colors.transparent,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            leading: const Icon(
              Icons.exit_to_app,
            ),
            title: const Text(
              'Salir',
            ),
          ),
        ],
      ),
    );
  }
}
