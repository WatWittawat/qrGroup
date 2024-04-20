import 'package:flutter/material.dart';
import 'package:qr_group/screens/friend.dart';
import 'package:qr_group/widgets/main_drawer.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
      ),
      body: Center(
        child: Text(
          "Groups",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
