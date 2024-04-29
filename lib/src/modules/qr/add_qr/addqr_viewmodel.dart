import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/data/models/user.dart';

class AddQrViewModel {
  static void saveQrcode({
    required BuildContext context,
    required TextEditingController nameController,
    required File? selectedImage,
    required User user,
    required WidgetRef ref,
  }) {
    final name = nameController.text;
    final image = selectedImage;
    if (name.isEmpty || image == null) {
      return;
    }
    final newQr = Qrcode(
      name: name,
      imagePath: image.path,
    );
    ref.read(User.userFriendProvider.notifier).addQrcode(user, newQr);
    Navigator.of(context).pop();
  }

  static void editQrcode({
    required BuildContext context,
    required TextEditingController nameController,
    required File? selectedImage,
    required User user,
    required Qrcode personToEdit,
    required WidgetRef ref,
  }) {
    final name = nameController.text;
    final image = selectedImage;
    if (name.isEmpty || image == null) {
      return;
    }
    final myid = personToEdit.id;
    final newQr = Qrcode(
      id: myid,
      name: name,
      imagePath: image.path,
    );
    ref.read(User.userFriendProvider.notifier).editQrcode(user, newQr);
    Navigator.of(context).pop();
  }
}
