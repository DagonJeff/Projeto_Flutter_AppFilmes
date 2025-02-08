import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Verbidung {
  static Future<Database> getConnection() async {
    String path = await getDatabasesPath(); //data/data/pacote/databases
    String dbPath =
        join(path, "filmesdb.db"); //data/data/pacote/databases/contadosdb.db
    return await openDatabase(dbPath, onCreate: (db, version) {
      db.execute("CREATE TABLE filmes("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "url TEXT,"
          "title TEXT,"
          "genre TEXT,"
          "ageGroup TEXT,"
          "duration TEXT,"
          "score INTEGER,"
          "description TEXT,"
          "year INTEGER"
          ")");
    }, version: 1);
  }
}
