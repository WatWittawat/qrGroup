import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/models/people.dart';

class UserFriendNotifier extends StateNotifier<List<People>> {
  UserFriendNotifier() : super([]);

  void addUser(People user) {
    state = [...state, user];
  }

  void editUser(People updateuser) {
    state = state
        .map((user) => user.id == updateuser.id ? updateuser : user)
        .toList();
  }

  void deleteUser(People user) {
    state = state.where((element) => element.id != user.id).toList();
  }
}

final userFriendProvider =
    StateNotifierProvider<UserFriendNotifier, List<People>>(
  (ref) => UserFriendNotifier(),
);
