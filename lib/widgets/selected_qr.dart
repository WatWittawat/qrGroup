import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectedQr extends StatefulWidget {
  final File? oldImage;
  final bool isEdit;
  const SelectedQr(
      {super.key,
      required this.onPickImage,
      this.oldImage,
      this.isEdit = false});
  final void Function(File image) onPickImage;
  @override
  State<SelectedQr> createState() {
    return _SelectedQrState();
  }
}

class _SelectedQrState extends State<SelectedQr> {
  File? _image;
  late ImagePicker _picker;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 400,
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
                  scale: 1.0,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.isEdit
                ? const SizedBox()
                : TextButton.icon(
                    onPressed: _chooseImage,
                    icon: const Icon(Icons.photo_outlined),
                    label: const Text("Open Gallery"),
                  ),
            widget.isEdit
                ? const SizedBox()
                : TextButton.icon(
                    onPressed: _takePhoto,
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text("Open camera"),
                  ),
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    _image = widget.oldImage;
  }

  void _chooseImage() async {
    XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        _image = File(selectedImage.path);
      });
    }
    widget.onPickImage(_image!);
  }

  void _takePhoto() async {
    XFile? selectedImage = await _picker.pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      setState(() {
        _image = File(selectedImage.path);
      });
    }
    widget.onPickImage(_image!);
  }
}
