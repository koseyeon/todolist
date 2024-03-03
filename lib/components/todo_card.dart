import 'package:flutter/material.dart';
import 'package:todolist/model/todo_model.dart';
import 'package:todolist/util/date_time_util.dart';

class TodoCard extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onToggleOfDone;
  final VoidCallback onDelete;

  const TodoCard(
      {super.key,
      required this.todo,
      required this.onToggleOfDone,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          todo.description,
          style: TextStyle(
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text('작성시간 : ${formatDateTime(todo.createdAt)}',
            style: TextStyle(fontSize: 10)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: todo.isDone
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank),
              onPressed: onToggleOfDone,
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
