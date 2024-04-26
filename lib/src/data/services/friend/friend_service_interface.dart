import 'package:qr_group/src/data/models/user.dart';

abstract class FriendServiceInterface {
  Future<List<User>> loadUser();
  Future<List<User>> addUser(String name);
  Future<List<User>> editUser(String userID, String newName);
  Future<List<User>> deleteUser(User user);
  Future<List<User>> addQrcode(User user, Qrcode qrcode);
  Future<List<User>> deleteQrcode(User user, Qrcode qrcode);
  Future<List<User>> editQrcode(User user, Qrcode qrcode);
}
