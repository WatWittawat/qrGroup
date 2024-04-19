import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/providers/user_friend.dart';
import 'package:qr_group/screens/add_person.dart';
import 'package:qr_group/widgets/alone_list.dart';

class AloneScreen extends ConsumerStatefulWidget {
  const AloneScreen({super.key});
  @override
  ConsumerState<AloneScreen> createState() {
    return _AloneScreenState();
  }
}

class _AloneScreenState extends ConsumerState<AloneScreen> {
  @override
  Widget build(BuildContext context) {
    final userList = ref.watch(userFriendProvider);
    // for (final user in userList) {
    //   print(user.name);
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alone'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline_outlined,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddPerson()),
              );
            },
          ),
        ],
      ),
      body: userList.isEmpty
          ? Center(
              child: Text(
              "No people. Pls add.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ))
          : Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: AloneList(
                people: userList,
              ),
            ),
    );
  }
}
