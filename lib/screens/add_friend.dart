import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:qr_group/models/people.dart';
import 'package:qr_group/providers/user_friend.dart';

class AddFriend extends ConsumerStatefulWidget {
  final People? userToEdit;
  const AddFriend({super.key, this.userToEdit});
  @override
  ConsumerState<AddFriend> createState() => _AddFriedScreenState();
}

class _AddFriedScreenState extends ConsumerState<AddFriend> {
  var nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userToEdit?.name ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userToEdit != null
            ? "Edit name : [ ${widget.userToEdit?.name} ]"
            : 'Add Friend'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: widget.userToEdit == null ? _saveUser : _editUser,
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
                labelText: 'Name',
              ),
              controller: nameController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
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
    final newUser = People(name: name);
    ref.read(userFriendProvider.notifier).addUser(newUser);
    Navigator.of(context).pop();
  }

  void _editUser() {
    final name = nameController.text;
    if (name.isEmpty) {
      return;
    }
    final oldId = widget.userToEdit?.id;
    final oldQrCodes = widget.userToEdit?.qrCodes;
    final newUser = People(id: oldId, name: name, qrCodes: oldQrCodes);
    ref.read(userFriendProvider.notifier).editUser(newUser);
    Navigator.of(context).pop();
  }
}
