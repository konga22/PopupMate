import 'package:flutter/material.dart';

class MapPreviewImage extends StatelessWidget {
  const MapPreviewImage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        width: 80,
        height: 80,
        child: OverflowBox(
          maxWidth: 243,
          maxHeight: 80,
          alignment: Alignment.center,
          child: Image.asset(
            imagePath,
            width: 243,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
