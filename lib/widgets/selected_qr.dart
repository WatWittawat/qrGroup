import 'package:flutter/material.dart';

class SelectedQr extends StatefulWidget {
  const SelectedQr({super.key});
  @override
  State<SelectedQr> createState() {
    return _SelectedQrState();
  }
}

class _SelectedQrState extends State<SelectedQr> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 300,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          )),
          child: Text(
            "No chosen QR code",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.photo_outlined),
              label: const Text("Open Gallery"),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text("Open camera"),
            ),
          ],
        )
      ],
    );
  }
}
