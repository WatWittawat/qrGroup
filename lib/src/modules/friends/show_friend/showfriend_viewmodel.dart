import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/data/models/user.dart';

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

  static void onSaveEditName({
    required WidgetRef ref,
    required String newName,
    required User user,
  }) {
    ref.read(User.userFriendProvider.notifier).editUser(
          user.id,
          newName,
        );
  }

  static void onDeleteUser({
    required WidgetRef ref,
    required User user,
  }) {
    ref.read(User.userFriendProvider.notifier).deleteUser(user);
  }
}
