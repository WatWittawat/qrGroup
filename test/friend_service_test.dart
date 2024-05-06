import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/data/services/friend/friend_service.dart';

class MockFriendService extends Mock implements FriendService {}

void main() {
  late FriendService friendService;
  setUp(
    () => friendService = MockFriendService(),
  );

  group("FreiendService Test", () {
    test(
      'loadFriend',
      () async {
        final mockFriends = [
          User(name: 'Friend 1', id: '1'),
        ];
        when(
          () => friendService.loadUser(),
        ).thenAnswer(
          (_) async => mockFriends,
        );
        final result = await friendService.loadUser();
        expect(
          result,
          mockFriends,
        );
      },
    );

    test('addFriend', () async {
      final mockFriends = [
        User(name: 'Friend 1', id: '1'),
      ];
      const newFriendName = "NewFriend";
      when(
        () => friendService.addUser(newFriendName),
      ).thenAnswer((_) async {
        mockFriends.add(User(name: newFriendName));
        return mockFriends;
      });
      final result = await friendService.addUser(newFriendName);
      expect(
        result,
        mockFriends,
      );
    });

    test('deleteFriend', () async {
      final mockFriends = [
        User(name: 'Friend 1', id: '1'),
      ];
      final friendUser = User(name: 'Friend 1', id: '1');
      when(
        () => friendService.deleteUser(friendUser),
      ).thenAnswer((_) async {
        mockFriends.removeWhere((element) => element.id == friendUser.id);
        return mockFriends;
      });
      final result = await friendService.deleteUser(friendUser);
      expect(
        result,
        mockFriends,
      );
    });

    test('addQr', () async {
      final mockFriends = [
        User(name: 'Friend 1', id: '1'),
      ];
      final friendUser = User(name: 'Friend 1', id: '1');
      final qrcode = Qrcode(name: 'qrcode', imagePath: 'imagePath');
      when(
        () => friendService.addQrcode(friendUser, qrcode),
      ).thenAnswer((_) async {
        final index = mockFriends.indexWhere((u) => u.id == friendUser.id);
        if (index >= 0) {
          friendUser.qrCodes.add(qrcode);
          mockFriends[index] = friendUser;
        }
        return mockFriends;
      });
      final result = await friendService.addQrcode(friendUser, qrcode);
      expect(
        result,
        mockFriends,
      );
    });

    test("editQr", () async {
      final mockFriends = [
        User(name: 'Friend 1', id: '1', qrCodes: [
          Qrcode(name: 'qrcode', imagePath: 'imagePath'),
        ]),
      ];
      final friendUser = User(name: 'Friend 1', id: '1');
      final qrcode = Qrcode(name: 'qrcode', imagePath: 'imagePath');
      when(
        () => friendService.editQrcode(friendUser, qrcode),
      ).thenAnswer((_) async {
        final index = mockFriends.indexWhere((u) => u.id == friendUser.id);
        if (index >= 0) {
          final indexQr =
              friendUser.qrCodes.indexWhere((q) => q.id == qrcode.id);
          if (indexQr >= 0) {
            friendUser.qrCodes[indexQr] = qrcode;
            mockFriends[index] = friendUser;
          }
        }
        return mockFriends;
      });
      final result = await friendService.editQrcode(friendUser, qrcode);
      expect(
        result,
        mockFriends,
      );
    });

    test("deleteQr", () async {
      final mockFriends = [
        User(name: 'Friend 1', id: '1', qrCodes: [
          Qrcode(name: 'qrcode', imagePath: 'imagePath'),
        ]),
      ];
      final friendUser = User(name: 'Friend 1', id: '1');
      final qrcode = Qrcode(name: 'qrcode', imagePath: 'imagePath');
      when(
        () => friendService.deleteQrcode(friendUser, qrcode),
      ).thenAnswer((_) async {
        final index = mockFriends.indexWhere((u) => u.id == friendUser.id);
        if (index >= 0) {
          friendUser.qrCodes.removeWhere((q) => q.id == qrcode.id);
          mockFriends[index] = friendUser;
        }
        return mockFriends;
      });
      final result = await friendService.deleteQrcode(friendUser, qrcode);
      expect(
        result,
        mockFriends,
      );
    });
  });
}
