import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_group/src/common/theme/theme.dart';
import 'package:qr_group/src/modules/friends/show_friend/showfriend_view.dart';
import 'package:qr_group/src/utils/cache/hive_manager.dart';

void main() async {
  await HiveManager.init();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Group',
      theme: theme,
      home: const ShowFriendsView(),
    );
  }
}
