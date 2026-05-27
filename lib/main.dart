import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env variables
  await dotenv.load(fileName: ".env");

  // Initialize Naver Map SDK
  await FlutterNaverMap().init(
    clientId: dotenv.env['NAVER_MAP_CLIENT_ID'],
  );

  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PopupMate',
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
