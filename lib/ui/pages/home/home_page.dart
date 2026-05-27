import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/assets/app_assets.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/extensions/spacing_extension.dart';
import '../../common/app_components.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final heroHeight = (480 - MediaQuery.viewPaddingOf(context).top).clamp(
      420,
      480,
    );

    return MainShellPage(
      activeTab: AppTab.home,
      title: 'PopupMate',
      actions: [
        IconButton(
          onPressed: () => context.goNamed(AppPage.search.name),
          icon: const Icon(LucideIcons.search),
        ),
        10.widthBox,
        const CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage(AppAssets.homeProfile),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(AppPage.communityWrite.name),
        backgroundColor: AppColors.ink,
        foregroundColor: Colors.white,
        child: const Icon(LucideIcons.plus),
      ),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 40),
        children: [
          _HeroSection(height: heroHeight.toDouble()),
          const SizedBox(height: 32),
          const _QuickMenu(),
          const SizedBox(height: 32),
          const _TrendingSection(),
          const _ClosingSection(),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => context.pushNamed(
            AppPage.popupDetail.name,
            pathParameters: {'id': 'seongsu-modern-terrace'},
          ),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.homeHero, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54, Colors.black87],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.ink.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'COMING SOON',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  12.heightBox,
                  const Text(
                    '성수동 팝업:\n더 모던 테라스',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  8.heightBox,
                  const Text(
                    '2023.11.24 - 12.10 | 성수역 3번 출구',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickMenu extends StatelessWidget {
  const _QuickMenu();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QuickAction(
            icon: LucideIcons.calendarDays,
            label: '팝업 캘린더',
            route: AppPage.calendar,
          ),
          _QuickAction(
            icon: LucideIcons.navigation,
            label: '내 주변 팝업',
            route: AppPage.map,
          ),
          _QuickAction(
            icon: LucideIcons.map,
            label: '지역별 팝업',
            route: AppPage.search,
          ),
          _QuickAction(
            icon: LucideIcons.shapes,
            label: '장르별 팝업',
            route: AppPage.search,
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.route,
  });
  final IconData icon;
  final String label;
  final AppPage route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(route.name),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.softBorder),
            ),
            child: Icon(icon, color: AppColors.ink, size: 28),
          ),
          8.heightBox,
          Text(
            label,
            style: const TextStyle(
              color: AppColors.body,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendingSection extends StatelessWidget {
  const _TrendingSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SectionHeader(title: '지금 뜨는 팝업', caption: 'Trending Now'),
        ),
        16.heightBox,
        SizedBox(
          height: 300,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: const [
              _TrendingCard(
                image: AppAssets.homeTrendingOne,
                title: '메종 키츠네 카페 팝업',
                area: '가로수길',
              ),
              SizedBox(width: 16),
              _TrendingCard(
                image: AppAssets.homeTrendingTwo,
                title: '아트토이 서울 한정전',
                area: '성수',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({
    required this.image,
    required this.title,
    required this.area,
  });
  final String image;
  final String title;
  final String area;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(image, width: 240, height: 240, fit: BoxFit.cover),
        ),
        12.heightBox,
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          area,
          style: const TextStyle(color: AppColors.muted, fontSize: 13),
        ),
      ],
    );
  }
}

class _ClosingSection extends StatelessWidget {
  const _ClosingSection();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: '종료 임박 팝업', caption: 'Closing Soon'),
          16.heightBox,
          const _ClosingCard(
            image: AppAssets.homeClosingOne,
            title: '나이키 SNKRS 데이',
            dday: 'D-2',
          ),
          const SizedBox(height: 12),
          const _ClosingCard(
            image: AppAssets.homeClosingTwo,
            title: '블루보틀 홀리데이 마켓',
            dday: 'D-1',
          ),
        ],
      ),
    );
  }
}

class _ClosingCard extends StatelessWidget {
  const _ClosingCard({
    required this.image,
    required this.title,
    required this.dday,
  });
  final String image;
  final String title;
  final String dday;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.softBorder),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(image, width: 64, height: 64, fit: BoxFit.cover),
          ),
          16.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                4.heightBox,
                Text(
                  dday,
                  style: const TextStyle(
                    color: AppColors.danger,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
