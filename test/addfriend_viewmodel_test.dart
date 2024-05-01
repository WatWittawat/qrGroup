import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/modules/friends/add_friend/addfriend_viewmodel.dart';

class MockWidgetRef extends Mock implements WidgetRef {}

class MockTextEditingController extends Mock implements TextEditingController {}

class MockUserNotifier extends Mock implements UserFriendNotifier {}

void main() {
  group('AddFriendViewModel Tests', () {
    late MockWidgetRef mockRef;
    late MockTextEditingController mockNameController;
    late MockUserNotifier mockUserNotifier;

    setUp(() {
      mockRef = MockWidgetRef();
      mockNameController = MockTextEditingController();
      mockUserNotifier = MockUserNotifier();
      when(() => mockNameController.text).thenReturn('');
      when(() => mockRef.read(User.userFriendProvider.notifier))
          .thenReturn(mockUserNotifier);
    });

    test('Does not add user if name is empty', () {
      AddFriendViewModel.saveUser(
        ref: mockRef,
        nameController: mockNameController,
      );
      verifyNever(() => mockUserNotifier.addUser(any()));
    });

    test('Adds user if name is not empty', () {
      when(() => mockNameController.text).thenReturn('John Doe');
      AddFriendViewModel.saveUser(
        ref: mockRef,
        nameController: mockNameController,
      );
      verify(() => mockUserNotifier.addUser('John Doe')).called(1);
    });
  });
}
