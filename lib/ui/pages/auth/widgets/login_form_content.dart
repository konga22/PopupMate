import 'package:flutter/material.dart';

import '../../../../app/assets/app_assets.dart';
import 'login_divider.dart';
import 'login_error_message.dart';
import 'login_intro.dart';
import 'login_links.dart';
import 'login_social_button.dart';
import 'login_submit_button.dart';
import 'login_text_field.dart';

class LoginFormContent extends StatelessWidget {
  const LoginFormContent({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.loading,
    required this.errorMessage,
    required this.onLogin,
    required this.onGoogleLogin,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool loading;
  final String? errorMessage;
  final VoidCallback onLogin;
  final VoidCallback onGoogleLogin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            onPressed: loading ? null : onLogin,
          ),
          const SizedBox(height: 12),
          LoginSocialButton(
            label: 'Google로 로그인',
            backgroundColor: Colors.white,
            textColor: const Color(0xFF3C4043),
            assetIcon: AppAssets.loginGoogle,
            iconSize: 20,
            onPressed: loading ? null : onGoogleLogin,
            borderSide: const BorderSide(color: Color(0xFFDADCE0)),
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 10),
            LoginErrorMessage(message: errorMessage!),
          ],
          const SizedBox(height: 22),
          const LoginDivider(),
          const SizedBox(height: 22),
          LoginTextField(
            label: '이메일 주소',
            hint: 'example@email.com',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 14),
          LoginTextField(
            label: '비밀번호',
            hint: '비밀번호를 입력하세요',
            controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 16),
          LoginSubmitButton(
            loading: loading,
            onPressed: loading ? null : onLogin,
          ),
          const SizedBox(height: 16),
          const LoginLinks(),
        ],
      ),
    );
  }
}
