import 'package:flutter/material.dart';

import '../theme/app_text.dart';
import '../theme/design_tokens.dart';

/// Badge compacto UPPERCASE. `filled=false` usa fundo tingido (alpha 0.14).
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.text,
    required this.color,
    this.filled = false,
  });

  final String text;
  final Color color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final bg = filled ? color : color.withValues(alpha: 0.14);
    final fg = filled ? Colors.white : color;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: fg,
          fontSize: AppText.s10,
          fontWeight: AppText.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
