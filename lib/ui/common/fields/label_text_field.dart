import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/extensions/spacing_extension.dart';
import '../../../app/theme/app_theme.dart';

class LabelTextField extends StatefulWidget {
  const LabelTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.icon,
    this.enableObscure = false,
    this.maxLines = 1,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final bool enableObscure;
  final int maxLines;

  @override
  State<LabelTextField> createState() => _LabelTextFieldState();
}

class _LabelTextFieldState extends State<LabelTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        8.heightBox,
        TextField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          obscureText: widget.enableObscure && _obscure,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: Icon(widget.icon),
            suffixIcon:
                widget.enableObscure
                    ? IconButton(
                      icon: Icon(
                        _obscure ? LucideIcons.eyeClosed : LucideIcons.eye,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}
