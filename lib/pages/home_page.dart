import 'package:flutter/material.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
    ["Title1", "metadata1", "deadline1", "description1", false],
    ["Title2", "metadata2", "deadline2", "description2", false]
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

  List<dynamic> taskList = [];
  List<dynamic> MainTaskList = [];

// load data from REST API
  void LoadData() async {
    // clearing the list
    taskList.clear();
    // clear todo list
    toDoList.clear();
    String _url = "http://127.0.0.1:8000/api/task";
    final uri = Uri.parse(_url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      taskList = json;
    });
    print('fetching completed');
    extract(taskList);
  }

 // converting json to proper data and add to list
  void extract(List<dynamic> taskList) {
    for (var i = 0; i < taskList.length; i++) {
      final data = taskList[i];
      //final int _id = data['id'];
      final _title = data['title'];
      final _metadata = data['metadata'];
      final _deadline = data['deadline'];
      final _description = data['description'];
      final _isfinished = data['isfinished'];
      List<dynamic> _temp = [
        //_id,
        _title,
        _metadata,
        _deadline,
        _description,
        _isfinished,
      ];
      toDoList.add(_temp);
    }
    print('rewriting list to new list with string url, completed.');
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
            FloatingActionButton(
              onPressed: () {
                LoadData(); // loading data from rest endpoint
              },
              child: Icon(Icons.add),
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