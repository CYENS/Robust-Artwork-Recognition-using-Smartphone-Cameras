import 'package:flutter/material.dart';
import 'package:modern_art_app/db/database.dart';
import 'package:modern_art_app/painting_list.dart';
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyDatabase db = Provider.of<MyDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
      ),
      body: StreamBuilder<List<Todo>>(
        stream: db.watchAllTodoEntries,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final todos = snapshot.data;
          return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) => PaintingTile(
                    paintingName: "painting ${todos[index].id}",
                    tileSideLength: 200,
                  ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          db.addTodo(TodosCompanion(
              title: Value("todosssssss"), content: Value("todo todo todo")));
        },
      ),
    );
  }
}
