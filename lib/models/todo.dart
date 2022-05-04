import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class todo {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String descript;

  @HiveField(2)
  late String date;

  @HiveField(3)
  late String time;

  @HiveField(4)
  late String fullname;

  @HiveField(5)
  late String user;

  @HiveField(6)
  late String password;
}
