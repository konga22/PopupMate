import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../../app/theme/app_theme.dart';
import '../../common/app_components.dart';
import 'widgets/community_filter_sheet.dart';
import 'widgets/community_post_list.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  String _category = '전체';

  void _showFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      builder: (context) => const CommunityFilterSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainShellPage(
      activeTab: AppTab.community,
      title: '커뮤니티',
      actions: [
        IconButton(
          onPressed: _showFilterSheet,
          icon: const Icon(LucideIcons.slidersHorizontal),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(AppPage.communityWrite.name),
        backgroundColor: AppColors.ink,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(LucideIcons.penLine),
      ),
      child: CommunityPostList(
        category: _category,
        onCategorySelected: (value) => setState(() => _category = value),
      ),
    );
  }
}
