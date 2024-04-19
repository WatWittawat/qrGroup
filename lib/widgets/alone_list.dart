import 'package:flutter/material.dart';
import 'package:qr_group/models/people.dart';

class AloneList extends StatelessWidget {
  final List<People> people;
  const AloneList({super.key, required this.people});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: people.length,
      itemBuilder: ((context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 70,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border:
                      Border.fromBorderSide(BorderSide(color: Colors.grey))),
              child: ListTile(
                title: Text(people[index].name),
                onTap: () {
                  print('Tapped');
                },
              ),
            ),
          )),
    );
  }
}
