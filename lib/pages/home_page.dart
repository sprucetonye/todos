import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todosapp/pages/add.dart';
import 'package:todosapp/pages/add_page.dart';
import 'package:todosapp/pages/completed_page.dart';
import 'package:todosapp/providers/todo_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> activeTodos = todos
        .where((todo) => todo.completed == false)
        .toList();

    List<Todo> completedTodos = todos
        .where((todo) => todo.completed == true)
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text("welcome to listEm", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: activeTodos.length + 1,
          itemBuilder: (context, index) {
            if (activeTodos.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 300.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Hello Creative mind",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "What Todos would you like to add for the day?",
                        style: TextStyle(
                          fontSize: 9.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "please feel free to use the button below",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (index == activeTodos.length) {
              if (completedTodos.isEmpty)
                return Container();
              else {
                return Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompletedTodo(),
                        ),
                      );
                    },
                    child: Text("Completed Todos"),
                  ),
                );
              }
            } else {
              return Slidable(
                startActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        ref
                            .watch(todoProvider.notifier)
                            .deleteTodo(activeTodos[index].todoId);
                      },
                      icon: Icons.delete,
                      padding: EdgeInsets.all(8.0),
                      backgroundColor: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ],
                ),

                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        ref
                            .watch(todoProvider.notifier)
                            .completeTodo(activeTodos[index].todoId);
                      },
                      icon: Icons.check,
                      padding: EdgeInsets.all(8.0),
                      backgroundColor: Colors.green,
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
                  child: ListTile(title: Text(activeTodos[index].content)),
                ),
              );
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodo()),
          );
        },
        tooltip: 'Increament',
        backgroundColor: Colors.black,

        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
