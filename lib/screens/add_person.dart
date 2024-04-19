import 'package:flutter/material.dart';
import 'package:qr_group/widgets/selected_qr.dart';

class AddPerson extends StatelessWidget {
  const AddPerson({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Person'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_as_outlined),
            iconSize: 30,
            onPressed: () {},
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // add box to add image
            SelectedQr(),
          ],
        ),
      ),
    );
  }
}
