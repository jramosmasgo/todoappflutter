import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String description;
  final Color colorLevel;

  const ListItem(
      {super.key,
      required this.title,
      required this.description,
      required this.colorLevel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).primaryColor)),
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        tileColor: colorLevel,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        title: Text(
          title,
          style:
              const TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(color: Colors.white),
        ),
        leading: const Icon(
          color: Colors.white,
          Icons.today,
        ),
        trailing: Icon(
          color: Theme.of(context).primaryColor,
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}
