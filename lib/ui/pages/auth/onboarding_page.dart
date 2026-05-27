import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_page.dart';
import 'widgets/onboarding_background.dart';
import 'widgets/onboarding_content.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const OnboardingBackground(),
          OnboardingContent(
            onStart: () => context.goNamed(AppPage.permissions.name),
            onLoginTap: () => context.goNamed(AppPage.login.name),
          ),
        ],
      ),
    );
  }
}
