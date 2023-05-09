import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final String rodzaj;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.rodzaj,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Title' + rodzaj
            ),
          // get user input
          TextField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task here"
            ),
          ),

          // buttons like save or cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            // save button
            MyButton(text: "Save", onPressed: onSave),

            const SizedBox(width: 8),
            // cancel button
              MyButton(text: "Cancel", onPressed: onCancel),
          ],)

        ],),
      ),
    );
  }
}
