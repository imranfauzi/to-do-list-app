

import 'package:to_do_list/db/repository.dart';
import 'package:to_do_list/model/ToDo.dart';

class TodoService {

  late Repository _repository;
  TodoService(){
    _repository = Repository();
  }

  StoreTodo(ToDo todo) async {
    return await _repository.insertData("todos", todo.todoMap());
  }

  ListAllTodo() async {
    return await _repository.readData("todos");
  }

  UpdateTodo(ToDo todo) async {
    return await _repository.updateData("todos", todo.todoMap());
  }

  DeleteTodo(todoId) async {
    return await _repository.deleteDataById("todos", todoId);
  }


}