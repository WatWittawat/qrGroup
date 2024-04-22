import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:qr_group/models/people.dart';

class UserFriendNotifier extends StateNotifier<List<People>> {
  UserFriendNotifier() : super([]) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    state = Hive.box<People>('people').values.toList();
  }

  final Box<People> people = Hive.box<People>('people');

  void addUser(String name) async {
    final box = await Hive.openBox<People>('people');
    final user = People(name: name);
    box.add(user);
    state = [...state, user];
  }

  void editUser(String userID, String newName) async {
    final box = await Hive.openBox<People>('people');
    final index = box.values.toList().indexWhere((user) => user.id == userID);
    if (index >= 0) {
      final oldUser = box.getAt(index);
      final updateUser = People(
        id: userID,
        name: newName,
        qrCodes: oldUser!.qrCodes,
      );
      await box.putAt(index, updateUser);
    }
    state = box.values.toList();
  }

  void deleteUser(People user) async {
    final box = await Hive.openBox<People>('people');
    final groupBox = Hive.box<Group>('group');
    final index = state.indexWhere((u) => u.id == user.id);
    if (index >= 0) {
      await box.deleteAt(index);
      state = box.values.toList();
      for (int i = 0; i < groupBox.length; i++) {
        final group = groupBox.getAt(i);
        group!.listpeople.removeWhere((p) => p.id == user.id);
      }
    }
  }

  void addQrcode(People user, Qrcode qrcode) async {
    final box = await Hive.openBox<People>('people');
    final index = people.values.toList().indexWhere((u) => u.id == user.id);
    if (index >= 0) {
      user.qrCodes.add(qrcode);
      await box.putAt(index, user);
    }
    state = box.values.toList();
  }

  void deleteQrcode(People user, Qrcode qrcode) async {
    final box = await Hive.openBox<People>('people');
    final index = state.indexWhere((u) => u.id == user.id);
    if (index >= 0) {
      state[index].qrCodes.removeWhere((q) => q.id == qrcode.id);
      await people.putAt(index, state[index]);
      state = box.values.toList();
    }
  }

  void editQrcode(People user, Qrcode qrcode) async {
    final box = await Hive.openBox<People>('people');
    final index = state.indexWhere((u) => u.id == user.id);
    if (index >= 0) {
      state[index].qrCodes = state[index].qrCodes.map((q) {
        return q.id == qrcode.id ? qrcode : q;
      }).toList();
      await people.putAt(index, state[index]);
      state = box.values.toList();
    }
  }
}

final userFriendProvider =
    StateNotifierProvider<UserFriendNotifier, List<People>>(
        (ref) => UserFriendNotifier());
