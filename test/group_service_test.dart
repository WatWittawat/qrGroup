import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/data/services/group/group_service.dart';

class MockGroupService extends Mock implements GroupService {}

void main() {
  late GroupService groupService;

  setUp(() {
    groupService = MockGroupService();
  });

  group('GroupService Test', () {
    test('loadGroups', () async {
      final mockGroups = [
        Group(name: 'Group 1', id: '1', listpeople: [
          User(name: 'Person 1', id: '1'),
          User(name: 'Person 2', id: '2'),
        ]),
      ];
      when(() => groupService.loadGroup()).thenAnswer(
        (_) async => mockGroups,
      );
      final result = await groupService.loadGroup();
      expect(result, mockGroups);
    });

    test('addGroup', () async {
      final mockGroups = [
        Group(name: 'Group 1', id: '1', listpeople: [
          User(name: 'Person 1', id: '1'),
        ]),
      ];
      const newGroupName = "NewGroup";
      when(() => groupService.addGroup(newGroupName)).thenAnswer((_) async {
        mockGroups.add(Group(name: newGroupName));
        return mockGroups;
      });
      final result = await groupService.addGroup(newGroupName);
      expect(result, mockGroups);
    });

    test('deleteGroup', () async {
      final mockGroups = [
        Group(name: 'Group 1', id: '1', listpeople: [
          User(name: 'Person 1', id: '1'),
          User(name: 'Person 2', id: '2'),
        ]),
      ];
      const groupId = "1";
      when(() => groupService.deleteGroup(groupId)).thenAnswer((_) async {
        mockGroups.removeWhere((element) => element.id == groupId);
        return mockGroups;
      });
      final result = await groupService.deleteGroup(groupId);
      expect(result, mockGroups);
    });

    test('addPersonToGroup', () async {
      final mockGroups = [
        Group(name: 'Group 1', id: '1', listpeople: [
          User(name: 'Person 1', id: '1'),
          User(name: 'Person 2', id: '2'),
        ]),
      ];
      const groupId = "1";
      final newPerson = User(name: 'Person 7', id: '7');
      final listUser = [
        User(name: 'Person 7', id: '7'),
        User(name: 'Person 8', id: '8'),
      ];
      when(() => groupService.addUserInGroup(groupId, listUser))
          .thenAnswer((_) async {
        final group = mockGroups.firstWhere((element) => element.id == groupId);
        group.listpeople.add(newPerson);
        return mockGroups;
      });
      final result = await groupService.addUserInGroup(groupId, listUser);
      expect(result, mockGroups);
    });

    test("editNameGroup", () async {
      final mockGroups = [
        Group(name: 'Group 1', id: '1', listpeople: [
          User(name: 'Person 1', id: '1'),
          User(name: 'Person 2', id: '2'),
        ]),
      ];
      const groupId = "1";
      const newName = "NewName";
      when(() => groupService.editNameGroup(groupId, newName))
          .thenAnswer((_) async {
        final group = mockGroups.firstWhere((element) => element.id == groupId);
        group.name = newName;
        return mockGroups;
      });
      final result = await groupService.editNameGroup(groupId, newName);
      expect(result, mockGroups);
    });
  });
}
