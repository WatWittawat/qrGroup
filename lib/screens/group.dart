import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/providers/user_friend.dart';
import 'package:qr_group/screens/add_group.dart';
import 'package:qr_group/screens/friend.dart';
import 'package:qr_group/widgets/group_list.dart';
import 'package:qr_group/widgets/main_drawer.dart';

class GroupScreen extends ConsumerStatefulWidget {
  const GroupScreen({
    super.key,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _GroupScreenState();
  }
}

class _GroupScreenState extends ConsumerState<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    ref.watch(userFriendProvider);
    return Scaffold(
      drawer: MainDrawer(
        onSelectScreen: (String identifier) {
          Navigator.of(context).pop();
          if (identifier == 'friends') {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const FriendsScreen()));
          }
        },
      ),
      appBar: AppBar(
        title: const Text("Groups"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            iconSize: 30,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddGroupScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: const ListGroup(),
    );
  }
}
