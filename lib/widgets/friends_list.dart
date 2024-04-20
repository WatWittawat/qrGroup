import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/models/people.dart';
import 'package:qr_group/providers/user_friend.dart';
import 'package:qr_group/screens/add_friend.dart';
import 'package:qr_group/widgets/list_qr.dart';

class FriendsList extends ConsumerStatefulWidget {
  final List<People> userList;
  const FriendsList({super.key, required this.userList});
  @override
  ConsumerState<FriendsList> createState() => _FriendsList();
}

class _FriendsList extends ConsumerState<FriendsList> {
  @override
  Widget build(BuildContext context) {
    print(widget.userList[0].qrCodes!.length);
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
                  "Number of QR codes : ${widget.userList[index].qrCodes!.length.toString()}"),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => AddFriend(
                              userToEdit: widget.userList[index],
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref
                            .read(userFriendProvider.notifier)
                            .deleteUser(widget.userList[index]);
                      },
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => ListQr(user: widget.userList[index]),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
