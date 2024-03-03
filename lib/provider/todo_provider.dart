import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/datasource/firestore.dart';
import 'package:todolist/model/todo_item_model.dart';
import 'package:todolist/model/todo_model.dart';

final todoProvider =
    StateNotifierProvider<TodoStateNotifier, List<TodoItemModel>>((ref) {
  final notifier = TodoStateNotifier(collection: todoListCollection);
  notifier.getTodoList();
  return notifier;
});

class TodoStateNotifier extends StateNotifier<List<TodoItemModel>> {
  final collection;
  TodoStateNotifier({required this.collection}) : super([]);

  void getTodoList() async {
    List<TodoItemModel> _todoList = [];
    await collection
        .where('author', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        _todoList.add(TodoItemModel(
            id: docSnapshot.id,
            todo: TodoModel.fromJson(
                docSnapshot.data() as Map<String, dynamic>)));
      }
    });
    state = _todoList;
  }

  void onDeleteById(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {}
    getTodoList();
  }

  void onInsert(String description) async {
    await collection.add({
      'description': description,
      'author': FirebaseAuth.instance.currentUser!.email,
      'isDone': false,
      'createdAt': DateTime.now()
          .toUtc()
          .add(Duration(hours: 9))
          .toString()
          .split('.')[0]
    });
    getTodoList();
  }

  void onToggleOfDone(String id, bool isDone) async {
    await collection.doc(id).update({'isDone': !isDone});
    getTodoList();
  }
}
