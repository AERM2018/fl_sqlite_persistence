import 'dart:io';

import 'package:persistence_app/models/cat_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper{
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  static Database? _db;

  Future<Database> get db async => _db ?? await _initDb();

  Future<Database> _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,"animals.db");
    return await openDatabase(path,version: 1,onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE cats(
        id INTEGER PRIMARY KEY,
        race VARCHAR(50),
        name VARCHAR(50),
        picPath VARCHAR(150)
      );
      '''
    );
  }

  Future<int> addCat(Cat cat) async{
    Database db = await instance.db;
    return await db.insert('cats', cat.toMap());
  }

  Future<List<Cat>> getCats() async{
    Database db = await instance.db;
    var cats =  await db.query('cats',orderBy: "race");
    return cats.isNotEmpty ?  cats.map((cat) => Cat.fromMap(cat)).toList() : [];
  }

  Future<dynamic> deleteCat(int id) async {
    Database db = await instance.db;
    return await db.delete('cats',where: 'id = $id');
  }

  Future<dynamic> updateCat(Cat cat,int id) async {
    Database db = await instance.db;
    final catUpdated = cat.toMap();
    catUpdated['id'] = id;
    return await db.update('cats', catUpdated ,where: 'id = $id');
  }
}