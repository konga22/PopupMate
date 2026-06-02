import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';
import 'firebase_options.dart';

const _naverMapClientId = String.fromEnvironment('NAVER_MAP_CLIENT_ID');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeFirebase();

  debugPrint('Naver Map Client ID: $_naverMapClientId');
  if (_naverMapClientId.isNotEmpty) {
    await FlutterNaverMap().init(clientId: _naverMapClientId);
  } else {
    debugPrint('Warning: Naver Map Client ID is empty. Map initialization skipped.');
  }

  runApp(const AppRoot());
}

Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on UnsupportedError catch (error) {
    debugPrint('Firebase 초기화 생략: $error');
  } catch (error) {
    debugPrint('Firebase 초기화 실패: $error');
  }
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
