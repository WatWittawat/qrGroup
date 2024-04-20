import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/providers/user_friend.dart';
import 'package:qr_group/screens/add_friend.dart';
import 'package:qr_group/screens/group.dart';
import 'package:qr_group/widgets/friends_list.dart';
import 'package:qr_group/widgets/main_drawer.dart';

class FriendsScreen extends ConsumerStatefulWidget {
  const FriendsScreen({super.key});
  @override
  ConsumerState<FriendsScreen> createState() {
    return _FriendsScreenState();
  }
}

class _FriendsScreenState extends ConsumerState<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    final userList = ref.watch(userFriendProvider);
    return Scaffold(
      drawer: MainDrawer(
        onSelectScreen: _selectScreen,
      ),
      appBar: AppBar(
        title: const Text('Friends'),
        actions: [
          IconButton(
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
      body: userList.isEmpty
          ? Center(
              child: Text(
              "No friends. Please add.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ))
          : Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: FriendsList(userList: userList),
            ),
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
