import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/models/people.dart';
import 'package:qr_group/providers/user_friend.dart';
import 'package:qr_group/widgets/selected_qr.dart';

class AddQrcode extends ConsumerStatefulWidget {
  final Qrcode? personToEdit;
  final bool isEdit;
  final People user;
  const AddQrcode(
      {super.key, required this.user, this.personToEdit, this.isEdit = false});
  @override
  ConsumerState<AddQrcode> createState() => _AddQrcode();
}

class _AddQrcode extends ConsumerState<AddQrcode> {
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
          widget.personToEdit != null
              ? "Edit Qr Code : [ ${widget.personToEdit?.name} ]"
              : "Add Qr Code : [ ${widget.user.name} ]",
        ),
        actions: [
          widget.isEdit
              ? const SizedBox()
              : IconButton(
                  icon: const Icon(Icons.save_as_outlined),
                  iconSize: 30,
                  onPressed:
                      widget.personToEdit == null ? _saveQrcode : _editQrcode,
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
                maxLength: 19,
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

  void _saveQrcode() {
    final name = nameController.text;
    final image = _selectedImage;
    if (name.isEmpty || image == null) {
      return;
    }
    final newQr = Qrcode(
      name: name,
      image: image,
    );
    ref.read(userFriendProvider.notifier).addQrcode(widget.user, newQr);
    Navigator.of(context).pop();
  }

  void _editQrcode() {
    final name = nameController.text;
    final image = _selectedImage;
    if (name.isEmpty || image == null) {
      return;
    }
    final myid = widget.personToEdit!.id;
    final newQr = Qrcode(
      id: myid,
      name: name,
      image: image,
    );
    ref.read(userFriendProvider.notifier).editQrcode(widget.user, newQr);
    Navigator.of(context).pop();
  }
}
