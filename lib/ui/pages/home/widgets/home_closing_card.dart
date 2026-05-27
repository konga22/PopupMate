import 'package:flutter/material.dart';

import 'home_design_tokens.dart';

class HomeClosingCard extends StatelessWidget {
  const HomeClosingCard({
    super.key,
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
        color: HomeColors.surfaceAlt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: HomeColors.border),
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
                        color: HomeColors.danger,
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
                        color: HomeColors.body,
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
                    color: HomeColors.ink,
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
                    backgroundColor: HomeColors.border,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      urgent ? HomeColors.danger : HomeColors.title,
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
