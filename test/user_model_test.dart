import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/data/services/friend/friend_service.dart';

class MockFriendService extends Mock implements FriendService {}

void main() {
  late FriendService friendService;
  setUp(() {
    friendService = MockFriendService();
  });

  group("FriendService Check Call", () {
    test('loadGroup calls FriendService.loadGroup', () async {
      when(() => friendService.loadUser()).thenAnswer((_) async => []);
      await friendService.loadUser();
      verify(() => friendService.loadUser()).called(1);
    });

    test('addUser calls FriendService.addUser', () async {
      when(() => friendService.addUser('NewUser')).thenAnswer((_) async => []);
      await friendService.addUser('NewUser');
      verify(() => friendService.addUser('NewUser')).called(1);
    });

    test('deleteUser calls FriendService.deleteUser', () async {
      final testUser = User(name: "test");
      when(() => friendService.deleteUser(testUser))
          .thenAnswer((_) async => []);
      await friendService.deleteUser(testUser);
      verify(() => friendService.deleteUser(testUser)).called(1);
    });

    test('editUserName calls FriendService.editUser', () async {
      when(() => friendService.editUser('1', 'NewName'))
          .thenAnswer((_) async => []);
      await friendService.editUser('1', 'NewName');
      verify(() => friendService.editUser('1', 'NewName')).called(1);
    });

    test('addQrcode calls FriendService.addQrcode', () async {
      final testUser = User(name: "test");
      final testQrcode = Qrcode(name: "test", imagePath: "test");
      when(() => friendService.addQrcode(
            testUser,
            testQrcode,
          )).thenAnswer((_) async => []);
      await friendService.addQrcode(
        testUser,
        testQrcode,
      );
      verify(() => friendService.addQrcode(
            testUser,
            testQrcode,
          )).called(1);
    });

    test('deleteQrcode calls FriendService.deleteQrcode', () async {
      final testUser = User(name: "test");
      final testQrcode = Qrcode(name: "test", imagePath: "test");
      when(() => friendService.deleteQrcode(
            testUser,
            testQrcode,
          )).thenAnswer((_) async => []);
      await friendService.deleteQrcode(
        testUser,
        testQrcode,
      );
      verify(() => friendService.deleteQrcode(
            testUser,
            testQrcode,
          )).called(1);
    });

    test('editQrcode calls FriendService.editQrcode', () async {
      final testUser = User(name: "test");
      final testQrcode = Qrcode(name: "test", imagePath: "test");
      when(() => friendService.editQrcode(
            testUser,
            testQrcode,
          )).thenAnswer((_) async => []);
      await friendService.editQrcode(
        testUser,
        testQrcode,
      );
      verify(() => friendService.editQrcode(
            testUser,
            testQrcode,
          )).called(1);
    });
  });
}
