import 'package:flutter/material.dart';

import '../theme/app_text.dart';
import '../theme/design_tokens.dart';

/// Badge compacto UPPERCASE. `filled=false` usa fundo tingido (alpha 0.14).
class PrimeBadge extends StatelessWidget {
  const PrimeBadge({
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
        horizontal: PrimeSpacing.sm + 2,
        vertical: PrimeSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(PrimeRadius.xs),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: fg,
          fontSize: PrimeText.s10,
          fontWeight: PrimeText.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
