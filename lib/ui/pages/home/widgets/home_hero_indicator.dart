import 'package:flutter/material.dart';

class HomeHeroIndicator extends StatelessWidget {
  const HomeHeroIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_HeroDot(active: true), _HeroDot(), _HeroDot(), _HeroDot()],
    );
  }
}

class _HeroDot extends StatelessWidget {
  const _HeroDot({this.active = false});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: active ? 1 : 0.4),
        shape: BoxShape.circle,
      ),
    );
  }
}
