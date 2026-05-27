import 'dart:ui';

import 'package:flutter/material.dart';

class LoginBackgroundGlow extends StatelessWidget {
  const LoginBackgroundGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}
