import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/common/components/confirm_delete.dart';
import 'package:qr_group/src/common/components/edit_name_dialog.dart';
import 'package:qr_group/src/common/components/main_drawer.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/modules/friends/add_friend/addfriend_view.dart';
import 'package:qr_group/src/modules/friends/show_friend/showfriend_viewmodel.dart';
import 'package:qr_group/src/modules/qr/show_qr_list/showqrlist_view.dart';

class ShowFriendsView extends ConsumerStatefulWidget {
  final bool isGroup;
  final String? groupId;
  const ShowFriendsView({
    super.key,
    this.isGroup = false,
    this.groupId,
  });
  @override
  ConsumerState<ShowFriendsView> createState() {
    return _ShowFriendsViewState();
  }
}

class _ShowFriendsViewState extends ConsumerState<ShowFriendsView> {
  List<User> matchingUsers = [];
  final ShowFriendViewModel viewModel = ShowFriendViewModel();
  @override
  Widget build(BuildContext context) {
    matchingUsers = viewModel.getMatchingUsers(
      ref: ref,
      isGroup: widget.isGroup,
      groupId: widget.groupId,
    );
    return Scaffold(
      drawer: widget.isGroup
          ? null
          : MainDrawer(
              onSelectScreen: (identifier) => ShowFriendViewModel.selectScreen(
                    identifier: identifier,
                    context: context,
                  )),
      appBar: AppBar(
        title: widget.isGroup
            ? const Text("User in Group")
            : const Text('Friends'),
        actions: [
          widget.isGroup
              ? const SizedBox()
              : IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline_outlined,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => const AddFriendView()),
                    );
                  },
                ),
        ],
      ),
      body: matchingUsers.isEmpty
          ? Center(
              child: Text(
              "No friends. Please add.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ))
          : ListView.builder(
              itemCount: matchingUsers.length,
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
                      title: Text(matchingUsers[index].name),
                      subtitle: Text(
                          "Number of QR codes : ${matchingUsers[index].qrCodes.length.toString()}"),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            widget.isGroup
                                ? const SizedBox()
                                : EditNameDialog<User>(
                                    ref: ref,
                                    item: matchingUsers[index],
                                    title: "Edit Friend Name",
                                    labelText: "New Friend Name",
                                    onSave: (ref, user, newName) {
                                      ref
                                          .read(
                                              User.userFriendProvider.notifier)
                                          .editUser(
                                            user.id,
                                            newName,
                                          );
                                    },
                                  ),
                            widget.isGroup
                                ? const SizedBox()
                                : ConfirmDeleteButton(
                                    context: context,
                                    ref: ref,
                                    dialogTitle: "Delete Friend",
                                    dialogContent:
                                        "Are you sure you want to delete this friend?",
                                    onDelete: () {
                                      ref
                                          .read(
                                              User.userFriendProvider.notifier)
                                          .deleteUser(matchingUsers[index]);
                                    }),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => ShowQrList(
                                user: matchingUsers[index],
                                isGroup: widget.isGroup),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
