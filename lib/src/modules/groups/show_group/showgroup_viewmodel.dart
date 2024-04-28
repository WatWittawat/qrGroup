import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/modules/friends/show_friend/showfriend_view.dart';
import 'package:qr_group/src/modules/groups/add_group/addgroup_view.dart';
import 'package:qr_group/src/modules/groups/insert_friend/insertfriend_view.dart';

class ShowGroupViewModel {
  static void onSelectScreen({
    required WidgetRef ref,
    required String identifier,
    required BuildContext context,
  }) {
    Navigator.of(context).pop();
    if (identifier == 'friends') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const ShowFriendsView()),
      );
    }
  }

  static void navigateToAddGroupView(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddGroupView(),
      ),
    );
  }

  static void navigateToInsertFriendView({
    required BuildContext context,
    required Group group,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => InsertFriendView(
          groupedit: group,
        ),
      ),
    );
  }

  static void onSaveEditName({
    required BuildContext context,
    required Group group,
    required String newName,
    required WidgetRef ref,
  }) {
    ref.read(Group.groupProvider.notifier).editNameGroup(
          group.id,
          newName,
        );
  }

  static void onDeleteGroup({
    required BuildContext context,
    required Group group,
    required WidgetRef ref,
  }) {
    ref.read(Group.groupProvider.notifier).deleteGroup(group.id);
  }

  static void navigateToShowFriendsView({
    required BuildContext context,
    required bool isGroup,
    required String groupId,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ShowFriendsView(
          isGroup: isGroup,
          groupId: groupId,
        ),
      ),
    );
  }
}
