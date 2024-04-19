import 'package:flutter/material.dart';
import 'package:qr_group/models/people.dart';
import 'package:qr_group/screens/add_person.dart';
import 'package:qr_group/widgets/alone_list.dart';

class AloneScreen extends StatefulWidget {
  const AloneScreen({super.key});
  @override
  State<AloneScreen> createState() {
    return _AloneScreenState();
  }
}

class _AloneScreenState extends State<AloneScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: AloneList(
        people: dummyAlone,
      ),
    );
  }
}
