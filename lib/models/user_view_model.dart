class UserViewModel {
  final int userId;
  final String name;
  int level;
  final int? timeRecord;

  UserViewModel({
    required this.userId,
    required this.name,
    required this.level,
    this.timeRecord,
  });
}
