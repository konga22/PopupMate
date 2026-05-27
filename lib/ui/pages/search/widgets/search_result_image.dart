import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

class SearchResultImage extends StatelessWidget {
  const SearchResultImage({
    super.key,
    required this.image,
    required this.badge,
    required this.imageAlignment,
  });

  final String image;
  final String badge;
  final Alignment imageAlignment;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          SizedBox(
            height: 197,
            width: double.infinity,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              alignment: imageAlignment,
            ),
          ),
          Positioned(
            right: 16,
            top: 11,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.ink.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  height: 1.33,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
