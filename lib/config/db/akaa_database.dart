import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ykapay/config/models/akaa_model.dart';

class ToDoDatabase {
  static final ToDoDatabase instance = ToDoDatabase._init();

  static Database _database;
  ToDoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('todo.db');

    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const typeInt = 'INTEGER NOT NULL';
    const typeString = 'STRING NOT NULL';

    await db.execute('''
      CREATE TABLE $table(
        ${AkaaFiles.account} $typeString,
        ${AkaaFiles.atm} $typeString,
        ${AkaaFiles.momo} '$typeString,
        ${AkaaFiles.zalo} $typeString,
      )
    ''');
  }

  Future<AkaaModel> create(AkaaModel todo) async {
    final db = await instance.database;

    // final json = todo.toJson();
    // final columns = '${AkaaFiles.title}';
    // final values = '${json[AkaaFiles.title]}';
    // final id = await db.rawInsert('INSERT INTO table_name ($columns) VALUE ($values)');

    final id = await db.insert(table, todo.toJson());

    return todo.copy(id: id);
  }

  Future<AkaaModel> readToDo(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      table,
      columns: AkaaFiles.values,
      where: '${AkaaFiles.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return AkaaModel.fromJson(maps.first);
    } else {
      throw Exception('Not found');
    }
  }

  Future<List<AkaaModel>> readAllToDo() async {
    final db = await instance.database;
    const orderBy = '`${AkaaFiles.id}` ASC';
    final result = await db.rawQuery('SELECT * FROM `$table` ORDER BY $orderBy');
    return result.map((e) => AkaaModel.fromJson(e)).toList();
  }

  Future<int> update(AkaaModel todo) async {
    final db = await instance.database;

    return db.update(
      table,
      todo.toJson(),
      where: '${AkaaFiles.id} = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      table,
      where: '${AkaaFiles.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
