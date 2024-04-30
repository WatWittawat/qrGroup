import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/data/models/group.dart';

class AddGroupViewModel {
  static void addGroup({
    required TextEditingController nameGroup,
    required WidgetRef ref,
  }) {
    if (nameGroup.text.isEmpty) {
      return;
    }
    ref.read(Group.groupProvider.notifier).addGroup(nameGroup.text);
  }
}
