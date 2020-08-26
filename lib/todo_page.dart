import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/painting_list.dart';
import 'package:moor/moor.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyDatabase db = Provider.of<MyDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
        actions: [
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MoorDbViewer(db))))
        ],
      ),
      body: StreamBuilder<List<Painting>>(
        stream: db.watchAllPaintingEntries,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final paintings = snapshot.data;
          return ListView.builder(
              itemCount: paintings.length,
              itemBuilder: (context, index) => PaintingRow(
                  paintingName:
                      "${paintings[index].id} ${paintings[index].description}"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          db.addPainting(PaintingsCompanion(
              title: Value("todosssssss"),
              description: Value("todo todo todo")));
        },
      ),
    );
  }
}
