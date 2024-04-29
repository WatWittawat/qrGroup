import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/modules/qr/add_qr/addqr_view.dart';
import 'package:qr_group/src/modules/qr/show_qr/showqr_view.dart';

class ShowQrListViewModel {
  static void navigateToAddQr({
    required BuildContext context,
    required User user,
    Qrcode? personToEdit,
  }) {
    if (personToEdit != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AddQrView(user: user, personToEdit: personToEdit),
        ),
      );
      return;
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AddQrView(user: user),
        ),
      );
    }
  }

  static void deleteQrCode({
    required BuildContext context,
    required User user,
    required List<Qrcode> qrCodes,
    required Qrcode qrCode,
    required WidgetRef ref,
  }) {
    ref.read(User.userFriendProvider.notifier).deleteQrcode(user, qrCode);
  }

  static void navigateToShowQrView({
    required BuildContext context,
    required Qrcode qrCodes,
    required int index,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ShowQrView(qrcodeDetails: qrCodes),
      ),
    );
  }
}
