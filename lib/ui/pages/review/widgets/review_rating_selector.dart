import 'package:flutter/material.dart';

import '../../../../app/extensions/spacing_extension.dart';

class ReviewRatingSelector extends StatelessWidget {
  const ReviewRatingSelector({
    super.key,
    required this.rating,
    required this.onChanged,
  });

  final double rating;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('경험은 어떠셨나요?', style: TextStyle(fontWeight: FontWeight.w800)),
        Slider(
          min: 1,
          max: 5,
          divisions: 8,
          value: rating,
          label: rating.toStringAsFixed(1),
          onChanged: onChanged,
        ),
        Center(
          child: Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
        ),
        24.heightBox,
      ],
    );
  }
}
