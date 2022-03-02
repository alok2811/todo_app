// packages
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// the database helper class
class DatabaseHelper {
  // database name
  static const _databaseName = "notes.db";
  static const _databaseVersion = 1;

  // the table name
  static const table = "my_table";

  // column names
  static const columnID = 'id';
  static const columnTitle = "title";
  static const columnNotes = "notes";
  static const columnTimestamp = 'timestamp';

  // a database
  static Database? _database;

  // privateconstructor
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // asking for a database
  Future<Database> get databse async {
    if (_database != null) return _database!;

    // create a database if one doesn't exist
    _database = await _initDatabase();
    return _database!;
  }

  // function to return a database
  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // create a database since it doesn't exist
  Future _onCreate(Database db, int version) async {
    // sql code
    await db.execute('''
      CREATE TABLE $table (
        $columnID INTEGER PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnNotes TEXT NOT NULL,
        $columnTimestamp TEXT NOT NULL
      )
      ''');
  }

  // functions to insert data
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.databse;
    return await db.insert(table, row);
  }

  // function to query all the rows
  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.databse;
    return await db.query(table);
  }

  // function to queryspecific
  Future<List<Map<String, dynamic>>> queryspecific(int age) async {
    Database db = await instance.databse;
    // var res = await db.query(table, where: "age < ?", whereArgs: [age]);
    var res = await db.rawQuery('SELECT * FROM my_table WHERE age >?', [age]);
    return res;
  }

  // function to delete some data
  Future<int> deletedata(int id) async {
    Database db = await instance.databse;
    var res = await db.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }

  // function to update some data
  Future<int> update(int id) async {
    Database db = await instance.databse;
    var res = await db.update(table, {"name": "Desi Programmer", "age": 2},
        where: "id = ?", whereArgs: [id]);
    return res;
  }

  // function to update some data
  Future<int> deleateall() async {
    Database db = await instance.databse;
    var res = await db.delete(table);
    return res;
  }

}
