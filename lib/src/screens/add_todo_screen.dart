import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_friend/src/entities/task_entity.dart';
import 'package:todo_friend/src/providers/task_provider.dart';
import 'package:todo_friend/src/services/task_service.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDetail = TextEditingController();
  TextEditingController taskDuration = TextEditingController();
  TextEditingController taskLocation = TextEditingController();

  DateTime startDate = DateTime.now();
  String dropDownValueRepetir = 'uno';
  int dropDownImportantLevelValue = 1;
  bool taskAlert = false;

  saveData() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    TaskEntity newTask = TaskEntity(
        id: '',
        title: taskName.text,
        details: taskDetail.text,
        startDate: startDate,
        durationMinutes: int.parse(taskDuration.text),
        level: dropDownImportantLevelValue,
        location: taskLocation.text,
        alert: taskAlert,
        repeatType: dropDownValueRepetir);

    var service = TaskService();
    bool result = await service.sendDataTask(newTask);

    Navigator.of(context).pop();

    if (result) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.addTask(newTask);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pop(context);
                      },
                      child: Text('Ok'))
                ],
                title: const Text('Tarea registrada'),
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
                title: Text('Algo salio Mal vuelvalo a intentar'),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 70,
          elevation: 0,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(
              width: 30,
            ),
            const Text(
              'Agregar Tarea',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            TextButton(
                onPressed: () {
                  saveData();
                },
                child: const Text(
                  'Crear',
                  style: TextStyle(fontSize: 20),
                ))
          ]),
        ),
        body: Container(
          color: const Color(0xFFEEEFF5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      color: Colors.white,
                      child: TextFormField(
                        controller: taskName,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.red,
                            label: Text('Titulo')),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      color: Colors.white,
                      child: TextFormField(
                        controller: taskDetail,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.red,
                            label: Text('Descripcion (opcional)')),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Container(
                      height: 57,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Inicio'),
                          Text(
                              DateFormat('dd/MM/yyyy kk:mm').format(startDate)),
                          OutlinedButton(
                            child: const Icon(Icons.calendar_month),
                            onPressed: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => SizedBox(
                                        height: 250,
                                        child: CupertinoDatePicker(
                                          backgroundColor: Colors.white,
                                          initialDateTime: DateTime.now(),
                                          onDateTimeChanged: (DateTime value) {
                                            setState(() {
                                              startDate = value;
                                            });
                                          },
                                        ),
                                      ));
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      color: Colors.white,
                      child: TextFormField(
                        controller: taskDuration,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.red,
                            label: Text('Duracion Minutos')),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Repetir'),
                          DropdownButton<String>(
                            value: dropDownValueRepetir,
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'uno',
                                child: Text("Una vez"),
                              ),
                              DropdownMenuItem<String>(
                                value: 'dos',
                                child: Text("Diariamente"),
                              ),
                              DropdownMenuItem<String>(
                                value: 'tres',
                                child: Text("Semanalmente"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                dropDownValueRepetir = value!;
                              });
                            },
                            icon: const Icon(Icons.menu_sharp),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Importancia'),
                          DropdownButton(
                              value: dropDownImportantLevelValue,
                              items: const [
                                DropdownMenuItem<int>(
                                  value: 1,
                                  child: Text("Bajo"),
                                ),
                                DropdownMenuItem<int>(
                                  value: 2,
                                  child: Text("Medio"),
                                ),
                                DropdownMenuItem<int>(
                                  value: 3,
                                  child: Text("Alto"),
                                ),
                              ],
                              onChanged: (event) {
                                setState(() {
                                  dropDownImportantLevelValue = event!;
                                });
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      color: Colors.white,
                      child: TextFormField(
                        controller: taskLocation,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.red,
                            label: Text('Lugar (opcional)')),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Alerta'),
                          CupertinoSwitch(
                            value: taskAlert,
                            onChanged: (value) => {
                              setState(() {
                                taskAlert = value;
                              })
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Container(
//                           color: Colors.white,
//                           padding:
//                               EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//                           child: TextFormField(
//                             decoration: const InputDecoration(
//                                 border: InputBorder.none,
//                                 fillColor: Colors.red,
//                                 label: Text('Titulo')),
//                           )),