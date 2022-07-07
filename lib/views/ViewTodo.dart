import 'package:flutter/material.dart';
import 'package:to_do_list/model/ToDo.dart';

class ViewTodo extends StatefulWidget {
  final ToDo todo;
  const ViewTodo({Key? key, required this.todo}) : super(key: key);

  @override
  State<ViewTodo> createState() => _ViewTodoState();
}

class _ViewTodoState extends State<ViewTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do-App")
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "To-Do Details",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.orangeAccent,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text('Title',
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(widget.todo.title ?? '', style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Description',
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 20,
                ),
                Text(widget.todo.description ?? '', style: const TextStyle(fontSize: 16)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
