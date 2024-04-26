import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/modules/groups/show_group/showgroup_view.dart';

class ShowFriendViewModel {
  List<User> getMatchingUsers({
    required WidgetRef ref,
    required bool isGroup,
    String? groupId,
  }) {
    List<User> matchingUsers = [];
    if (isGroup) {
      final group = ref.watch(Group.groupProvider).firstWhere(
            (g) => g.id == groupId,
          );
      final groupPeopleIds = group.listpeople.map((p) => p.id).toSet();
      final allUsers = ref.watch(User.userFriendProvider);
      matchingUsers =
          allUsers.where((user) => groupPeopleIds.contains(user.id)).toList();
    } else {
      matchingUsers = ref.watch(User.userFriendProvider);
    }
    return matchingUsers;
  }

  static void selectScreen({
    required String identifier,
    required BuildContext context,
  }) {
    Navigator.of(context).pop();
    if (identifier == 'groups') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const ShowGroupView()),
      );
    }
  }
}
