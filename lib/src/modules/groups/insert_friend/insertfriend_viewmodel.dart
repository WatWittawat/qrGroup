import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/data/models/user.dart';

class InsertFriendViewModel {
  static void markPeopleAsSelected({
    required Map<String, bool> selectedStatus,
    required Group groupedit,
  }) {
    if (groupedit.listpeople.isNotEmpty) {
      for (var person in groupedit.listpeople) {
        selectedStatus[person.id] = true;
      }
    }
  }

  static void saveGroup({
    required WidgetRef ref,
    required Map<String, bool> selectedStatus,
    required BuildContext context,
    required Group groupedit,
  }) {
    final groupNotifier = ref.read(Group.groupProvider.notifier);
    final listfriend = ref.watch(User.userFriendProvider);
    final selectedPeople = listfriend
        .where((person) => selectedStatus[person.id] ?? false)
        .map((person) => person)
        .toList();
    groupNotifier.addUserInGroup(
      groupedit.id,
      selectedPeople,
    );
    Navigator.of(context).pop();
  }
}
