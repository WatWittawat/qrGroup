import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/providers/group.dart';

class AddGroupScreen extends ConsumerStatefulWidget {
  const AddGroupScreen({super.key});
  @override
  ConsumerState<AddGroupScreen> createState() {
    return _AddGroupState();
  }
}

class _AddGroupState extends ConsumerState<AddGroupScreen> {
  final nameGroup = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Group"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            iconSize: 30,
            onPressed: _addGroup,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: nameGroup,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              maxLength: 19,
              decoration: const InputDecoration(
                labelText: "Group Name",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameGroup.dispose();
    super.dispose();
  }

  void _addGroup() {
    if (nameGroup.text.isEmpty) {
      return;
    }
    ref.read(groupProvider.notifier).addGroup(nameGroup.text);
    Navigator.of(context).pop();
  }
}
