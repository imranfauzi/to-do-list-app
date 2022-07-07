import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:to_do_list/services/TodoService.dart';
import 'package:to_do_list/views/AddTodo.dart';
import 'package:to_do_list/views/EditTodo.dart';
import 'package:to_do_list/views/ViewTodo.dart';

import 'model/ToDo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  List<ToDo> _todoList = <ToDo>[];
  final _todoService = TodoService();
  bool _checked = false;

  getAllTodoDetails() async {
    var todos = await _todoService.ListAllTodo();
    _todoList = <ToDo>[];
    todos.forEach((todo) {
      setState(() {
        var todoModel = ToDo();
        todoModel.id = todo['id'];
        todoModel.title = todo['title'];
        todoModel.description = todo['description'];
        todoModel.isChecked = todo['isChecked'];
        _todoList.add(todoModel);
      });
    });
  }


  checkbox(int check){
    if(check==0){
      _checked = false;
    } else {
      _checked = true;
    }
    return _checked;
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllTodoDetails();
    super.initState();
  }

  Widget build(BuildContext context) {
    print("reloaded huhu");
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do-App"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddTodo()))
              .then((value) => {
                if(value!=null){
                  getAllTodoDetails()
                }
          });
        },
      ),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Card(
              child: CheckboxListTile(
                value: checkbox(_todoList[index].isChecked!),
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               ViewTodo(todo: _todoList[index])));
                // },

                controlAffinity: ListTileControlAffinity.platform,
                title: Text(_todoList[index].title ?? ''),
                subtitle: Text(_todoList[index].description ?? ''),
                activeColor: Colors.green,
                secondary: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditTodo(todo: _todoList[index])))
                              .then((value) {
                            if (value != null) {
                              getAllTodoDetails();
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.orangeAccent,
                        )),
                    IconButton(
                        onPressed: (){
                          var result =  _todoService.DeleteTodo(
                              _todoList[index].id);
                            getAllTodoDetails();
                            setState((){});
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),

                selectedTileColor: Colors.green,
                onChanged: (check) {
                  var _todo = ToDo();
                  setState((){
                    if(check == true) {
                      _todo.id = _todoList[index].id;
                      _todo.isChecked = 1;
                      _todo.title = _todoList[index].title;
                      _todo.description = _todoList[index].description;
                      var result = _todoService.UpdateTodo(_todo);
                      getAllTodoDetails();
                    } else {
                      _todo.id = _todoList[index].id;
                      _todo.isChecked = 0;
                      _todo.title = _todoList[index].title;
                      _todo.description = _todoList[index].description;
                      var result = _todoService.UpdateTodo(_todo);
                      getAllTodoDetails();
                    }
                  });


                },
              ),
            );
          }),
    );
  }
}
