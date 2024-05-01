import 'package:hive/hive.dart';
import 'package:qr_group/src/common/constants/hive_box_name.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/data/services/friend/friend_service_interface.dart';

class FriendService implements FriendServiceInterface {
  final String nameuserBox = HiveBoxName.userBox;
  final String namegroupBox = HiveBoxName.groupBox;

  @override
  Future<List<User>> loadUser() async {
    final box = await Hive.openBox<User>(nameuserBox);
    return box.values.toList();
  }

  @override
  Future<List<User>> addUser(String name) async {
    final box = await Hive.openBox<User>(nameuserBox);
    final user = User(name: name);
    box.add(user);
    return box.values.toList();
  }

  @override
  Future<List<User>> editUser(String userID, String newName) async {
    final box = await Hive.openBox<User>(nameuserBox);
    final index = box.values.toList().indexWhere((user) => user.id == userID);
    if (index >= 0) {
      final oldUser = box.getAt(index);
      final updateUser = User(
        id: userID,
        name: newName,
        qrCodes: oldUser!.qrCodes,
      );
      await box.putAt(index, updateUser);
    }
    return box.values.toList();
  }

  @override
  Future<List<User>> deleteUser(User user) async {
    final box = await Hive.openBox<User>(nameuserBox);
    final groupBox = Hive.box<Group>(namegroupBox);
    final userList = box.values.toList();
    final index = userList.indexWhere((u) => u.id == user.id);
    if (index >= 0) {
      await box.deleteAt(index);
      for (int i = 0; i < groupBox.length; i++) {
        final group = groupBox.getAt(i);
        if (group != null) {
          group.listpeople.removeWhere((p) => p.id == user.id);
          await groupBox.putAt(i, group);
        }
      }
      return box.values.toList();
    }
    return [];
  }

  @override
  Future<List<User>> addQrcode(User user, Qrcode qrcode) async {
    final box = await Hive.openBox<User>(nameuserBox);
    final index = box.values.toList().indexWhere((u) => u.id == user.id);
    if (index >= 0) {
      user.qrCodes.add(qrcode);
      await box.putAt(index, user);
      return box.values.toList();
    }
    return [];
  }

  @override
  Future<List<User>> editQrcode(User user, Qrcode qrcode) async {
    final box = await Hive.openBox<User>(nameuserBox);
    final index = box.values.toList().indexWhere((u) => u.id == user.id);
    if (index >= 0) {
      box.values.toList()[index].qrCodes =
          box.values.toList()[index].qrCodes.map((q) {
        return q.id == qrcode.id ? qrcode : q;
      }).toList();
      await box.putAt(index, box.values.toList()[index]);
      return box.values.toList();
    }
    return [];
  }

  @override
  Future<List<User>> deleteQrcode(User user, Qrcode qrcode) async {
    final box = await Hive.openBox<User>(nameuserBox);
    final index = box.values.toList().indexWhere((u) => u.id == user.id);
    if (index >= 0) {
      box.values.toList()[index].qrCodes.removeWhere((q) => q.id == qrcode.id);
    }
    return box.values.toList();
  }
}
