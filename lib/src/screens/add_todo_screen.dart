import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_friend/src/widgets/input_field.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController taskName = TextEditingController();
  DateTime startDate = DateTime.now();
  String dropDownValue = 'uno';
  String dropDownImportantLevelValue = 'bajo';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 70,
          elevation: 0,
          title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.purple, fontSize: 20),
                ),
                Text(
                  'Agregar Tarea',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                Text('Agregar',
                    style: TextStyle(color: Colors.purple, fontSize: 20))
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
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.red,
                            label: Text('Descripcion')),
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
                          Text(startDate.toString()),
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
                            value: dropDownValue,
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
                                dropDownValue = value!;
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
                                DropdownMenuItem<String>(
                                  value: 'bajo',
                                  child: Text("Bajo"),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'medio',
                                  child: Text("Medio"),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'alto',
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
                            value: false,
                            onChanged: (value) => {},
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