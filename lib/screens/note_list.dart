import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notebook/db/database_helper.dart';
import 'package:notebook/models/models.dart';

import 'note_dialoge.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  DBHelper? dbHelper;
  late Future<List<NoteModel>> noteList;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    setState(() {
      noteList = dbHelper!.getNoteList();
    });
  }

  void deleteNote(int id) {
    dbHelper!.delete(id).then((value) {
      loadData();  // Refresh the list after deleting
    });
  }

  void editNote(NoteModel note) {
    dbHelper!.update(note).then((value) {
      loadData();  // Refresh the list after updating
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text('Todo List', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<NoteModel>>(
                  future: noteList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Notes Available'));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var note = snapshot.data![index];
                        return Card(
                          color: Colors.cyanAccent.withOpacity(0.7),
                          child: ListTile(
                            title: Text(note.title),
                            subtitle: Text(note.description),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => NoteDialog(
                                        note: note,
                                        onSave: editNote,
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deleteNote(note.id!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => NoteDialog(
              note: NoteModel(
                title: '',
                description: '',
                email: '',
                age: 0,

              ),
              onSave: (newNote) {
                dbHelper!.insert(newNote).then((value) {
                  loadData();
                });
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}




