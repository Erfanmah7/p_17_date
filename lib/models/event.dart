import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 2)
class Event{

  @HiveField(0)
  final String title;

  @HiveField(1)
  Event ({required this.title});

  //String tostring() => this.title;

}