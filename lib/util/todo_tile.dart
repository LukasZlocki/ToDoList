import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function() onPressed;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.onPressed,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // check box
          Checkbox(
              value: taskCompleted,
              onChanged: onChanged,
              activeColor: Colors.black
          ),
          // task name
          Text(
              taskName,
              style: TextStyle(decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none),
          ),
          // Delete button
          IconButton(
            color: Colors.red,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: onPressed,
          )
        ],
        ),
      ),
    );
  }
}