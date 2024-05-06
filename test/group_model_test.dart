import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_group/src/data/services/group/group_service.dart';

class MockGroupService extends Mock implements GroupService {}

void main() {
  late GroupService groupService;
  setUp(() {
    groupService = MockGroupService();
  });

  group("GroupService Check Call Test", () {
    test('loadGroup calls GroupService.loadGroup', () async {
      when(() => groupService.loadGroup()).thenAnswer((_) async => []);
      await groupService.loadGroup();
      verify(() => groupService.loadGroup()).called(1);
    });

    test('addGroup calls GroupService.addGroup', () async {
      when(() => groupService.addGroup('NewGroup')).thenAnswer((_) async => []);
      await groupService.addGroup('NewGroup');
      verify(() => groupService.addGroup('NewGroup')).called(1);
    });

    test('addUserInGroup calls GroupService.addUserInGroup', () async {
      when(() => groupService.addUserInGroup('1', []))
          .thenAnswer((_) async => []);
      await groupService.addUserInGroup('1', []);
      verify(() => groupService.addUserInGroup('1', [])).called(1);
    });

    test('deleteGroup calls GroupService.deleteGroup', () async {
      when(() => groupService.deleteGroup('1')).thenAnswer((_) async => []);
      await groupService.deleteGroup('1');
      verify(() => groupService.deleteGroup('1')).called(1);
    });

    test('editNameGroup calls GroupService.editNameGroup', () async {
      when(() => groupService.editNameGroup('1', 'NewName'))
          .thenAnswer((_) async => []);
      await groupService.editNameGroup('1', 'NewName');
      verify(() => groupService.editNameGroup('1', 'NewName')).called(1);
    });
  });
}
