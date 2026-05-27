import 'package:flutter/material.dart';

import 'search_result_image.dart';
import 'search_result_location_row.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    super.key,
    required this.title,
    required this.address,
    required this.badge,
    required this.image,
    required this.imageAlignment,
    required this.onTap,
  });

  final String title;
  final String address;
  final String badge;
  final String image;
  final Alignment imageAlignment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchResultImage(
            image: image,
            badge: badge,
            imageAlignment: imageAlignment,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF1C1B1C),
              fontSize: 20,
              height: 1.4,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          SearchResultLocationRow(address: address),
        ],
      ),
    );
  }
}
