class UserRecord {
  final int? userId;
  final int timeRecord;
  final int? levelGame;
 
  UserRecord({
    this.userId,
    required this.timeRecord,
    required this.levelGame,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'timeRecord': timeRecord,
      'levelGame': levelGame,
    };
  }

  factory UserRecord.fromMap(Map<String, dynamic> map) {
    return UserRecord(
      userId: map['userId'],
      timeRecord: map['timeRecord'],
      levelGame: map['levelGame'],
    );
  }
}
