import 'package:birthday_tracker/models/birthday_information.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _dbName = "birthday_remainder.db";
  DatabaseHelper._init();
  static DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(_dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getApplicationDocumentsDirectory();

    final path = join(dbPath.path, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final textType = "TEXT NOT NULL";
    final integerType = "INTEGER NOT NULL";

    await db.execute("""
    CREATE TABLE $tableBirthdayInfo(
      ${BirthdayInfoFields.id} $idType,
      ${BirthdayInfoFields.name} $textType,
      ${BirthdayInfoFields.phoneNo} $integerType,
      ${BirthdayInfoFields.dateofbirth} $textType
    )
    """);
  }

  Future<BirthdayInfo> create(BirthdayInfo birthdayInfo) async {
    final db = await instance.database;
    final id = await db.insert(tableBirthdayInfo, birthdayInfo.toJson());
    return birthdayInfo.copy(id: id);
  }

  Future<BirthdayInfo> readBithdayInfo(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableBirthdayInfo,
      columns: BirthdayInfoFields.values,
      where: "${BirthdayInfoFields.id} = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return BirthdayInfo.fromJson(maps.first);
    } else {
      throw Exception("ID $id not found");
    }
  }

  Future<List<BirthdayInfo>> readAllInfo() async {
    final db = await instance.database;

    final orderBy = '${BirthdayInfoFields.dateofbirth} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableBirthdayInfo, orderBy: orderBy);

    return result.map((json) => BirthdayInfo.fromJson(json)).toList();
  }

  Future<int> update(BirthdayInfo note) async {
    final db = await instance.database;

    return db.update(
      tableBirthdayInfo,
      note.toJson(),
      where: '${BirthdayInfoFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
