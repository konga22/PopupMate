import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginSocialButton extends StatelessWidget {
  const LoginSocialButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.iconSize,
    required this.onPressed,
    this.assetIcon,
    this.borderSide,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final String? assetIcon;
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
          elevation: borderSide == null ? 1 : 0,
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
                child: _SocialButtonIcon(assetIcon: assetIcon, size: iconSize),
              ),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButtonIcon extends StatelessWidget {
  const _SocialButtonIcon({required this.assetIcon, required this.size});

  final String? assetIcon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetIcon!, width: size, height: size);
  }
}
