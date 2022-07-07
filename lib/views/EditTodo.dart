import 'package:flutter/material.dart';

import '../model/ToDo.dart';
import '../services/TodoService.dart';


class EditTodo extends StatefulWidget {
  final ToDo todo;
  const EditTodo({Key? key,required this.todo}) : super(key: key);

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  var _todoTitleController = TextEditingController();
  var _todoDescriptionController = TextEditingController();
  bool _validateTitle = false;
  bool _validateDescription = false;
  var _todoService=TodoService();

  @override
  void initState() {
    setState(() {
      _todoTitleController.text = widget.todo.title??'';
      _todoDescriptionController.text = widget.todo.description??'';
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite CRUD"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit ToDo',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _todoTitleController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Title',
                    labelText: 'Title',
                    errorText:
                    _validateTitle ? 'Title Cannot be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _todoDescriptionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Description',
                    labelText: 'Description',
                    errorText: _validateDescription
                        ? 'Description Cannot be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _todoTitleController.text.isEmpty
                              ? _validateTitle = true
                              : _validateTitle = false;
                          _todoDescriptionController.text.isEmpty
                              ? _validateDescription = true
                              : _validateDescription = false;
                        });
                        if (_validateTitle == false && _validateDescription == false) {
                          var _todo = ToDo();
                          _todo.id=widget.todo.id;
                          _todo.title = _todoTitleController.text;
                          _todo.description = _todoDescriptionController.text;
                          var result=await _todoService.UpdateTodo(_todo);
                          Navigator.pop(context,result);
                        }
                      },
                      child: const Text('Update Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _todoTitleController.text = '';
                        _todoDescriptionController.text = '';
                      },
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}