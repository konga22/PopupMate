import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/assets/app_assets.dart';
import '../../../app/router/app_page.dart';
import '../../../services/google_auth_service.dart';
import 'widgets/login_background_glow.dart';
import 'widgets/login_design_tokens.dart';
import 'widgets/login_divider.dart';
import 'widgets/login_header.dart';
import 'widgets/login_intro.dart';
import 'widgets/login_links.dart';
import 'widgets/login_social_button.dart';
import 'widgets/login_submit_button.dart';
import 'widgets/login_text_field.dart';

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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const LoginIntro(),
                        const SizedBox(height: 24),
                        LoginSocialButton(
                          label: '카카오로 시작하기',
                          backgroundColor: const Color(0xFFFEE500),
                          textColor: const Color(0xFF191919),
                          assetIcon: AppAssets.loginKakao,
                          iconSize: 20,
                          onPressed: _loading ? null : _onLogin,
                        ),
                        const SizedBox(height: 12),
                        LoginSocialButton(
                          label: 'Google로 로그인',
                          backgroundColor: Colors.white,
                          textColor: const Color(0xFF3C4043),
                          assetIcon: AppAssets.loginGoogle,
                          iconSize: 20,
                          onPressed: _loading ? null : _onGoogleLogin,
                          borderSide: const BorderSide(
                            color: Color(0xFFDADCE0),
                          ),
                        ),
                        if (_errorMessage != null) ...[
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(
                                color: Color(0xFFB3261E),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 22),
                        const LoginDivider(),
                        const SizedBox(height: 22),
                        LoginTextField(
                          label: '이메일 주소',
                          hint: 'example@email.com',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 14),
                        LoginTextField(
                          label: '비밀번호',
                          hint: '비밀번호를 입력하세요',
                          controller: _passwordController,
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                        LoginSubmitButton(
                          loading: _loading,
                          onPressed: _loading ? null : _onLogin,
                        ),
                        const SizedBox(height: 16),
                        const LoginLinks(),
                      ],
                    ),
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
