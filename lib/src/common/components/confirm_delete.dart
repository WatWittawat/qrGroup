import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmDeleteButton extends StatelessWidget {
  final BuildContext context;
  final WidgetRef ref;
  final String dialogTitle;
  final String dialogContent;
  final VoidCallback onDelete;

  const ConfirmDeleteButton({
    super.key,
    required this.context,
    required this.ref,
    required this.dialogTitle,
    required this.dialogContent,
    required this.onDelete,
  });

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: Text(dialogContent),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete();
                Navigator.of(ctx).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () => _showDialog(context),
    );
  }
}
