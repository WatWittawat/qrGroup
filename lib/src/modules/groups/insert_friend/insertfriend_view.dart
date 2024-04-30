import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/modules/groups/insert_friend/insertfriend_viewmodel.dart';

class InsertFriendView extends ConsumerStatefulWidget {
  final Group groupedit;
  const InsertFriendView({super.key, required this.groupedit});
  @override
  ConsumerState<InsertFriendView> createState() {
    return _InsertFriendViewState();
  }
}

class _InsertFriendViewState extends ConsumerState<InsertFriendView> {
  final Map<String, bool> selectedStatus = {};
  @override
  void initState() {
    super.initState();
    InsertFriendViewModel.markPeopleAsSelected(
        selectedStatus: selectedStatus, groupedit: widget.groupedit);
  }

  @override
  Widget build(BuildContext context) {
    final listfriend = ref.watch(User.userFriendProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Friend to Group [ ${widget.groupedit.name} ]"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            iconSize: 30,
            onPressed: () {
              InsertFriendViewModel.saveGroup(
                ref: ref,
                selectedStatus: selectedStatus,
                groupedit: widget.groupedit,
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: listfriend.isEmpty
          ? Center(
              child: Text(
                "No friends to add. Please add friends first.",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: listfriend.length,
                itemBuilder: (context, index) {
                  final person = listfriend[index];
                  final isSelected = selectedStatus[person.id] ?? false;

                  return CheckboxListTile(
                    title: Text(person.name),
                    value: isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedStatus[person.id] = value ?? false;
                      });
                    },
                  );
                },
              ),
            ),
    );
  }
}
