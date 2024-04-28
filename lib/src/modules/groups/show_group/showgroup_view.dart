import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/common/components/confirm_delete.dart';
import 'package:qr_group/src/common/components/edit_name_dialog.dart';
import 'package:qr_group/src/common/components/main_drawer.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/modules/groups/show_group/showgroup_viewmodel.dart';

class ShowGroupView extends ConsumerStatefulWidget {
  const ShowGroupView({
    super.key,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ShowGroupViewState();
  }
}

class _ShowGroupViewState extends ConsumerState<ShowGroupView> {
  @override
  Widget build(BuildContext context) {
    final groupList = ref.watch(Group.groupProvider);

    return Scaffold(
      drawer: MainDrawer(
        onSelectScreen: (String identifier) {
          ShowGroupViewModel.onSelectScreen(
              ref: ref, identifier: identifier, context: context);
        },
      ),
      appBar: AppBar(
        title: const Text("Groups"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            iconSize: 30,
            onPressed: () {
              ShowGroupViewModel.navigateToAddGroupView(context);
            },
          ),
        ],
      ),
      body: groupList.isEmpty
          ? Center(
              child: Text(
                "No groups yet! Please add a group.",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            )
          : ListView.builder(
              itemCount: groupList.length,
              itemBuilder: (context, index) {
                final group = groupList[index];
                final groupName = group.name;
                final peopleCount = group.listpeople.length;
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.onPrimary,
                          Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.4),
                        ],
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      border: const Border.fromBorderSide(
                        BorderSide(color: Colors.black12),
                      ),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text(groupName),
                      subtitle: Text("Number of friends: $peopleCount"),
                      trailing: SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.person_rounded),
                              onPressed: () {
                                ShowGroupViewModel.navigateToInsertFriendView(
                                  context: context,
                                  group: group,
                                );
                              },
                            ),
                            EditNameDialog<Group>(
                              ref: ref,
                              item: group,
                              title: "Edit Group Name",
                              labelText: "New Group Name",
                              onSave: (ref, group, newName) {
                                ShowGroupViewModel.onSaveEditName(
                                  context: context,
                                  group: group,
                                  newName: newName,
                                  ref: ref,
                                );
                              },
                            ),
                            ConfirmDeleteButton(
                              context: context,
                              ref: ref,
                              dialogTitle: "Delete Group",
                              dialogContent:
                                  "Are you sure you want to delete this Group?",
                              onDelete: () {
                                ShowGroupViewModel.onDeleteGroup(
                                  context: context,
                                  group: group,
                                  ref: ref,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        ShowGroupViewModel.navigateToShowFriendsView(
                          context: context,
                          isGroup: true,
                          groupId: group.id,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
