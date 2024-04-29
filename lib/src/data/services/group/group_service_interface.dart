import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/data/models/user.dart';

abstract class GroupServiceInterface {
  Future<List<Group>> loadGroup();
  Future<List<Group>> addGroup(String name);
  Future<List<Group>> addUserInGroup(String groupId, List<User> newList);
  Future<List<Group>> deleteGroup(String groupId);
  Future<List<Group>> editNameGroup(String groupId, String newName);
}
