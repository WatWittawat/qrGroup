import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/models/people.dart';
import 'package:qr_group/providers/user_friend.dart';
import 'package:qr_group/widgets/list_qr.dart';

class FriendsList extends ConsumerStatefulWidget {
  final List<People> userList;
  final bool isGroup;
  const FriendsList({super.key, required this.userList, this.isGroup = false});
  @override
  ConsumerState<FriendsList> createState() => _FriendsList();
}

class _FriendsList extends ConsumerState<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.userList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onPrimary.withOpacity(0.4),
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
                  borderRadius: BorderRadius.circular(20)),
              title: Text(widget.userList[index].name),
              subtitle: Text(
                  "Number of QR codes : ${widget.userList[index].qrCodes.length.toString()}"),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    widget.isGroup
                        ? const SizedBox()
                        : IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _editNameGroup(
                                  context, ref, widget.userList[index]);
                            },
                          ),
                    widget.isGroup
                        ? const SizedBox()
                        : IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _checkDeletedUser(
                                  context, ref, widget.userList[index]);
                            }),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => ListQr(
                        user: widget.userList[index], isGroup: widget.isGroup),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _editNameGroup(BuildContext context, WidgetRef ref, People user) {
    final TextEditingController nameController =
        TextEditingController(text: user.name);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit Friend Name'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'New Friend Name',
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
                ref.read(userFriendProvider.notifier).editUser(
                      user.id,
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

  void _checkDeletedUser(BuildContext context, WidgetRef ref, People user) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Delete Friend'),
          content: const Text('Are you sure you want to delete this friend?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(userFriendProvider.notifier).deleteUser(user);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
