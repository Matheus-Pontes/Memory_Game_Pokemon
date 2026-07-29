import 'package:memory_game_pokemon/database/database.dart';
import 'package:memory_game_pokemon/models/user.dart';
import 'package:memory_game_pokemon/models/user_record.dart';
import 'package:memory_game_pokemon/models/user_view_model.dart';

class UsuarioRepository {
  final dbProvider = AppDatabase.instance;

  // INSERT
  Future<int> inserir(User usuario) async {
    final db = await dbProvider.database;

    return await db.insert(
      'Users',
      usuario.toMap(),
    );
  }

  // SELECT ALL
  Future<List<User>> listar() async {
    final db = await dbProvider.database;

    final result = await db.query('Users');

    return result.map((e) => User.fromMap(e)).toList();
  }

  // UPDATE
  Future<int> atualizar(User usuario) async {
    final db = await dbProvider.database;

    return await db.update(
      'Users',
      usuario.toMap(),
      where: 'userId = ?',
      whereArgs: [usuario.userId],
    );
  }

  // DELETE
  Future<int> deletar(int id) async {
    final db = await dbProvider.database;

    return await db.delete(
      'Users',
      where: 'userId = ?',
      whereArgs: [id],
    );
  }

  // OBTER RANKING
  Future<Map<int, List<UserViewModel>>> obterRanking() async {
    final db = await dbProvider.database;

    final records = await db.rawQuery('''
      SELECT * FROM UserRecords
    ''');

    final result = await db.rawQuery('''
      SELECT u.userId, u.name, ur.timeRecord, ur.levelGame
      FROM Users u
      INNER JOIN UserRecords ur ON u.userId = ur.userId
      ORDER BY ur.levelGame, ur.timeRecord ASC
    ''');

    Map<int, List<UserViewModel>> rankings = {0: [], 1: [], 2: []};

    for (var row in result) {
      int level = row['levelGame'] as int;
      
      rankings[level]!.add(UserViewModel(
        userId: row['userId'] as int,
        name: row['name'] as String,
        level: level,
        timeRecord: row['timeRecord'] as int,
      ));
      
    }

    // Limitar a 10 por nível
    rankings.forEach((key, value) {
      if (value.length > 10) {
        rankings[key] = value.sublist(0, 10);
      }
    });

    return rankings;
  }

  // INSERT USER RECORD
  Future<int> inserirUserRecord(UserRecord? record) async {
    final db = await dbProvider.database;

    return await db.insert('UserRecords', record!.toMap());
  }
}
