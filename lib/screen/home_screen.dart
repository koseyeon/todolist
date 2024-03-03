import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todolist/components/todo_card.dart';
import 'package:todolist/provider/todo_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(todoProvider.notifier).getTodoList();
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  final TextEditingController _todoController = TextEditingController();

  void _addTodo() {
    String description = _todoController.text.trim();
    if (description.isNotEmpty) {
      ref.read(todoProvider.notifier).onInsert(description);
      _todoController.clear();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("추가할 내용을 입력하세요"),
            content: Text("입력해라잉"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("닫기"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(todoProvider);
    if (state == null) {
      return CircularProgressIndicator();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('TodoList.'),
          leading: Container(),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 위젯을 화면의 위쪽에 정렬
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      return TodoCard(
                        todo: state[index].todo,
                        onToggleOfDone: () {
                          ref.read(todoProvider.notifier).onToggleOfDone(
                              state[index].id, state[index].todo.isDone);
                        },
                        onDelete: () {
                          ref
                              .read(todoProvider.notifier)
                              .onDeleteById(state[index].id);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: TextField(
                controller: _todoController,
                decoration: const InputDecoration(
                  labelText: '할 일을 입력하세요.',
                ),
                onSubmitted: (value) {
                  _addTodo();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTodo,
          tooltip: '할 일 추가',
          child: const Icon(Icons.save),
        ),
      );
    }
  }
}
