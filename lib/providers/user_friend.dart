import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFriendNotifier extends StateNotifier<List<String>> {
  UserFriendNotifier() : super([]);

  void addUser(String name) {
    state = [...state, name];
  }
}

final userFriendProvider =
    StateNotifierProvider<UserFriendNotifier, List<String>>(
  (ref) => UserFriendNotifier(),
);
