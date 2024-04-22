import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:qr_group/providers/user_friend.dart';

class AddFriend extends ConsumerStatefulWidget {
  const AddFriend({super.key});
  @override
  ConsumerState<AddFriend> createState() => _AddFriedScreenState();
}

class _AddFriedScreenState extends ConsumerState<AddFriend> {
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Friend'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveUser,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
              controller: nameController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              maxLength: 19,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _saveUser() {
    final name = nameController.text;
    if (name.isEmpty) {
      return;
    }
    ref.read(userFriendProvider.notifier).addUser(name);
    Navigator.of(context).pop();
  }
}
