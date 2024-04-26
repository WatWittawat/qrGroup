import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:qr_group/src/modules/friends/add_friend/addfriend_viewmodels.dart';

class AddFriendView extends ConsumerStatefulWidget {
  const AddFriendView({super.key});
  @override
  ConsumerState<AddFriendView> createState() => _AddFriedScreenViewState();
}

class _AddFriedScreenViewState extends ConsumerState<AddFriendView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Friend'),
        actions: [
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                AddFriendViewModel.saveUser(
                  nameController: nameController,
                  context: context,
                  ref: ref,
                );
              }),
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

  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
