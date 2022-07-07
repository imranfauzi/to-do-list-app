import 'package:flutter/material.dart';
import 'package:to_do_list/services/TodoService.dart';
import 'package:to_do_list/views/AddTodo.dart';

import 'model/ToDo.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do-List',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyToDoList(),
    );
  }
}

class MyToDoList extends StatefulWidget {
  const MyToDoList({Key? key}) : super(key: key);

  @override
  _MyToDoListState createState() => _MyToDoListState();
}

class _MyToDoListState extends State<MyToDoList> {

  late List<ToDo> _todoList = <ToDo>[];
  final _todoService = TodoService();

  getAllTodoDetails() async {
    var todos = await _todoService.ListAllTodo();
    _todoList = <ToDo>[];
    todos.forEach((todo) {
      setState(() {
        var todoModel = ToDo();
        todoModel.id = todo['id'];
        todoModel.title = todo['title'];
        todoModel.description = todo['description'];
        _todoList.add(todoModel);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllTodoDetails();
    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do-App"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTodo()));
        },

      ),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {},
                leading: const Icon(Icons.person),
                title: Text(_todoList[index].title ?? ''),
                subtitle: Text(_todoList[index].description ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit, color: Colors.orangeAccent,)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete, color: Colors.red,))
                  ],
                ),
              ),
            );
          }),
    );
  }
}

