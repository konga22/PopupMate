import 'package:flutter/material.dart';

class LoginErrorMessage extends StatelessWidget {
  const LoginErrorMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xFFB3261E),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
