import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todosapp/pages/add.dart';
import 'package:todosapp/pages/add_page.dart';
import 'package:todosapp/providers/todo_provider.dart';

class CompletedTodo extends ConsumerWidget {
  const CompletedTodo({super.key});

  // class _HomePageState extends State<HomePage> {
  //   // Where I declared my routes here Tonye weldone man Wow God is good!

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Adding another logic here
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> completedTodos = todos
        .where((todo) => todo.completed == true)
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text("welcome to listEm", style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: completedTodos.length,
        itemBuilder: (context, index) {
          return Slidable(
            startActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    ref.watch(todoProvider.notifier).deleteTodo(completedTodos[index].todoId);
                  },
                  icon: Icons.delete,
                  padding: EdgeInsets.all(8.0),
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ],
            ),

            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: ListTile(title: Text(completedTodos[index].content)),
            ),
          );
        },
      ),
    );
  }
}
