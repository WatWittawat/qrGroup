import 'package:flutter/material.dart';
import 'package:qr_group/models/people.dart';
import 'package:qr_group/screens/add_person.dart';
import 'package:qr_group/screens/qr.dart';

class AloneList extends StatefulWidget {
  final List<People> people;
  const AloneList({super.key, required this.people});

  @override
  State<AloneList> createState() => _AloneListState();
}

class _AloneListState extends State<AloneList> {
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
                          setState(() {
                            widget.people.removeAt(index);
                          });
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
