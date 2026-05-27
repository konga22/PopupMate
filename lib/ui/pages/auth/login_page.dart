import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../app/assets/app_assets.dart';
import '../../../app/router/app_page.dart';
import '../../../app/theme/app_theme.dart';
import '../../../services/google_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _kakaoBackground = Color(0xFFFEE500);
  static const _kakaoText = Color(0xFF191919);

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
    } catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = 'Google 로그인에 실패했습니다.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isShortScreen = constraints.maxHeight < 700;
          final isMediumScreen = constraints.maxHeight < 860;
          final horizontalPadding = constraints.maxWidth < 360 ? 16.0 : 20.0;
          final headerHeight = isShortScreen ? 56.0 : 64.0;
          final scrollTopPadding = isShortScreen ? 16.0 : 32.0;
          final titleTopGap =
              isShortScreen ? 24.0 : (isMediumScreen ? 40.0 : 64.0);
          final sectionGap =
              isShortScreen ? 28.0 : (isMediumScreen ? 36.0 : 48.0);
          final fieldGap =
              isShortScreen ? 20.0 : (isMediumScreen ? 22.0 : 24.0);
          final bottomPadding = 16.0 + MediaQuery.viewInsetsOf(context).bottom;

          return Stack(
            children: [
              Positioned(
                left: -160,
                bottom: -18,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                  child: Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4C3B8).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(160),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: headerHeight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'PopupMate',
                              style: TextStyle(
                                color: AppColors.ink,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                height: 32 / 24,
                                letterSpacing: 0,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                if (context.canPop()) {
                                  context.pop();
                                  return;
                                }
                                context.goNamed(AppPage.onboarding.name);
                              },
                              icon: SvgPicture.asset(
                                AppAssets.loginClose,
                                width: 16.4,
                                height: 16.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          scrollTopPadding,
                          horizontalPadding,
                          bottomPadding,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 420),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: titleTopGap),
                                const Text(
                                  '반갑습니다!',
                                  style: TextStyle(
                                    color: AppColors.ink,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                    height: 40 / 32,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '로그인하여 당신만의 팝업 큐레이션을 시작해보세요.',
                                  style: TextStyle(
                                    color: AppColors.body,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 24 / 16,
                                  ),
                                ),
                                SizedBox(height: sectionGap),
                                _SocialButton(
                                  label: '카카오로 시작하기',
                                  backgroundColor: _kakaoBackground,
                                  textColor: _kakaoText,
                                  icon: AppAssets.loginKakao,
                                  iconSize: 20,
                                  onPressed: _loading ? null : _onLogin,
                                ),
                                const SizedBox(height: 16),
                                _SocialButton(
                                  label: 'Google로 로그인',
                                  backgroundColor: Colors.white,
                                  textColor: const Color(0xFF3C4043),
                                  icon: AppAssets.loginGoogle,
                                  iconSize: 20,
                                  onPressed: _loading ? null : _onGoogleLogin,
                                  borderSide: const BorderSide(
                                    color: Color(0xFFDADCE0),
                                  ),
                                ),
                                if (_errorMessage != null) ...[
                                  const SizedBox(height: 10),
                                  Text(
                                    _errorMessage!,
                                    style: const TextStyle(
                                      color: Color(0xFFB3261E),
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                                SizedBox(height: sectionGap),
                                const _DividerWithText(),
                                SizedBox(height: sectionGap),
                                _FigmaTextField(
                                  label: '이메일 주소',
                                  hint: 'example@email.com',
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: fieldGap),
                                _FigmaTextField(
                                  label: '비밀번호',
                                  hint: '비밀번호를 입력하세요',
                                  controller: _passwordController,
                                  obscureText: true,
                                ),
                                SizedBox(height: fieldGap),
                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: _loading ? null : _onLogin,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.ink,
                                      foregroundColor: Colors.white,
                                      disabledBackgroundColor: AppColors.ink,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        height: 24 / 16,
                                      ),
                                    ),
                                    child:
                                        _loading
                                            ? const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                            : const Text('로그인'),
                                  ),
                                ),
                                SizedBox(height: sectionGap),
                                const _LoginLinks(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.iconSize,
    required this.onPressed,
    this.borderSide,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final String icon;
  final double iconSize;
  final VoidCallback? onPressed;
  final BorderSide? borderSide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: borderSide != null ? 0 : 1,
          shadowColor: Colors.black.withValues(alpha: 0.05),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderSide ?? BorderSide.none,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 24 / 16,
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: icon.endsWith('.svg')
                    ? SvgPicture.asset(icon, width: iconSize, height: iconSize)
                    : Image.asset(icon, width: iconSize, height: iconSize),
              ),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

class _DividerWithText extends StatelessWidget {
  const _DividerWithText();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.border, height: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 16 / 12,
              letterSpacing: 0.6,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.border, height: 1)),
      ],
    );
  }
}

class _FigmaTextField extends StatelessWidget {
  const _FigmaTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 16 / 12,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 56,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            cursorColor: AppColors.ink,
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 24 / 16,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColors.border,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 24 / 16,
              ),
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.ink),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginLinks extends StatelessWidget {
  const _LoginLinks();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _FooterLink(label: '비밀번호 찾기', onTap: () {}),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: 4,
            height: 4,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.border,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        _FooterLink(label: '회원가입', onTap: () {}),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.body,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 20 / 14,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
