import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/modules/qr/show_qr_list/showqrlist_viewmodel.dart';

class MockUser extends Mock implements User {}

class MockQrcode extends Mock implements Qrcode {}

class MockWidgetRef extends Mock implements WidgetRef {}

class MockUserFriendProvider extends Mock implements UserFriendNotifier {}

void main() {
  late MockUser user;
  late MockQrcode qrCode;
  late MockWidgetRef ref;
  late MockUserFriendProvider userFriendProvider;

  setUp(() {
    user = MockUser();
    qrCode = MockQrcode();
    ref = MockWidgetRef();
    userFriendProvider = MockUserFriendProvider();
  });

  group('ShowQrListViewModel Test', () {
    test('deleteQrCode', () {
      when(() => ref.read(User.userFriendProvider.notifier))
          .thenReturn(userFriendProvider);
      ShowQrListViewModel.deleteQrCode(user: user, qrCode: qrCode, ref: ref);

      verify(() => userFriendProvider.deleteQrcode(user, qrCode));
    });
  });
}
