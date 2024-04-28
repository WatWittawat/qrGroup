import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/modules/image_input/imageinput_view.dart';
import 'package:qr_group/src/modules/qr/add_qr/addqr_viewmodel.dart';

class AddQrView extends ConsumerStatefulWidget {
  final Qrcode? personToEdit;
  final bool isEdit;
  final User user;
  const AddQrView(
      {super.key, required this.user, this.personToEdit, this.isEdit = false});
  @override
  ConsumerState<AddQrView> createState() => _AddQrViewState();
}

class _AddQrViewState extends ConsumerState<AddQrView> {
  var nameController = TextEditingController();
  File? _selectedImage;
  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.personToEdit?.name ?? '');
    _selectedImage = widget.personToEdit?.imagePath != null
        ? File(widget.personToEdit!.imagePath)
        : null;
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
                  onPressed: () {
                    widget.personToEdit == null
                        ? AddQrViewModel.saveQrcode(
                            context: context,
                            nameController: nameController,
                            selectedImage: _selectedImage,
                            user: widget.user,
                            ref: ref)
                        : AddQrViewModel.editQrcode(
                            context: context,
                            nameController: nameController,
                            selectedImage: _selectedImage,
                            user: widget.user,
                            personToEdit: widget.personToEdit!,
                            ref: ref);
                  },
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
              ImageInput(
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
}
