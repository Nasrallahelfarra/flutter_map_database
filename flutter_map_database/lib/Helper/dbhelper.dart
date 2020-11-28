import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_map_database/data/model/Location.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;

  DbHelper.internal();
  static Database _db;

  Future<Database> createDatabase() async{
    if(_db != null){
      return _db;
    }
    //define the path to the database
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "demo_asset_example.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "locationdb.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }
// open the database
    _db = await openDatabase(path);
   /* String path = join(await getDatabasesPath(), 'school.db');
    _db = await openDatabase(path,version: 2, onCreate: (Database db, int v){
      //create tables
      db.execute('create table courses(id integer primary key autoincrement, name varchar(50), content varchar(255), hours integer)');

    },onUpgrade: (Database db, int oldV, int newV) async{
      if(oldV < newV) {
        await db.execute("alter table courses add column level varchar(50) ");
      }
    });*/
    return _db;
  }
   Future<int> createLocations(Locations mLocations) async{
    Database db = await createDatabase();
    //db.rawInsert('insert into courses value')
     return db.insert('location', mLocations.toMap());
   }
   Future<List> alllocation() async{
      Database db = await createDatabase();
      //db.rawQuery('select * from courses');
     return db.query('location');
   }

   Future<int> delete(int id) async{
     Database db = await createDatabase();
     return db.delete('location', where: 'id = ?', whereArgs: [id]);
   }
   Future<int> courseUpdate(Locations mLocations) async{
     Database db = await createDatabase();
     return await db.update('location', mLocations.toMap(),where: 'id = ?', whereArgs: [mLocations.id]);
   }
}