import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_group/src/common/constants/hive_box_name.dart';
import 'package:qr_group/src/data/models/group.dart';
import 'package:qr_group/src/data/models/user.dart';

class HiveManager {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(QrcodeAdapter());
    Hive.registerAdapter(GroupAdapter());
    await Hive.openBox<User>(HiveBoxName.userBox);
    await Hive.openBox<Qrcode>(HiveBoxName.qrBox);
    await Hive.openBox<Group>(HiveBoxName.groupBox);
  }
}
