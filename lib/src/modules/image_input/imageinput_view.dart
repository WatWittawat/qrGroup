import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_group/src/modules/image_input/imageinput_viewmodel.dart';

class ImageInput extends StatefulWidget {
  final File? oldImage;
  final bool isEdit;
  const ImageInput(
      {super.key,
      required this.onPickImage,
      this.oldImage,
      this.isEdit = false});
  final void Function(File image) onPickImage;
  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _image;
  bool _isPickingImage = false;

  Future<void> _chooseImage(ImageSource source) async {
    if (_isPickingImage) return;
    _isPickingImage = true;
    try {
      _image = await ImageInputViewModel.chooseImage(source);
      if (_image != null) {
        setState(() {});
        widget.onPickImage(_image!);
      }
    } finally {
      _isPickingImage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 465,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          )),
          child: _image == null
              ? Text(
                  "No chosen QR code",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                )
              : Image.file(
                  _image!,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (!widget.isEdit)
              TextButton.icon(
                onPressed: () => _chooseImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_outlined),
                label: const Text("Open Gallery"),
              ),
            if (!widget.isEdit)
              TextButton.icon(
                onPressed: () => _chooseImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text("Open camera"),
              ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _image = widget.oldImage;
  }
}
