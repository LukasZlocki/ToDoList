import 'package:flutter/material.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
      title: Text('To Do'),
        elevation: 3,
    ),
        body: ListView(
        children: [
          ToDoTile(
            taskName: "make tutorial1",
            taskCompleted: true,
            onChanged: (p0) {},
          ),
      ],
    ),
    );
  }
}