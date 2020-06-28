import 'package:myproject/AddRecord/data.dart';
import 'package:myproject/Friends/FriendsModel.dart';
import "package:sqflite/sqflite.dart";
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static const String TABLE_NAME = "Records";
  static const String COLUMN_ID = "id";
  static const String COLUMN_INCOME = "income";
  static const String COLUMN_EXPENDITURE = "expenditure";
  static const String COLUMN_DATETIME = "dateTime";
  static const String COLUMN_DESCRIPTION = "description";
  static const String COLUMN_TAGS = "tags";
  static const String COLUMN_FRIENDS = "friend";
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await db.initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), "records.db"),
      onCreate: (db, version) async {
        await db.execute(''' 
        CREATE TABLE $TABLE_NAME (
          $COLUMN_ID INTEGER PRIMARY KEY,
          $COLUMN_INCOME DOUBLE,
          $COLUMN_EXPENDITURE DOUBLE, 
          $COLUMN_DATETIME DATETIME,
          $COLUMN_DESCRIPTION TEXT, 
          $COLUMN_TAGS TEXT, 
          $COLUMN_FRIENDS TEXT
        )  
        ''');
      },
      version: 1,
    );
  }

  Future<List<Data>> getRecords() async {
    final db = await database;
    var data = await db.query(TABLE_NAME, columns: [
      COLUMN_ID,
      COLUMN_INCOME,
      COLUMN_EXPENDITURE,
      COLUMN_FRIENDS,
      COLUMN_TAGS,
      COLUMN_DESCRIPTION,
      COLUMN_DATETIME
    ]);
    List<Data> dataList = [];
    data.forEach((datum) {
      Data dat = Data.fromMap(datum);
      dataList.add(dat);
    });
    return dataList.reversed.toList();
  }

  Future<Data> insertData(Data datum) async {
    final db = await database;
    datum.id = await db.insert(TABLE_NAME, datum.toMap());
    return datum;
  }

  Future<int> deleteData(int id) async {
    final db = await database;
    return await db
        .delete(TABLE_NAME, where: "$COLUMN_ID = ?", whereArgs: [id]);
  }

  Future<List<FriendsModel>> getFriendsRecords() async {
    final db = await database;
    var data = await db.rawQuery(
        "select $COLUMN_FRIENDS, sum(ALL $COLUMN_INCOME) as Income, sum(ALL $COLUMN_EXPENDITURE) as Expenditure from $TABLE_NAME group by $COLUMN_FRIENDS ;");
    List<FriendsModel> dataList = [];
    data.forEach((datum) {
      FriendsModel dat = FriendsModel.fromMap(datum);
      dataList.add(dat);
    });
    return dataList.toList();
  }
}
