import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/data/models/group.dart';

class EditNameDialog<T> extends StatelessWidget {
  final WidgetRef ref;
  final T item;
  final String title;
  final String labelText;
  final void Function(WidgetRef ref, T item, String newName) onSave;

  const EditNameDialog({
    super.key,
    required this.ref,
    required this.item,
    required this.title,
    required this.labelText,
    required this.onSave,
  });

  void _showDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController(
        text: item is User ? (item as User).name : (item as Group).name);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: labelText,
            ),
            maxLength: 19,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newName = nameController.text;
                if (newName.isEmpty) {
                  return;
                }
                onSave(ref, item, newName);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () => _showDialog(context),
    );
  }
}
