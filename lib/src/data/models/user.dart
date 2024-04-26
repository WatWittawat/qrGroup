import 'package:hive/hive.dart';
import 'package:qr_group/src/data/services/friend/friend_service.dart';
import 'package:qr_group/src/data/services/friend/friend_service_interface.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'user.g.dart';

const uuid = Uuid();

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  final String name;

  @HiveField(1)
  List<Qrcode> qrCodes;

  @HiveField(2)
  final String id;

  User({
    required this.name,
    List<Qrcode>? qrCodes,
    String? id,
  })  : id = id ?? uuid.v4(),
        qrCodes = qrCodes ?? [];

  static final userFriendProvider =
      StateNotifierProvider<UserFriendNotifier, List<User>>(
    (ref) => UserFriendNotifier(),
  );
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

class UserFriendNotifier extends StateNotifier<List<User>> {
  UserFriendNotifier() : super([]) {
    _loadUser();
  }

  final FriendServiceInterface _userService = FriendService();

  Future<void> _loadUser() async {
    state = await _userService.loadUser();
  }

  void addUser(String name) async {
    state = await _userService.addUser(name);
  }

  void editUser(String userID, String newName) async {
    state = await _userService.editUser(userID, newName);
  }

  void deleteUser(User user) async {
    state = await _userService.deleteUser(user);
  }

  void addQrcode(User user, Qrcode qrcode) async {
    state = await _userService.addQrcode(user, qrcode);
  }

  void deleteQrcode(User user, Qrcode qrcode) async {
    state = await _userService.deleteQrcode(user, qrcode);
  }

  void editQrcode(User user, Qrcode qrcode) async {
    state = await _userService.editQrcode(user, qrcode);
  }
}
