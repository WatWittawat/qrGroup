import 'package:hive/hive.dart';
import 'package:qr_group/src/common/constants/hive_box_name.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/data/services/group/group_service_interface.dart';

class GroupService implements GroupServiceInterface {
  final String namegroupBox = HiveBoxName.groupBox;

  @override
  Future<List<Group>> loadGroup() async {
    final box = await Hive.openBox<Group>(namegroupBox);
    return box.values.toList();
  }

  @override
  Future<List<Group>> addGroup(String name) async {
    final box = await Hive.openBox<Group>(namegroupBox);
    await box.add(Group(name: name));
    return box.values.toList();
  }

  @override
  Future<List<Group>> addUserInGroup(String groupId, List<User> newList) async {
    final box = await Hive.openBox<Group>(namegroupBox);
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
    }
    return box.values.toList();
  }

  @override
  Future<List<Group>> deleteGroup(String groupId) async {
    final box = await Hive.openBox<Group>(namegroupBox);
    final groupIndex = box.values.toList().indexWhere((n) => n.id == groupId);
    if (groupIndex != -1) {
      await box.deleteAt(groupIndex);
    }
    return box.values.toList();
  }

  @override
  Future<List<Group>> editNameGroup(String groupId, String newName) async {
    final box = await Hive.openBox<Group>(namegroupBox);
    final index =
        box.values.toList().indexWhere((group) => group.id == groupId);
    if (index >= 0) {
      final oldData = box.getAt(index);
      final updatedGroup = Group(
        id: groupId,
        name: newName,
        listpeople: oldData!.listpeople,
      );
      await box.putAt(index, updatedGroup);
    }
    return box.values.toList();
  }
}
