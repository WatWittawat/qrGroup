import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/data/models/group.dart';

class ShowGroupViewModel {
  static void onSaveEditName({
    required Group group,
    required String newName,
    required WidgetRef ref,
  }) {
    ref.read(Group.groupProvider.notifier).editNameGroup(
          group.id,
          newName,
        );
  }

  static void onDeleteGroup({
    required Group group,
    required WidgetRef ref,
  }) {
    ref.read(Group.groupProvider.notifier).deleteGroup(group.id);
  }
}
