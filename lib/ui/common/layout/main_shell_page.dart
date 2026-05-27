import 'package:flutter/material.dart';

import '../../../app/router/app_tab.dart';
import '../navigation/app_bottom_nav_bar.dart';
import 'app_top_bar.dart';

class MainShellPage extends StatelessWidget {
  const MainShellPage({
    super.key,
    required this.activeTab,
    required this.title,
    required this.child,
    this.actions = const [],
    this.floatingActionButton,
  });

  final AppTab activeTab;
  final String title;
  final Widget child;
  final List<Widget> actions;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: title, actions: actions),
      body: child,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: AppBottomNavBar(activeTab: activeTab),
    );
  }
}
