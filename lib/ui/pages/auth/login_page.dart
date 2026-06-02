import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_page.dart';
import '../../../services/google_auth_service.dart';
import 'widgets/login_background_glow.dart';
import 'widgets/login_design_tokens.dart';
import 'widgets/login_form_content.dart';
import 'widgets/login_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    setState(() => _loading = false);
    context.goNamed(AppPage.home.name);
  }

  Future<void> _onGoogleLogin() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final result = await GoogleAuthService.signIn();
      if (!mounted) return;

      if (result != null) {
        context.goNamed(AppPage.home.name);
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = 'Google 로그인에 실패했습니다.');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  void _onClose() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.goNamed(AppPage.onboarding.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoginColors.background,
      body: Stack(
        children: [
          const LoginBackgroundGlow(),
          SafeArea(
            child: Column(
              children: [
                LoginHeader(onClose: _onClose),
                Expanded(
                  child: LoginFormContent(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    loading: _loading,
                    errorMessage: _errorMessage,
                    onLogin: _onLogin,
                    onGoogleLogin: _onGoogleLogin,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
