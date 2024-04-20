import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class People {
  final String name;
  List<Qrcode>? qrCodes;
  String? id;
  People({required this.name, String? id, List<Qrcode>? qrCodes})
      : id = id ?? uuid.v4(),
        qrCodes = qrCodes ?? [];
}

class Qrcode {
  final String name;
  final File image;
  String? id;
  Qrcode({required this.name, required this.image, String? id})
      : id = id ?? uuid.v4();
}

class ListGroup {
  String? id;
  final String name;
  final List<People> people;

  ListGroup({
    required this.people,
    required this.name,
    String? id,
  }) : id = id ?? uuid.v4();
}
