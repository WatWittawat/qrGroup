import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/models/people.dart';
import 'package:qr_group/providers/user_friend.dart';
import 'package:qr_group/widgets/selected_qr.dart';

class AddPerson extends ConsumerStatefulWidget {
  final People? personToEdit;
  const AddPerson({super.key, this.personToEdit});
  @override
  ConsumerState<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends ConsumerState<AddPerson> {
  var nameController = TextEditingController();
  File? _selectedImage;
  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.personToEdit?.name ?? '');
    _selectedImage = widget.personToEdit?.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.personToEdit != null ? 'Edit Person' : 'Add Person',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_as_outlined),
            iconSize: 30,
            onPressed: widget.personToEdit == null ? _saveUser : _editUser,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // add box to add image
              SelectedQr(
                  onPickImage: (image) {
                    _selectedImage = image;
                  },
                  oldImage: _selectedImage),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _saveUser() {
    final name = nameController.text.trim();
    if (name.isEmpty || _selectedImage == null) {
      return;
    }
    final user = People(name: name, image: _selectedImage!);
    ref.read(userFriendProvider.notifier).addUser(user);
    Navigator.of(context).pop();
  }

  void _editUser() {
    final name = nameController.text.trim();
    if (name.isEmpty || _selectedImage == null) {
      return;
    }
    final user = People(
      id: widget.personToEdit!.id,
      name: name,
      image: _selectedImage!,
    );
    ref.read(userFriendProvider.notifier).editUser(user);
    Navigator.of(context).pop();
  }
}
