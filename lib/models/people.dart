import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'people.g.dart';

const uuid = Uuid();

@HiveType(typeId: 1)
class People {
  @HiveField(0)
  final String name;

  @HiveField(1)
  List<Qrcode> qrCodes;

  @HiveField(2)
  final String id;

  People({
    required this.name,
    List<Qrcode>? qrCodes,
    String? id,
  })  : id = id ?? uuid.v4(),
        qrCodes = qrCodes ?? [];
}

@HiveType(typeId: 2)
class Qrcode {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String imagePath;

  @HiveField(2)
  final String id;

  Qrcode({
    required this.name,
    required this.imagePath,
    String? id,
  }) : id = id ?? uuid.v4();
}

@HiveType(typeId: 3)
class Group {
  @HiveField(0)
  final String name;

  @HiveField(1)
  List<People> listpeople;

  @HiveField(2)
  final String id;

  Group({
    required this.name,
    List<People>? listpeople,
    String? id,
  })  : id = id ?? uuid.v4(),
        listpeople = listpeople ?? [];
}
