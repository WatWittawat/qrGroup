import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:qr_group/models/people.dart';

class GroupNotifier extends StateNotifier<List<Group>> {
  GroupNotifier() : super([]) {
    _loadGroup();
  }

  Future<void> _loadGroup() async {
    state = Hive.box<Group>('group').values.toList();
  }

  Future<void> addGroup(String name) async {
    final box = await Hive.openBox<Group>('group');
    await box.add(Group(name: name));
    state = box.values.toList();
  }

  Future<void> addUserInGroup(String groupId, List<People> newList) async {
    final box = await Hive.openBox<Group>('group');
    final index =
        box.values.toList().indexWhere((group) => group.id == groupId);
    if (index >= 0) {
      final oldData = box.getAt(index);
      final updatedGroup = Group(
        id: groupId,
        name: oldData!.name,
        listpeople: newList,
      );
      await box.putAt(index, updatedGroup);
      state = box.values.toList();
    }
  }

  Future<void> deleteGroup(String groupId) async {
    final box = await Hive.openBox<Group>('group');
    final groupIndex = box.values.toList().indexWhere((n) => n.id == groupId);
    if (groupIndex != -1) {
      await box.deleteAt(groupIndex);
      state = box.values.toList();
    }
  }

  Future<void> editNameGroup(String groupId, String newName) async {
    final box = await Hive.openBox<Group>('group');
    final index = state.indexWhere((group) => group.id == groupId);
    if (index >= 0) {
      final oldData = box.getAt(index);
      final updatedGroup = Group(
        id: groupId,
        name: newName,
        listpeople: oldData!.listpeople,
      );
      await box.putAt(index, updatedGroup);
      state = box.values.toList();
    }
  }
}

final groupProvider =
    StateNotifierProvider<GroupNotifier, List<Group>>((ref) => GroupNotifier());
