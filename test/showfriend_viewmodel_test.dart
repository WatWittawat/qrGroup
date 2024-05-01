import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/modules/friends/show_friend/showfriend_viewmodel.dart';

class MockWidgetRef extends Mock implements WidgetRef {}

class MockUserNotifier extends Mock implements UserFriendNotifier {}

void main() {
  group("ShowFriend ViewModel Tests", () {
    late MockWidgetRef mockRef;
    late MockUserNotifier mockUserNotifier;

    setUp(() {
      mockRef = MockWidgetRef();
      mockUserNotifier = MockUserNotifier();
      final sampleUsers = [
        User(id: "1", name: "User One"),
        User(id: "2", name: "User Two"),
      ];

      final sampleGroups = [
        Group(
            id: '101',
            name: "Test01",
            listpeople: [User(id: '1', name: 'User One')]),
        Group(
          id: '102',
          name: "Test02",
          listpeople: [],
        ),
      ];

      when(() => mockRef.watch(User.userFriendProvider))
          .thenReturn(sampleUsers);
      when(() => mockRef.watch(Group.groupProvider)).thenReturn(sampleGroups);
      when(() => mockRef.read(User.userFriendProvider.notifier))
          .thenReturn(mockUserNotifier);
    });

    test('getMatchingUsers returns correct users for group', () {
      final viewModel = ShowFriendViewModel();
      final matchingUsers = viewModel.getMatchingUsers(
        ref: mockRef,
        isGroup: true,
        groupId: '101',
      );

      expect(matchingUsers.length, 1);
      expect(matchingUsers[0].id, "1");
    });

    test('getMatchingUsers returns all users for non-group', () {
      final viewModel = ShowFriendViewModel();
      final matchingUsers = viewModel.getMatchingUsers(
        ref: mockRef,
        isGroup: false,
      );
      expect(matchingUsers.length, 2);
      expect(matchingUsers[0].id, '1');
      expect(matchingUsers[1].id, '2');
    });

    test('onSaveEditName', () {
      final newUser = User(id: '1', name: 'User one');

      ShowFriendViewModel.onSaveEditName(
        ref: mockRef,
        newName: 'New Name',
        user: newUser,
      );

      verify(() => mockUserNotifier.editUser('1', 'New Name')).called(1);
    });

    test('onDeleteUser deletes user correctly', () {
      final userToDelete = User(id: '1', name: 'User One');

      ShowFriendViewModel.onDeleteUser(
        ref: mockRef,
        user: userToDelete,
      );

      verify(() => mockUserNotifier.deleteUser(userToDelete)).called(1);
    });
  });
}
