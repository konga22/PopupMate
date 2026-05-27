import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/extensions/spacing_extension.dart';
import '../../../app/router/app_page.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.actions = const [],
  });

  final String title;
  final bool showBack;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      leading:
          showBack
              ? IconButton(
                icon: const Icon(LucideIcons.arrowLeft),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                    return;
                  }

                  context.goNamed(AppPage.home.name);
                },
              )
              : null,
      title: Text(title),
      actions: [...actions, if (actions.isNotEmpty) 12.widthBox],
    );
  }
}
