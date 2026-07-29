import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;

  AppDatabase._init();

  // Retorna o banco (abre ou cria)
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pokemonmemory.db');
    return _database!;
  }

  // Inicializa o banco
  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  // Criação das tabelas
  Future _createDB(Database db, int version) async {
    
    await db.execute('''
      CREATE TABLE Users (
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE UserRecords (
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        timeRecord INTEGER NOT NULL,
        levelGame INTEGER NOT NULL,

        FOREIGN KEY (userId)
          REFERENCES Users (userId)
          ON DELETE CASCADE
          ON UPDATE CASCADE
      );
    ''');
  }
  

  // Fechar banco
  Future close() async {
    final db = await instance.database;
    db.close();
  }

  // Inicializa o banco de dados
  Future<void> initialize() async {
    try {
      await database;
    } catch (e) {
      throw Exception('Erro ao inicializar o banco de dados: $e');
    }
  }
}
