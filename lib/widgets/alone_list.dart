import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/models/people.dart';
import 'package:qr_group/providers/user_friend.dart';
import 'package:qr_group/screens/add_person.dart';
import 'package:qr_group/screens/qr.dart';

class AloneList extends ConsumerStatefulWidget {
  final List<People> people;
  const AloneList({super.key, required this.people});

  @override
  ConsumerState<AloneList> createState() => _AloneListState();
}

class _AloneListState extends ConsumerState<AloneList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.people.length,
      itemBuilder: ((context, index) => Padding(
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
                title: Text(widget.people[index].name),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => AddPerson(
                                personToEdit: widget.people[index],
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
                              .deleteUser(widget.people[index]);
                        },
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => QrScreen(
                            people: widget.people[index],
                          )));
                },
              ),
            ),
          )),
    );
  }
}
