import 'package:flutter/material.dart';
import 'package:to_do_list/views/AddTodo.dart';
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
  @override
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
    );
  }
}

