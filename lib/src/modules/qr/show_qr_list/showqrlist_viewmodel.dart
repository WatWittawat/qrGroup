import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/data/models/user.dart';

class ShowQrListViewModel {
  static void deleteQrCode({
    required User user,
    required Qrcode qrCode,
    required WidgetRef ref,
  }) {
    ref.read(User.userFriendProvider.notifier).deleteQrcode(user, qrCode);
  }
}
