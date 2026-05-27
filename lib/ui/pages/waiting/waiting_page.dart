import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/extensions/context_extension.dart';
import '../../../app/extensions/spacing_extension.dart';
import '../../../app/router/app_page.dart';
import '../../../services/mock_waiting_service.dart';
import '../../common/app_components.dart';
import 'widgets/waiting_registration_form.dart';
import 'widgets/waiting_status_metrics.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  final _phoneController = TextEditingController(text: '010-0000-0000');
  int _people = 2;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_phoneController.text.trim().isEmpty) {
      context.showSnackbar('휴대폰 번호를 입력해주세요.', isError: true);
      return;
    }
    context.goNamed(AppPage.waitingStatus.name);
  }

  void _decreasePeople() {
    setState(() => _people = (_people - 1).clamp(1, 6));
  }

  void _increasePeople() {
    setState(() => _people = (_people + 1).clamp(1, 6));
  }

  @override
  Widget build(BuildContext context) {
    final waiting = MockWaitingService.status;

    return Scaffold(
      appBar: const AppTopBar(title: '대기 등록', showBack: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          WaitingStatusMetrics(waiting: waiting),
          28.heightBox,
          WaitingRegistrationForm(
            people: _people,
            phoneController: _phoneController,
            onDecreasePeople: _decreasePeople,
            onIncreasePeople: _increasePeople,
            onSubmit: _onSubmit,
          ),
        ],
      ),
    );
  }
}
