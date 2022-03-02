import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../helpers/custom_functions.dart';
import '../helpers/sqflite_helper.dart';


class HomeProvider with ChangeNotifier{
  final dbHelper =  DatabaseHelper.instance;

  List notesList = [];


  Future<List> queryAll() async {
     notesList =  await dbHelper.queryall();
    return notesList;
  }

  void  insertData({String title= 'Untitled', required String notes}) async {
    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yy');
    String date = formatterDate.format(now);

    Map<String, dynamic> row = {
      DatabaseHelper.columnTitle:  title,
      DatabaseHelper.columnNotes:  notes,
      DatabaseHelper.columnTimestamp:  date
    };
    await dbHelper.insert(row);
    notesList =  await dbHelper.queryall();
    print(notesList);
    notifyListeners();
  }

  void deleteData({required int id, required BuildContext context}) async {
    await dbHelper.deletedata(id);
    notesList =  await dbHelper.queryall();
    notifyListeners();
  }

  void deleteAll() async {
    await dbHelper.deleateall();
    notesList =  await dbHelper.queryall();
    notifyListeners();
  }



}