import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/extensions/spacing_extension.dart';

class WaitingPeopleStepper extends StatelessWidget {
  const WaitingPeopleStepper({
    super.key,
    required this.people,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int people;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('방문 인원', style: TextStyle(fontWeight: FontWeight.w800)),
        10.heightBox,
        Row(
          children: [
            IconButton(
              onPressed: onDecrease,
              icon: const Icon(LucideIcons.minus),
            ),
            Text('$people', style: const TextStyle(fontSize: 24)),
            IconButton(
              onPressed: onIncrease,
              icon: const Icon(LucideIcons.plus),
            ),
          ],
        ),
      ],
    );
  }
}
