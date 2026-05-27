import 'package:flutter/material.dart';

import '../../../app/extensions/spacing_extension.dart';
import '../../../services/mock_waiting_service.dart';
import '../../common/app_components.dart';
import 'widgets/waiting_nearby_section.dart';
import 'widgets/waiting_status_summary_card.dart';

class WaitingStatusPage extends StatelessWidget {
  const WaitingStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final waiting = MockWaitingService.status;

    return Scaffold(
      appBar: const AppTopBar(title: '대기 안내', showBack: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          WaitingStatusSummaryCard(waiting: waiting),
          28.heightBox,
          const WaitingNearbySection(),
        ],
      ),
    );
  }
}
