import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../models/waiting_models.dart';
import '../../../common/app_components.dart';

class WaitingStatusMetrics extends StatelessWidget {
  const WaitingStatusMetrics({super.key, required this.waiting});

  final WaitingStatus waiting;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MetricTile(
          label: '현재 대기',
          value: '${waiting.currentTeams}',
          icon: LucideIcons.users,
        ),
        12.widthBox,
        MetricTile(
          label: '예상 시간',
          value: '${waiting.estimatedMinutes}',
          icon: LucideIcons.clock,
        ),
      ],
    );
  }
}
