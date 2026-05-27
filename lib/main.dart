import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';

const _naverMapClientId = String.fromEnvironment('NAVER_MAP_CLIENT_ID');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (_naverMapClientId.isNotEmpty) {
    await FlutterNaverMap().init(clientId: _naverMapClientId);
  }

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
