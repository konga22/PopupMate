import 'package:flutter/material.dart';

import 'map_preview_save_button.dart';
import 'map_preview_waiting_button.dart';

class MapPreviewActions extends StatelessWidget {
  const MapPreviewActions({
    super.key,
    required this.saved,
    required this.onWaitingTap,
    required this.onSaveTap,
  });

  final bool saved;
  final VoidCallback onWaitingTap;
  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: MapPreviewWaitingButton(onTap: onWaitingTap)),
        const SizedBox(width: 8),
        MapPreviewSaveButton(saved: saved, onTap: onSaveTap),
      ],
    );
  }
}
