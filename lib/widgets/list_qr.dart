import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/models/people.dart';
import 'package:qr_group/providers/user_friend.dart';
import 'package:qr_group/screens/add_qr.dart';
import 'package:qr_group/screens/qr.dart';

class ListQr extends ConsumerStatefulWidget {
  final People user;
  const ListQr({super.key, required this.user});

  @override
  ConsumerState<ListQr> createState() => _ListQrScreen();
}

class _ListQrScreen extends ConsumerState<ListQr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qr Codes   :   [ ${widget.user.name} ] "),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline_outlined,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => AddQrcode(user: widget.user),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer(builder: (context, watch, child) {
        final qrCodes = ref
            .watch(userFriendProvider)
            .where((user) => user.id == widget.user.id)
            .first
            .qrCodes;
        return qrCodes!.isEmpty
            ? Center(
                child: Text(
                  "No Qr Codes. Please add.",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              )
            : ListView.builder(
                itemCount: qrCodes.length,
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
                              borderRadius: BorderRadius.circular(20)),
                          title: Text(qrCodes[index].name),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (ctx) => AddQrcode(
                                                user: widget.user,
                                                personToEdit: qrCodes[index],
                                              )),
                                    );
                                  },
                                ),
                                IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      ref
                                          .read(userFriendProvider.notifier)
                                          .deleteQrcode(
                                              widget.user, qrCodes[index]);
                                    }),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) =>
                                    QrScreen(qrcodeDetails: qrCodes[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    )),
              );
      }),
    );
  }
}
