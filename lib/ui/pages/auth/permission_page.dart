import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/extensions/spacing_extension.dart';
import '../../../app/router/app_page.dart';
import '../../common/app_components.dart';
import 'widgets/permission_intro.dart';
import 'widgets/permission_list.dart';
import 'widgets/permission_notice.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PermissionIntro(),
              32.heightBox,
              const PermissionList(),
              const Spacer(),
              const PermissionNotice(),
              16.heightBox,
              PrimaryButton(
                label: '동의하고 시작하기',
                onPressed: () => context.goNamed(AppPage.login.name),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
