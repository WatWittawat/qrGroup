import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/modules/groups/add_group/addgroup_viewmodel.dart';

class MockWidgetRef extends Mock implements WidgetRef {}

class MockTextEditingController extends Mock implements TextEditingController {}

class MockGroupNotifier extends Mock implements GroupNotifier {}

void main() {
  late MockWidgetRef mockRef;
  late MockTextEditingController mockNameController;
  late MockGroupNotifier mockGroupNotifier;

  setUp(() {
    mockRef = MockWidgetRef();
    mockNameController = MockTextEditingController();
    mockGroupNotifier = MockGroupNotifier();

    when(() => mockRef.read(Group.groupProvider.notifier))
        .thenReturn(mockGroupNotifier);
    when(() => mockNameController.text).thenReturn('');
    when(() => mockGroupNotifier.addGroup(any()))
        .thenAnswer((_) => Future.value());
  });

  group("AddGroupViewModel Test", () {
    test('addGroup not success when nameGroup is empty', () {
      AddGroupViewModel.addGroup(nameGroup: mockNameController, ref: mockRef);
      verifyNever(() => mockGroupNotifier.addGroup(any()));
    });

    test('addGroup success when nameGroup is not empty', () {
      when(() => mockNameController.text).thenReturn("newname");
      AddGroupViewModel.addGroup(nameGroup: mockNameController, ref: mockRef);
      verify(() => mockGroupNotifier.addGroup("newname")).called(1);
    });
  });
}
