import 'package:flutter/material.dart';
import 'package:tic_tac_toe/util/myButton.dart';

class NewTask extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  NewTask({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 100,
        color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Task",
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "Save", onPressed: onSave),
                const SizedBox(width: 10,),
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
