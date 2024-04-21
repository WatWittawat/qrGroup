import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/models/people.dart';
import 'package:qr_group/providers/group.dart';
import 'package:qr_group/providers/user_friend.dart';
import 'package:qr_group/screens/add_friend.dart';
import 'package:qr_group/screens/group.dart';
import 'package:qr_group/widgets/friends_list.dart';
import 'package:qr_group/widgets/main_drawer.dart';

class FriendsScreen extends ConsumerStatefulWidget {
  final bool isGroup;
  final String? groupId;
  const FriendsScreen({super.key, this.isGroup = false, this.groupId});
  @override
  ConsumerState<FriendsScreen> createState() {
    return _FriendsScreenState();
  }
}

class _FriendsScreenState extends ConsumerState<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    List<People> matchingUsers = [];
    if (widget.isGroup) {
      final group = ref.watch(groupProvider).firstWhere(
            (group) => group.id == widget.groupId,
          );

      if (group.people != null) {
        final allUsers = ref.watch(userFriendProvider);
        matchingUsers = allUsers
            .where(
                (user) => group.people!.any((person) => person.id == user.id))
            .toList();
      }
    } else {
      matchingUsers = ref.watch(userFriendProvider);
    }
    return Scaffold(
      drawer: widget.isGroup
          ? null
          : MainDrawer(
              onSelectScreen: _selectScreen,
            ),
      appBar: AppBar(
        title: widget.isGroup
            ? const Text("User in Group")
            : const Text('Friends'),
        actions: [
          widget.isGroup
              ? const SizedBox()
              : IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline_outlined,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const AddFriend()),
                    );
                  },
                ),
        ],
      ),
      body: matchingUsers.isEmpty
          ? Center(
              child: Text(
              "No friends. Please add.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ))
          : FriendsList(userList: matchingUsers, isGroup: widget.isGroup),
    );
  }

  void _selectScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'groups') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const GroupScreen()),
      );
    }
  }
}
