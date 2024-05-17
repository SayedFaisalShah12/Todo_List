import 'package:notebook/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDatabase();
      return _db;
    }
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE todolist(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL, email TEXT NOT NULL, age INTEGER NOT NULL)");
  }

  Future<NoteModel> insert(NoteModel noteModel) async {
    var dbClient = await db;
    await dbClient!.insert('todolist', noteModel.toMap());
    return noteModel;
  }

  Future<List<NoteModel>> getNoteList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('todolist');
    return queryResult.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future <int> update(NoteModel noteModel) async {
    var dbClient = await db;
    return await dbClient!.update('todolist', noteModel.toMap(), where: 'id = ?', whereArgs: [noteModel.id]);
  }

  Future <int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('todolist', where: 'id = ?', whereArgs: [id]);
  }
}
