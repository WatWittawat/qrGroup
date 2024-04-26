import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/common/components/main_drawer.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/modules/friends/show_friend/showfriend_view.dart';
import 'package:qr_group/src/modules/groups/add_group/addgroup_view.dart';
import 'package:qr_group/src/modules/groups/insert_friend/insertfriend_view.dart';

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
    ref.watch(User.userFriendProvider);
    final groupList = ref.watch(Group.groupProvider);

    return Scaffold(
      drawer: MainDrawer(
        onSelectScreen: (String identifier) {
          Navigator.of(context).pop();
          if (identifier == 'friends') {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const ShowFriendsView()));
          }
        },
      ),
      appBar: AppBar(
        title: const Text("Groups"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            iconSize: 30,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddGroupView(),
                ),
              );
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) =>
                                        InsertFriendView(groupedit: group),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editNameGroup(context, ref, group);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _checkDeletedGroup(context, ref, group.id);
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => ShowFriendsView(
                              isGroup: true,
                              groupId: group.id,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _checkDeletedGroup(BuildContext context, WidgetRef ref, String groupId) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Delete Group'),
          content: const Text('Are you sure you want to delete this group?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(Group.groupProvider.notifier).deleteGroup(groupId);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _editNameGroup(BuildContext context, WidgetRef ref, Group group) {
    final TextEditingController nameController =
        TextEditingController(text: group.name);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit Group Name'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'New Group Name',
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
                ref.read(Group.groupProvider.notifier).editNameGroup(
                      group.id,
                      newName,
                    );
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
