import 'package:flutter/material.dart';
import 'package:test_task/constants.dart';

class ActionsPage extends StatelessWidget {
  const ActionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kColor,
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Hero(
                  tag: 'button',
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                      backgroundColor: Colors.white, // <-- Button color
                      foregroundColor: Colors.red, // <-- Splash color
                    ),
                    child: const Icon(Icons.close, color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const MenuItem(
                  itemName: 'Reminder',
                ),
                const MenuItem(
                  itemName: 'Camera',
                ),
                const MenuItem(
                  itemName: 'Attachment',
                ),
                const MenuItem(
                  itemName: 'Text Note',
                ),
                const MenuItem(
                  itemName: 'Reminder',
                ),
                const MenuItem(
                  itemName: 'Camera',
                ),
                const MenuItem(
                  itemName: 'Attachment',
                ),
                const MenuItem(
                  itemName: 'Text Note',
                ),
                const MenuItem(
                  itemName: 'Reminder',
                ),
                const MenuItem(
                  itemName: 'Camera',
                ),
                const MenuItem(
                  itemName: 'Attachment',
                ),
                const MenuItem(
                  itemName: 'Text Note',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.itemName,
  });

  final String itemName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          itemName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
