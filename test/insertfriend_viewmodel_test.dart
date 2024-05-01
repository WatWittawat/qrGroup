import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/modules/groups/insert_friend/insertfriend_viewmodel.dart';

class MockWidgetRef extends Mock implements WidgetRef {}

class MockGroupNotifier extends Mock implements GroupNotifier {}

void main() {
  group('InsertFriendViewModel Tests', () {
    late MockWidgetRef mockRef;
    late MockGroupNotifier mockGroupNotifier;
    late List<User> sampleUsers;

    setUp(() {
      mockRef = MockWidgetRef();
      mockGroupNotifier = MockGroupNotifier();

      sampleUsers = [
        User(id: '1', name: 'User One'),
        User(id: '2', name: 'User Two'),
        User(id: '3', name: 'User Three'),
      ];

      when(() => mockRef.read(User.userFriendProvider)).thenReturn(sampleUsers);
      when(() => mockRef.read(Group.groupProvider.notifier))
          .thenReturn(mockGroupNotifier);
      when(() => mockRef.watch(User.userFriendProvider))
          .thenReturn(sampleUsers);
      when(() => mockGroupNotifier.addUserInGroup(any(), any()))
          .thenAnswer((_) async {});
    });

    test('markPeopleAsSelected marks existing group people as selected', () {
      final groupEdit = Group(
          id: '101',
          name: "Test01",
          listpeople: [User(id: '1', name: 'User One')]);
      final selectedStatus = <String, bool>{};

      InsertFriendViewModel.markPeopleAsSelected(
        selectedStatus: selectedStatus,
        groupedit: groupEdit,
      );

      expect(selectedStatus['1'], isTrue);
    });

    test('saveGroup adds selected people to group', () {
      final groupEdit = Group(id: '101', name: "Test01", listpeople: []);

      final selectedStatus = {
        '1': true,
        '2': false,
        '3': true,
      };

      InsertFriendViewModel.saveGroup(
        ref: mockRef,
        selectedStatus: selectedStatus,
        groupedit: groupEdit,
      );

      verify(() => mockGroupNotifier.addUserInGroup(
            '101',
            [sampleUsers[0], sampleUsers[2]],
          )).called(1);
    });
  });
}
