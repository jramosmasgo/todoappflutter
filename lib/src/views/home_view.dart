import 'package:flutter/material.dart';
import 'package:todo_friend/src/widgets/list_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFEEEFF5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Container(
                  margin: const EdgeInsets.only(
                    top: 50,
                    bottom: 20,
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      Material(
                        child: ListItem(
                            title: "Estudiar Ingles",
                            description: "description",
                            colorLevel: Colors.red.shade400),
                      ),
                      Material(
                        child: ListItem(
                            title: "Aprender Guitarra",
                            description: "description",
                            colorLevel: Colors.green.shade400),
                      ),
                      Material(
                        child: ListItem(
                            title: "Universidad Recoger Panfletos",
                            description: "description",
                            colorLevel: Colors.orange.shade400),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget searchBox() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextField(
      onChanged: (value) => {},
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black,
          size: 20,
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 20,
          minWidth: 25,
        ),
        border: InputBorder.none,
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    ),
  );
}
