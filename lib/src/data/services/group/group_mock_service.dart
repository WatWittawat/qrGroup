import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/data/services/group/group_service_interface.dart';

class GroupMockService implements GroupServiceInterface {
  List<Group> mockGroup = [
    Group(name: "Group 1", listpeople: [
      User(name: "User 1"),
      User(
        name: "User 2",
        qrCodes: [
          Qrcode(
            name: 'User 2',
            imagePath: 'assets/images/jane_doe.png',
          ),
          Qrcode(
            name: 'User 2',
            imagePath: 'assets/images/jane_doe.png',
          ),
        ],
      ),
    ]),
    Group(name: "Group 2", listpeople: [
      User(name: "User 1"),
      User(name: "User 2"),
    ]),
    Group(name: "Group 3", listpeople: [
      User(name: "User 1"),
    ]),
    Group(name: "Group 4", listpeople: [
      User(
        name: "User 1",
        qrCodes: [
          Qrcode(
            name: 'User 1',
            imagePath: 'assets/images/jane_doe.png',
          ),
          Qrcode(
            name: 'User 1',
            imagePath: 'assets/images/jane_doe.png',
          ),
        ],
      ),
      User(name: "User 2"),
    ]),
    Group(name: "Group 5", listpeople: [
      User(name: "User 1"),
    ]),
    Group(name: "Group 6", listpeople: [
      User(name: "User 1"),
      User(name: "User 2"),
    ]),
  ];

  @override
  Future<List<Group>> addGroup(String name) async {
    return mockGroup;
  }

  @override
  Future<List<Group>> addUserInGroup(String groupId, List<User> newList) async {
    return mockGroup;
  }

  @override
  Future<List<Group>> deleteGroup(String groupId) async {
    return mockGroup;
  }

  @override
  Future<List<Group>> editNameGroup(String groupId, String newName) async {
    return mockGroup;
  }

  @override
  Future<List<Group>> loadGroup() async {
    return mockGroup;
  }
}
