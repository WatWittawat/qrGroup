import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/models/people.dart';

class UserFriendNotifier extends StateNotifier<List<People>> {
  UserFriendNotifier() : super([]);

  void addUser(People user) {
    state = [...state, user];
  }

  void editUser(People updateuser) {
    // print(updateuser.id);
    // print(updateuser.name);
    state = state
        .map((user) => user.id == updateuser.id ? updateuser : user)
        .toList();
    // for (final user in state) {
    //   print(user.name);
    //   print(user.id);
    // }
  }
}

final userFriendProvider =
    StateNotifierProvider<UserFriendNotifier, List<People>>(
  (ref) => UserFriendNotifier(),
);
