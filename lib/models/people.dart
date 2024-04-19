import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class People {
  final String name;
  final File image;
  String? id;
  People({required this.name, required this.image, String? id})
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
