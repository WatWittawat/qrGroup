import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/data/models/user.dart';

class AddFriendViewModel {
  static void saveUser({
    required WidgetRef ref,
    required TextEditingController nameController,
  }) {
    final name = nameController.text;
    if (name.isEmpty) {
      return;
    }
    ref.read(User.userFriendProvider.notifier).addUser(name);
  }
}
