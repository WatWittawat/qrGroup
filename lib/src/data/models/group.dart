import 'package:hive/hive.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/data/services/group/group_service.dart';
import 'package:qr_group/src/data/services/group/group_service_interface.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'group.g.dart';

const uuid = Uuid();

@HiveType(typeId: 3)
class Group {
  @HiveField(0)
  final String name;

  @HiveField(1)
  List<User> listpeople;

  @HiveField(2)
  final String id;

  Group({
    required this.name,
    List<User>? listpeople,
    String? id,
  })  : id = id ?? uuid.v4(),
        listpeople = listpeople ?? [];

  static final groupProvider =
      StateNotifierProvider<GroupNotifier, List<Group>>(
          (ref) => GroupNotifier());
}

class GroupNotifier extends StateNotifier<List<Group>> {
  final GroupServiceInterface _groupService = GroupService();

  GroupNotifier() : super([]) {
    _loadGroup();
  }

  Future<void> _loadGroup() async {
    state = await _groupService.loadGroup();
  }

  Future<void> addGroup(String name) async {
    state = await _groupService.addGroup(name);
  }

  Future<void> addUserInGroup(String groupId, List<User> newList) async {
    state = await _groupService.addUserInGroup(groupId, newList);
  }

  Future<void> deleteGroup(String groupId) async {
    state = await _groupService.deleteGroup(groupId);
  }

  Future<void> editNameGroup(String groupId, String newName) async {
    state = await _groupService.editNameGroup(groupId, newName);
  }
}
