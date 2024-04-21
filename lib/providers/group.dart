import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/models/people.dart';

class GroupNotifier extends StateNotifier<List<Group>> {
  GroupNotifier() : super([]);

  void addGroup(Group group) {
    state = [...state, group];
  }

  void togglePersonInGroup(String groupId, List<People> newList) {
    state = state.map((group) {
      if (group.id == groupId) {
        return Group(
          id: group.id,
          name: group.name,
          listpeople: newList,
        );
      } else {
        return group;
      }
    }).toList();
  }

  void deleteGroup(String groupId) {
    state = state.where((group) => group.id != groupId).toList();
  }

  void editNameGroup(String groupId, String newName) {
    state = state.map((group) {
      if (group.id == groupId) {
        return Group(
          id: group.id,
          name: newName,
          listpeople: group.people,
        );
      } else {
        return group;
      }
    }).toList();
  }
}

final groupProvider = StateNotifierProvider<GroupNotifier, List<Group>>(
  (ref) => GroupNotifier(),
);
