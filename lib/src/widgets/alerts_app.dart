import 'package:flutter/material.dart';

class AlertsApp {
  static showLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static showMessage(BuildContext context, String title, String buttonTitle,
      String content, Function action) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      action();
                    },
                    child: Text(buttonTitle))
              ],
              title: Text(title),
              content: Text(
                content,
                style: const TextStyle(fontSize: 15),
              ),
            ));
  }

  static showMessageOptions(
    BuildContext context,
    String title,
    String buttonTitle,
    String buttonTitleTwo,
    String content,
    Function action,
    Future<void> Function() actionTwo,
  ) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      action();
                    },
                    child: Text(buttonTitle)),
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await actionTwo();
                    },
                    child: Text(buttonTitleTwo)),
              ],
              title: Text(title),
              content: Text(
                content,
                style: const TextStyle(fontSize: 15),
              ),
            ));
  }
}
