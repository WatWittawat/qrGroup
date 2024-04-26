import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/modules/groups/add_group/addgroup_viewmodel.dart';

class AddGroupView extends ConsumerStatefulWidget {
  const AddGroupView({super.key});
  @override
  ConsumerState<AddGroupView> createState() {
    return _AddGroupViewState();
  }
}

class _AddGroupViewState extends ConsumerState<AddGroupView> {
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
            onPressed: () {
              AddGroupViewModel.addGroup(
                context: context,
                nameGroup: nameGroup,
                ref: ref,
              );
            },
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
}
