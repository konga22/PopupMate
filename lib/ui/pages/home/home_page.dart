import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../app/assets/app_assets.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../common/navigation/app_bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _background = Color(0xFFFCF8F9);
  static const _ink = Color(0xFF1C1B1C);
  static const _title = Color(0xFF393C43);
  static const _body = Color(0xFF45474B);
  static const _surfaceAlt = Color(0xFFF0EDED);
  static const _border = Color(0xFFC6C6CB);
  static const _danger = Color(0xFFBA1A1A);

  @override
  Widget build(BuildContext context) {
    final heroHeight = (MediaQuery.sizeOf(context).height * 0.39).clamp(
      300.0,
      370.0,
    );

    return Scaffold(
      backgroundColor: _background,
      floatingActionButton: _FloatingReportButton(
        onTap: () => context.pushNamed(AppPage.communityWrite.name),
      ),
      bottomNavigationBar: const AppBottomNavBar(activeTab: AppTab.home),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _HomeHeader(),
            Expanded(
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
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            const Text(
              'PopupMate',
              style: TextStyle(
                color: HomePage._title,
                fontSize: 24,
                fontWeight: FontWeight.w400,
                height: 32 / 24,
                letterSpacing: -0.24,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => context.goNamed(AppPage.search.name),
              child: SizedBox(
                width: 32,
                height: 32,
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.homeHeaderSearch,
                    width: 18,
                    height: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () => context.goNamed(AppPage.profile.name),
              child: Container(
                width: 32,
                height: 32,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFE0E2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: HomePage._border),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Image.asset(AppAssets.homeProfile, fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
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
            Image.asset(
              AppAssets.homeHero,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x001C1B1C),
                    Color(0x1A1C1B1C),
                    Color(0xCC1C1B1C),
                  ],
                  stops: [0.0, 0.52, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 52,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF50535A),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'COMING SOON',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 16 / 12,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '성수동 팝업:\n더 모던 테라스',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      height: 40 / 32,
                      letterSpacing: -0.64,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '2023.11.24 - 12.10 | 성수역 3번 출구',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 24 / 16,
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _HeroDot(active: true),
                  _HeroDot(),
                  _HeroDot(),
                  _HeroDot(),
                ],
              ),
            ),
          ],
        ),
      ),
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

class _QuickMenu extends StatelessWidget {
  const _QuickMenu();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 74,
        child: Row(
          children: [
            Expanded(
              child: _QuickAction(
                icon: AppAssets.homeQuickCalendar,
                label: '팝업 캘린더',
                route: AppPage.calendar,
              ),
            ),
            Expanded(
              child: _QuickAction(
                icon: AppAssets.homeQuickNearby,
                label: '내 주변 팝업',
                route: AppPage.map,
              ),
            ),
            Expanded(
              child: _QuickAction(
                icon: AppAssets.homeQuickRegion,
                label: '지역별 팝업',
                route: AppPage.search,
              ),
            ),
            Expanded(
              child: _QuickAction(
                icon: AppAssets.homeQuickGenre,
                label: '장르별 팝업',
                route: AppPage.search,
              ),
            ),
          ],
        ),
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

  final String icon;
  final String label;
  final AppPage route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(route.name),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: HomePage._surfaceAlt,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: SvgPicture.asset(icon, width: 26, height: 26),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: HomePage._ink,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 18 / 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrendingSection extends StatelessWidget {
  const _TrendingSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '지금 뜨는 팝업',
                        style: TextStyle(
                          color: HomePage._ink,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          height: 32 / 24,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '실시간 가장 핫한 장소들을 확인하세요',
                        style: TextStyle(
                          color: HomePage._body,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 24 / 16,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => context.goNamed(AppPage.search.name),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      '전체보기',
                      style: TextStyle(
                        color: HomePage._body,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 416,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                _TrendingCard(
                  image: AppAssets.homeTrendingOne,
                  title: '메종 키츠네 카페 팝업',
                  subtitle: '가로수길 | 11.20 - 12.15',
                ),
                SizedBox(width: 16),
                _TrendingCard(
                  image: AppAssets.homeTrendingTwo,
                  title: '아트토이 서울 한정전',
                  subtitle: '성수 | 11.18 - 12.03',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => context.pushNamed(
            AppPage.popupDetail.name,
            pathParameters: {'id': 'maison-kitsune'},
          ),
      child: SizedBox(
        width: 360,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    image,
                    width: 360,
                    height: 360,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    height: 26,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppAssets.homeHot,
                          width: 10.7,
                          height: 12,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'HOT',
                          style: TextStyle(
                            color: HomePage._ink,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 18 / 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: HomePage._ink,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                height: 28 / 20,
              ),
            ),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: HomePage._body,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 20 / 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClosingSection extends StatelessWidget {
  const _ClosingSection();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 32, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '종료 임박 팝업',
            style: TextStyle(
              color: HomePage._ink,
              fontSize: 24,
              fontWeight: FontWeight.w400,
              height: 32 / 24,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '놓치면 아쉬운 이번 주 마감 팝업',
            style: TextStyle(
              color: HomePage._body,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 24 / 16,
            ),
          ),
          SizedBox(height: 16),
          _ClosingCard(
            image: AppAssets.homeClosingOne,
            dday: 'D-2',
            area: '성수',
            title: '나이키 SNKRS 데이',
            progress: 0.85,
            urgent: false,
          ),
          SizedBox(height: 12),
          _ClosingCard(
            image: AppAssets.homeClosingTwo,
            dday: 'D-1',
            area: '한남',
            title: '블루보틀 홀리데이 마켓',
            progress: 0.95,
            urgent: true,
          ),
        ],
      ),
    );
  }
}

class _ClosingCard extends StatelessWidget {
  const _ClosingCard({
    required this.image,
    required this.dday,
    required this.area,
    required this.title,
    required this.progress,
    required this.urgent,
  });

  final String image;
  final String dday;
  final String area;
  final String title;
  final double progress;
  final bool urgent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HomePage._surfaceAlt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: HomePage._border),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(image, width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      dday,
                      style: const TextStyle(
                        color: HomePage._danger,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 16 / 12,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      area,
                      style: const TextStyle(
                        color: HomePage._body,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 18 / 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: HomePage._ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 24 / 16,
                  ),
                ),
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 4,
                    value: progress,
                    backgroundColor: HomePage._border,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      urgent ? HomePage._danger : HomePage._title,
                    ),
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

class _FloatingReportButton extends StatelessWidget {
  const _FloatingReportButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: HomePage._title,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 50,
              offset: const Offset(0, 25),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            AppAssets.homeFabPlus,
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
