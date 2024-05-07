import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/modules/qr/add_qr/addqr_viewmodel.dart';

class MockUser extends Mock implements User {}

class MockQrcode extends Mock implements Qrcode {}

class MockWidgetRef extends Mock implements WidgetRef {}

class MockTextEditingController extends Mock implements TextEditingController {}

class MockFile extends Mock implements File {}

class MockUserFriendNotifier extends Mock implements UserFriendNotifier {}

void main() {
  late MockUser mockUser;
  late MockWidgetRef mockRef;
  late MockTextEditingController mockNameController;
  late MockFile mockSelectedImage;
  late MockUserFriendNotifier mockUserFriendNotifier;

  setUpAll(() {
    registerFallbackValue(MockUser());
    registerFallbackValue(MockQrcode());
  });

  setUp(() {
    mockUser = MockUser();
    mockRef = MockWidgetRef();
    mockNameController = MockTextEditingController();
    mockSelectedImage = MockFile();
    mockUserFriendNotifier = MockUserFriendNotifier();
  });

  group('AddQrViewModel Test', () {
    test('should call addQrcode when name and image are not null', () {
      when(() => mockNameController.text).thenReturn('test');
      when(() => mockSelectedImage.path).thenReturn('path/to/image');
      when(() => mockRef.read(User.userFriendProvider.notifier))
          .thenReturn(mockUserFriendNotifier);

      AddQrViewModel.saveQrcode(
        nameController: mockNameController,
        selectedImage: mockSelectedImage,
        user: mockUser,
        ref: mockRef,
      );

      verify(() => mockUserFriendNotifier.addQrcode(mockUser, any())).called(1);
    });

    test('should not call addQrcode when name is empty', () {
      when(() => mockNameController.text).thenReturn('');
      when(() => mockRef.read(User.userFriendProvider.notifier))
          .thenReturn(mockUserFriendNotifier);

      AddQrViewModel.saveQrcode(
        nameController: mockNameController,
        selectedImage: mockSelectedImage,
        user: mockUser,
        ref: mockRef,
      );

      verifyNever(() => mockUserFriendNotifier.addQrcode(mockUser, any()));
    });

    test('should not call addQrcode when image is null', () {
      when(() => mockNameController.text).thenReturn('test');
      when(() => mockRef.read(User.userFriendProvider.notifier))
          .thenReturn(mockUserFriendNotifier);

      AddQrViewModel.saveQrcode(
        nameController: mockNameController,
        selectedImage: null,
        user: mockUser,
        ref: mockRef,
      );

      verifyNever(() => mockUserFriendNotifier.addQrcode(mockUser, any()));
    });

    test('editQrcode should call editQrcode when name and image are valid', () {
      final personToEdit = MockQrcode();
      when(() => mockNameController.text).thenReturn('updatedName');
      when(() => mockSelectedImage.path).thenReturn('path/to/new_image');
      when(() => personToEdit.id).thenReturn("123");
      when(() => mockRef.read(User.userFriendProvider.notifier))
          .thenReturn(mockUserFriendNotifier);

      AddQrViewModel.editQrcode(
        nameController: mockNameController,
        selectedImage: mockSelectedImage,
        user: mockUser,
        personToEdit: personToEdit,
        ref: mockRef,
      );

      verify(() => mockUserFriendNotifier.editQrcode(mockUser, any()))
          .called(1);
    });

    test('editQrcode should not call editQrcode if name is empty', () {
      final mockPersonToEdit = MockQrcode();
      when(() => mockNameController.text).thenReturn('');
      when(() => mockPersonToEdit.id).thenReturn("123");
      when(() => mockSelectedImage.path).thenReturn('path/to/new_image');
      when(() => mockRef.read(User.userFriendProvider.notifier))
          .thenReturn(mockUserFriendNotifier);

      AddQrViewModel.editQrcode(
        nameController: mockNameController,
        selectedImage: mockSelectedImage,
        user: mockUser,
        personToEdit: mockPersonToEdit,
        ref: mockRef,
      );

      verifyNever(
          () => mockUserFriendNotifier.editQrcode(mockUser, mockPersonToEdit));
    });

    test('editQrcode should not call editQrcode if selectedImage is null', () {
      final mockPersonToEdit = MockQrcode();
      when(() => mockNameController.text).thenReturn('updatedName');

      when(() => mockRef.read(User.userFriendProvider.notifier))
          .thenReturn(mockUserFriendNotifier);

      AddQrViewModel.editQrcode(
        nameController: mockNameController,
        selectedImage: null,
        user: mockUser,
        personToEdit: mockPersonToEdit,
        ref: mockRef,
      );

      verifyNever(
          () => mockUserFriendNotifier.editQrcode(mockUser, mockPersonToEdit));
    });
  });
}
