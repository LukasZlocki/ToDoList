import 'package:flutter/material.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final _titleController = TextEditingController();
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  // list of todos tasks
  List toDoList = [
    ["Make tutorial","aaa1","bbb1","cc1", false],
    ["Do excercise","aaa2","bbb2","cc2", false]
  ];

  // delete task with secific index
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  // tapped checkbox method
  void checkBoxChanged( bool? value, int index) {
    setState(() {
      toDoList[index][4] = !toDoList[index][4];
    });
  }

  // save new task
  void saveNewTask() {
    setState(() {
      toDoList.add([
        _titleController.text,
        _emailController.text,
        _descriptionController.text,
        _dateController.text,
        false
      ]);
      _titleController.clear();
      _emailController.clear();
      _descriptionController.clear();
      _dateController.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewTaskEmail() {
    createNewTask("email");
  }

  void createNewTaskMessage() {
    createNewTask("message");
  }

  void createNewTaskPhone() {
    createNewTask("phone");
  }

  // create a new task on button click
  void createNewTask(String createMode) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            rodzaj: createMode,
            titleController: _titleController,
            emailController: _emailController,
            descriptionController: _descriptionController,
            dateController: _dateController,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
      title: Text('To Do App'),
        elevation: 3,
      ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingActionButton(
                onPressed: createNewTaskEmail,
                child: Icon(Icons.email),
              ),
            FloatingActionButton(
                onPressed: createNewTaskPhone,
                child: Icon(Icons.phone),
              ),
            FloatingActionButton(
              onPressed: createNewTaskMessage,
              child: Icon(Icons.message),
            ),
          ],
            ),

        body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
                taskName: toDoList[index][0],
                taskCompleted: toDoList[index][4],
                onChanged: (value) => checkBoxChanged(value, index),
                onPressed: () => deleteTask(index),
            );
          }
        )
      );
  }
}