import 'package:ceniflix/app/app.dart';
import 'package:ceniflix/core/services/hive/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final hiveService = HiveService();
  await hiveService.init();
  await hiveService.openBoxes(); 

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
