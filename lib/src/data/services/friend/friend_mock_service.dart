import 'package:qr_group/src/data/models/user.dart';
import 'package:qr_group/src/data/services/friend/friend_service_interface.dart';

class FriendMockService implements FriendServiceInterface {
  List<User> mockUser = [
    User(
      name: 'John Doe',
      qrCodes: [
        Qrcode(
          name: 'John Doe',
          imagePath: 'assets/images/john_doe.png',
        ),
        Qrcode(
          name: 'John Doe',
          imagePath: 'assets/images/john_doe.png',
        ),
      ],
    ),
    User(
      name: 'Jane Doe',
      qrCodes: [
        Qrcode(
          name: 'Jane Doe',
          imagePath: 'assets/images/jane_doe.png',
        ),
        Qrcode(
          name: 'Jane Doe',
          imagePath: 'assets/images/jane_doe.png',
        ),
      ],
    ),
    User(
      name: 'Jane Doe',
      qrCodes: [
        Qrcode(
          name: 'Jane Doe',
          imagePath: 'assets/images/jane_doe.png',
        ),
        Qrcode(
          name: 'Jane Doe',
          imagePath: 'assets/images/jane_doe.png',
        ),
      ],
    ),
    User(
      name: 'Jane Doe',
      qrCodes: [
        Qrcode(
          name: 'Jane Doe',
          imagePath: 'assets/images/jane_doe.png',
        ),
        Qrcode(
          name: 'Jane Doe',
          imagePath: 'assets/images/jane_doe.png',
        ),
      ],
    ),
    User(
      name: 'Jane Doe',
      qrCodes: [
        Qrcode(
          name: 'Jane Doe',
          imagePath: 'assets/images/jane_doe.png',
        ),
        Qrcode(
          name: 'Jane Doe',
          imagePath: 'assets/images/jane_doe.png',
        ),
      ],
    ),
    User(
      name: 'Jane Doe',
      qrCodes: [],
    ),
    User(
      name: 'Jane Doe',
      qrCodes: [],
    ),
  ];

  @override
  Future<List<User>> addQrcode(User user, Qrcode qrcode) async {
    return mockUser;
  }

  @override
  Future<List<User>> addUser(String name) async {
    return mockUser;
  }

  @override
  Future<List<User>> deleteQrcode(User user, Qrcode qrcode) async {
    return mockUser;
  }

  @override
  Future<List<User>> deleteUser(User user) async {
    return mockUser;
  }

  @override
  Future<List<User>> editQrcode(User user, Qrcode qrcode) async {
    return mockUser;
  }

  @override
  Future<List<User>> editUser(String userID, String newName) async {
    return mockUser;
  }

  @override
  Future<List<User>> loadUser() async {
    return mockUser;
  }
}
