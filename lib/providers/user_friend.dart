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

  void addQrcode(People userId, Qrcode qrcode) {
    state = state.map((user) {
      if (user.id == userId.id) {
        user.qrCodes!.add(qrcode);
      }
      return user;
    }).toList();
  }

  void deleteQrcode(People userId, Qrcode qrcode) {
    state = state.map((user) {
      if (user.id == userId.id) {
        user.qrCodes!.removeWhere((element) => element.id == qrcode.id);
      }
      return user;
    }).toList();
  }

  void editQrcode(People userId, Qrcode qrcode) {
    state = state.map((user) {
      if (user.id == userId.id) {
        user.qrCodes = user.qrCodes!.map((element) {
          if (element.id == qrcode.id) {
            return qrcode;
          } else {
            return element;
          }
        }).toList();
      }
      return user;
    }).toList();
  }
}

final userFriendProvider =
    StateNotifierProvider<UserFriendNotifier, List<People>>(
  (ref) => UserFriendNotifier(),
);
