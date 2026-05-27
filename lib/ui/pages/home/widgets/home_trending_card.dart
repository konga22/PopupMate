import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/router/app_page.dart';
import 'home_design_tokens.dart';

class HomeTrendingCard extends StatelessWidget {
  const HomeTrendingCard({
    super.key,
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
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.flame,
                          color: HomeColors.danger,
                          size: 13,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'HOT',
                          style: TextStyle(
                            color: HomeColors.ink,
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
                color: HomeColors.ink,
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
                color: HomeColors.body,
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
