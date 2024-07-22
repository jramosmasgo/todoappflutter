import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_friend/src/providers/task_provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool valueSwitch = false;
  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  'Configuracion',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    tileColor: Theme.of(context).cardColor,
                    leading: const Icon(Icons.dark_mode),
                    title: const Text('Color de Tema'),
                    trailing: CupertinoSwitch(
                        value: taskProvider.darkTheme,
                        onChanged: (value) {
                          setState(() {
                            taskProvider.setDarkMode(value);
                          });
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
