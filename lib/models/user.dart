import 'package:memory_game_pokemon/models/user_record.dart';

class User {
  final int? userId;
  final String name;
 
  final UserRecord? userRecord;

  User({
    this.userId,
    required this.name,
    this.userRecord
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      name: map['name'],
      userRecord: map['userRecord'],
    );
  }
}
