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
      content: Container(height: 340,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            // title area
            Text(
              'Title'
            ),
          // get user input
          TextField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task here"
            ),
          ),

            // email or phone number area
            Text(
                '' + rodzaj
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add " + rodzaj + " here"
              ),
            ),

            // description area
            Text(
                'Description'
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add description here"
              ),
            ),

            // date
            Text(
                'Date'
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add date here"
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
